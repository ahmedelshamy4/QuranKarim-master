import 'package:flutter/cupertino.dart';
import 'package:quran_karim/viewModel/azkar/states.dart';

import '../../model/azkar/azkar_category.dart';
import '../../model/azkar/azkar_details.dart';
import '../../model/error_result.dart';
import '../../reposibility/azkar/local_services.dart';

class AzkarViewModel extends ChangeNotifier {
  late AzkarCategoriesStates categoriesStates;
  late AzkarDetailsStates detailsStates;

  AzkarViewModel() {
    categoriesStates = AzkarCategoriesStates.Initial;
    detailsStates = AzkarDetailsStates.Initial;
  }

  final AzkarLocalService _service = AzkarLocalService();

  List<AzkarCategory>? _categories;

  List<AzkarCategory> get categories => _categories!;

  List<AzkarDetails>? _azkarDetails;

  List<AzkarDetails> get azkarDetails => _azkarDetails!;

  ErrorResult? _error;

  ErrorResult get error => _error!;

  Future<void> getCategories(BuildContext context) async {
    categoriesStates = AzkarCategoriesStates.Loading;
    await _service.getAzkarCategories(context: context).then((value) {
      value.fold((left) {
        _categories = left;
        categoriesStates = AzkarCategoriesStates.Loaded;
      }, (right) {
        _error = right;
        categoriesStates = AzkarCategoriesStates.Error;
      });
    });
    notifyListeners();
  }

  Future<void> getAzkarDetails(BuildContext context,
      {required int categoryId}) async {
    _azkarDetails = [];
    detailsStates = AzkarDetailsStates.Loading;
    await _service
        .getAzkarDetails(context: context, categoryId: categoryId)
        .then((value) {
      value.fold((left) {
        for (var item in left) {
          if (item.category_id == categoryId) {
            _azkarDetails!.add(item);
          }
        }
        detailsStates = AzkarDetailsStates.Loaded;
        notifyListeners();
      }, (right) {
        _error = right;
        detailsStates = AzkarDetailsStates.Error;
      });
    });
    notifyListeners();
  }

  void disposeData() {
    _azkarDetails!.clear();
  }
}
