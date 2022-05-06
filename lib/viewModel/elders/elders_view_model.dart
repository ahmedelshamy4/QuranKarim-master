import 'package:flutter/material.dart';
import 'package:quran_karim/viewModel/elders/states.dart';

import '../../model/elder/elder.dart';
import '../../model/error_result.dart';
import '../../reposibility/elder/local_service.dart';

class EldersViewModel extends ChangeNotifier {
  late EldersStates states;

  EldersViewModel() {
    states = EldersStates.Initial;
  }

  EldersLocalService _service = EldersLocalService();
  List<Elder>? _elders;

  List<Elder> get elders => _elders!;

  ErrorResult? _error;

  ErrorResult get error => _error!;

  Future<void> getElders(BuildContext context) async {
    states = EldersStates.Loading;
    await _service.getElders(context: context).then((value) {
      value.fold((left) {
        _elders = left;
        states = EldersStates.Loaded;
      }, (right) {
        _error = right;
        states = EldersStates.Error;
      });
    });
    notifyListeners();
  }
}
