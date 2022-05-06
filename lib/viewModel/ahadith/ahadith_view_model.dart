import 'package:flutter/cupertino.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quran_karim/viewModel/ahadith/states.dart';

import '../../model/error_result.dart';
import '../../model/hadith/Hadith.dart';
import '../../reposibility/hadith/local_service.dart';

class AhadithViewModel extends ChangeNotifier {
  late AhadithStates states;
  late AhadithOnRefreshState refreshState;
  late AhadithOnLoadState loadState;

  AhadithViewModel() {
    states = AhadithStates.Inital;
    refreshState = AhadithOnRefreshState.OnRefreshInitialState;
    loadState = AhadithOnLoadState.OnLoadInitialState;
  }

  final AhadithLocalService _service = AhadithLocalService();

  List<Hadith>? _ahadith;

  List<Hadith> get ahadith => _ahadith!;

  ErrorResult? _error;

  ErrorResult get error => _error!;

  List<Hadith>? _ahadithDisplayed;

  List<Hadith> get ahadithDisplayed => _ahadithDisplayed!;

  String? _refreshError;

  String get refreshError => _refreshError!;

  int page = 1;

  Future<void> getAhadith(BuildContext context) async {
    states = AhadithStates.Loading;
    notifyListeners();
    await _service.getAhadith(context: context).then((value) {
      value.fold((left) {
        _ahadith = left.getRange(0, 11).toList();
        _ahadithDisplayed = _ahadith;
        states = AhadithStates.Loaded;
      }, (right) {
        _error = right;
        states = AhadithStates.Error;
      });
    });
    notifyListeners();
  }

  Future<void> onRefresh(BuildContext context,
      {required RefreshController refreshController}) async {
    await Future.delayed(const Duration(seconds: 2));
    try {
      await _service.getAhadith(context: context).then((value) {
        value.fold((left) {
          _ahadith!.clear();
          page = 1;
          _ahadith = left.getRange(0, 11).toList();
          _ahadithDisplayed = _ahadith;
          refreshController.refreshCompleted();
          refreshState = AhadithOnRefreshState.OnRefreshSuccessState;
        }, (right) {
          _error = right;
          refreshController.refreshFailed();
          refreshState = AhadithOnRefreshState.OnRefreshErrorState;
        });
      });
    } catch (exception) {
      _refreshError = 'error'.tr();
      refreshController.refreshFailed();
      refreshState = AhadithOnRefreshState.OnRefreshErrorState;
    }
    notifyListeners();
  }

  Future<void> onLoad(BuildContext context,
      {required RefreshController controller}) async {
    if (page >= 1 && page < 5) {
      page += 1;
      try {
        await _service.getAhadith(context: context).then((value) {
          value.fold((left) async {
            _ahadith!.addAll(page == 2
                ? left.getRange(11, 21).toList()
                : page == 3
                    ? left.getRange(21, 31).toList()
                    : page == 4
                        ? left.getRange(31, 41).toList()
                        : left.getRange(41, 48).toList());
            _ahadithDisplayed = _ahadith;
            await Future.delayed(const Duration(seconds: 2));
            controller.loadComplete();
            loadState = AhadithOnLoadState.OnLoadSuccessState;
          }, (right) {
            controller.loadFailed();
            _refreshError = 'error'.tr();
            loadState = AhadithOnLoadState.OnLoadErrorState;
          });
        });
      } catch (onLoadException) {
        _refreshError = 'error'.tr();
        controller.loadFailed();
        loadState = AhadithOnLoadState.OnLoadErrorState;
      }
    } else {
      _refreshError = 'load_error'.tr();
      controller.loadFailed();
      loadState = AhadithOnLoadState.OnLoadErrorState;
    }
    notifyListeners();
  }

  void searchQuery(String searchKey) {
    searchKey = searchKey.toLowerCase();
    _ahadithDisplayed = _ahadith!.where((element) {
      var searchTerm = element.searchTerm.toLowerCase();
      return searchTerm.contains(searchKey);
    }).toList();
    notifyListeners();
  }

  void clearSearchTerms() {
    _ahadithDisplayed = _ahadith;
    notifyListeners();
  }

  void disposeData() {
    _ahadith!.clear();
    _ahadithDisplayed!.clear();
    page = 1;
  }
}
