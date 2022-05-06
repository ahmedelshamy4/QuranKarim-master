import 'package:flutter/cupertino.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quran_karim/viewModel/assmaa_allah/states.dart';

import '../../model/assmaa_allah.dart';
import '../../model/error_result.dart';
import '../../reposibility/assmaa_allah/local_services.dart';

class AssmaaAllahViewModel extends ChangeNotifier {
  late AssmaaAllahStates states;
  late AssmaaAllahOnRefreshState refreshState;
  late AssmaaAllahOnLoadState loadState;

  AssmaaAllahViewModel() {
    states = AssmaaAllahStates.Initial;
    AssmaaAllahOnRefreshState.OnRefreshInitialState;
    loadState = AssmaaAllahOnLoadState.OnLoadInitialState;
  }

  List<AssmaaAllah>? _assmaaAllah;

  List<AssmaaAllah> get assmaaAllah => _assmaaAllah!;

  ErrorResult? _error;

  ErrorResult get error => _error!;

  String? _refreshError;

  String get refreshError => _refreshError!;

  int page = 1;

  final AssmaaAllahLocalService _service = AssmaaAllahLocalService();

  Future<void> getAssmaaAllahAlhosna(BuildContext context) async {
    states = AssmaaAllahStates.Loading;
    notifyListeners();
    await _service.getAssmaaAllahAlhosna(context: context).then((value) {
      value.fold((left) {
        _assmaaAllah = left.getRange(0, 21).toList();
        states = AssmaaAllahStates.Loaded;
      }, (right) {
        _error = right;
        states = AssmaaAllahStates.Error;
      });
    });
    notifyListeners();
  }

  Future<void> onRefresh(BuildContext context,
      {required RefreshController refreshController}) async {
    await Future.delayed(const Duration(seconds: 2));
    try {
      await _service.getAssmaaAllahAlhosna(context: context).then((value) {
        value.fold((left) {
          _assmaaAllah!.clear();
          page = 1;
          _assmaaAllah = left.getRange(0, 21).toList();
          refreshController.refreshCompleted();
          refreshState = AssmaaAllahOnRefreshState.OnRefreshSuccessState;
        }, (right) {
          _error = right;
          refreshController.refreshFailed();
          refreshState = AssmaaAllahOnRefreshState.OnRefreshErrorState;
        });
      });
    } catch (exception) {
      _refreshError = 'error'.tr();
      refreshController.refreshFailed();
      refreshState = AssmaaAllahOnRefreshState.OnRefreshErrorState;
    }
    notifyListeners();
  }

  Future<void> onLoad(BuildContext context,
      {required RefreshController controller}) async {
    if (page >= 1 && page < 5) {
      page += 1;
      try {
        await _service.getAssmaaAllahAlhosna(context: context).then((value) {
          value.fold((left) async {
            _assmaaAllah!.addAll(page == 2
                ? left.getRange(21, 41).toList()
                : page == 3
                    ? left.getRange(41, 61).toList()
                    : page == 4
                        ? left.getRange(61, 81).toList()
                        : left.getRange(81, 99).toList());

            await Future.delayed(const Duration(seconds: 2));
            controller.loadComplete();
            loadState = AssmaaAllahOnLoadState.OnLoadSuccessState;
          }, (right) {
            controller.loadFailed();
            _refreshError = 'error'.tr();
            loadState = AssmaaAllahOnLoadState.OnLoadErrorState;
          });
        });
      } catch (onLoadException) {
        _refreshError = 'error'.tr();
        controller.loadFailed();
        loadState = AssmaaAllahOnLoadState.OnLoadErrorState;
      }
    } else {
      _refreshError = 'load_error'.tr();
      controller.loadFailed();
      loadState = AssmaaAllahOnLoadState.OnLoadErrorState;
    }
    notifyListeners();
  }

  void disposeData() {
    _assmaaAllah!.clear();
    page = 1;
  }
}
