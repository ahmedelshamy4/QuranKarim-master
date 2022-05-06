import 'package:flutter/cupertino.dart';
import 'package:quran_karim/model/elder/elder.dart';
import 'package:quran_karim/utils/helper/cache_helper.dart';
import 'package:quran_karim/viewModel/surah_audio/states.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import '../../model/error_result.dart';
import '../../model/surah/surah.dart';
import '../../model/surah_audio.dart';
import '../../reposibility/surah_audio/remote_services.dart';
import '../../utils/constant/cache_key.dart';

class AudioViewModel extends ChangeNotifier {
  late AudioDataStates audioDataStates;
  late PlayState playState;

  AudioViewModel() {
    audioDataStates = AudioDataStates.Initial;
    playState = PlayState.Initial;
  }

  final SurahAudioRemoteService _service = SurahAudioRemoteService();
  final AssetsAudioPlayer player = AssetsAudioPlayer();

  List<AyahAudio>? _surahAudio;

  List<AyahAudio> get surahAudio => _surahAudio!;

  ErrorResult? _error;

  ErrorResult get error => _error!;

  List<Surah>? _displayQuranData;

  List<Surah> get displayQuranData => _displayQuranData!;

  Surah? _surah;

  Surah get surah => _surah!;

  bool openedAudio = false;
  bool isPlaying = false;

  Future<void> getSurahAudio(
      {required int surahId, required String elderFormat}) async {
    audioDataStates = AudioDataStates.Loading;
    notifyListeners();
    await _service
        .getSurahAudio(surahId: surahId, elderFormat: elderFormat)
        .then((value) {
      value.fold((left) {
        _surahAudio = left;
        CacheHelper.setIntData(key: isCachingSurahAudio, value: surahId);
        audioDataStates = AudioDataStates.Loaded;
      }, (right) {
        _error = right;
        audioDataStates = AudioDataStates.Error;
      });
    });
    notifyListeners();
  }

  Future<void> selectSurah({int? id, required String elderFormat}) async {
    player.stop();
    isPlaying = false;
    for (var item in displayQuranData) {
      if (item.number == id) {
        _surah = item;
      }
    }
    await getSurahAudio(elderFormat: elderFormat, surahId: id!).then((value) {
      if (audioDataStates == AudioDataStates.Error) {
        for (var item in displayQuranData) {
          if (item.number == CacheHelper.getIntData(key: isCachingSurahAudio)) {
            _surah = item;
          }
        }
      }
      notifyListeners();
    });
    notifyListeners();
  }

  void initializeQuranData(List<Surah> data) {
    _displayQuranData = data;
  }

  void isOpenedAudio() {
    openedAudio = true;
    notifyListeners();
  }

  void playSurahAudio() async {
    isPlaying = !isPlaying;
    playState = PlayState.Playing;
    try {
      await player.open(
        Playlist(
          audios: _surahAudio!
              .map((e) => Audio.network(
                    e.audio,
                    metas: Metas(
                      title: "استماع القرآن",
                      artist: _surah!.name,
                      album: _surah!.revelationType,
                      image: const MetasImage.asset(
                        "assets/images/grad_logo.png",
                      ), //can be MetasImage.network
                    ),
                  ))
              .toList(),
          startIndex: 0,
        ),
        loopMode: LoopMode.playlist,
        showNotification: true,
        notificationSettings: const NotificationSettings(
          playPauseEnabled: true,
          stopEnabled: true,
          nextEnabled: true,
          prevEnabled: true,
        ),
      );
    } catch (audioException) {
      isPlaying = false;
      playState = PlayState.Initial;
    }
    listenOnAudioStates();
    notifyListeners();
  }

  void listenOnAudioStates() {
    player.playerState.listen((state) {
      if (state == PlayerState.stop) {
        isPlaying = false;
        playState = PlayState.Ended;
      }
      notifyListeners();
    });
  }

  Future<void> pauseAudio() async {
    await player.playOrPause();
    isPlaying = !isPlaying;
    playState = PlayState.Paused;
    notifyListeners();
  }

  Future<void> stopAudio() async {
    await player.stop();
  }

  void disposeData() {
    stopAudio();
    openedAudio = false;
    isPlaying = false;
    _surah = null;
    _displayQuranData!.clear();
  }
}
