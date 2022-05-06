import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quran_karim/reposibility/quran/local_service.dart';
import 'package:quran_karim/reposibility/quran/remote_service.dart';
import 'package:quran_karim/utils/helper/cache_helper.dart';
import 'package:quran_karim/viewModel/quran/states.dart';

import '../../model/error_result.dart';
import '../../model/surah/surah.dart';
import '../../utils/constant/cache_key.dart';

class QuranViewModel extends ChangeNotifier {
  late QuranGetRemoteDataStates remoteDataStates;
  late QuranGetLocalDataStates getLocalDataStates;
  late QuranGetCachedDataStates cachedDataStates;

  QuranViewModel() {
    remoteDataStates = QuranGetRemoteDataStates.Initial;
    getLocalDataStates = QuranGetLocalDataStates.Initial;
    cachedDataStates = QuranGetCachedDataStates.Initial;
  }

//resposibility
  QuranRemoteService _remoteService = QuranRemoteService();
  QuranLocalService _localService = QuranLocalService();

  ErrorResult? _error;
  ErrorResult? get error => _error!;

  List<Surah>? _quranData;
  List<Surah>? get quranData => _quranData;

  Surah? _cachedSurah;
  Surah? get cachedSurah => _cachedSurah;

  Future<void> getRemoteData() async {
    remoteDataStates = QuranGetRemoteDataStates.Loading;
    notifyListeners();
    await _remoteService.getQuranData().then((value) {
      value.fold((left) {
        CacheHelper.setBooleanData(key: isCachingQuran, value: true);
        _localService.cachingQuranData(data: left);
        remoteDataStates = QuranGetRemoteDataStates.Loaded;
      }, (right) {
        _error = right;
        remoteDataStates = QuranGetRemoteDataStates.Error;
      });
    });
    notifyListeners();
  }

  Future<void> getLocalData() async {
    getLocalDataStates = QuranGetLocalDataStates.Loading;
    notifyListeners();
    await _localService.getQuranData().then((value) {
      value.fold((left) {
        _quranData = left;
        getLocalDataStates = QuranGetLocalDataStates.Loaded;
      }, (right) {
        _error = right;
        getLocalDataStates = QuranGetLocalDataStates.Error;
      });
    });
    notifyListeners();
  }

  Future<void> getSurahData() async {
    await _localService
        .getSurahData(CacheHelper.getIntData(key: isCachingSurahText) ?? 1)
        .then((value) {
      value.fold((left) {
        _cachedSurah = left;
        cachedDataStates = QuranGetCachedDataStates.Loaded;
      }, (right) {
        _error = right;
        cachedDataStates = QuranGetCachedDataStates.Error;
      });
    });
    notifyListeners();
  }

  Future<void> cachingSurah({required int surahId}) async {
    await CacheHelper.setIntData(key: isCachingSurahText, value: surahId);
  }

  void disposeData() async {
    Box<Surah> box = await Hive.openBox<Surah>(quranResponse);
    _quranData!.clear();
    box.close();
  }
}
