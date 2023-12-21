import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

class Settings {
  AudioPlayer audioPlayer = AudioPlayer();
  ValueNotifier<bool> godMode = ValueNotifier(false);
  ValueNotifier<bool> soundOn = ValueNotifier(true);
  ValueNotifier<bool> musicOn = ValueNotifier(true);
  int godModeDepth = 3;
  int normalDepth = 2;

  void playSound() {
    audioPlayer.setAsset('assets/music/opening.mp3');
    audioPlayer.setLoopMode(LoopMode.one);
    audioPlayer.play();
  }

  void toggleMusic() {
    musicOn.value = !musicOn.value;
    if (musicOn.value) {
      audioPlayer.play();
    } else {
      audioPlayer.pause();
    }
  }

  void toggleSound() {
    soundOn.value = !soundOn.value;
    audioPlayer.setVolume(soundOn.value ? 1 : 0);
  }

  void toggleGodMode() {
    godMode.value = !godMode.value;
  }

  int getDepth() {
    return godMode.value ? godModeDepth : normalDepth;
  }
}
