import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:quran_karim/viewModel/radio/states.dart';

class RadioViewModel extends ChangeNotifier {
  late RadioStates states;

  RadioViewModel() {
    states = RadioStates.Initial;
  }

  final String streamUrl =
      'https://n06.radiojar.com/8s5u5tpdtwzuv?fbclid=IwAR3lf6Nuf5RtC9Z3TjVFroVbugA8vVOo_PmY9ohGrsXWJKrg9B4rn_v-dYE&rj-tok=AAABgDMkq6AAvkhw1FCNhuruXA&rj-ttl=5';

  Future<void> playRadio(AssetsAudioPlayer assetsAudioPlayer) async {
    states = RadioStates.Loading;
    try {
      await assetsAudioPlayer.open(
        Audio.liveStream(streamUrl),
        showNotification: true,
        notificationSettings: const NotificationSettings(
          playPauseEnabled: true,
          stopEnabled: true,
          nextEnabled: false,
          prevEnabled: false,
        ),
      );
      states = RadioStates.Success;
    } catch (audioException) {
      states = RadioStates.Error;
    }
    notifyListeners();
  }
}
