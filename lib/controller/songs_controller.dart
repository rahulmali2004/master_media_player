import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import '../views/uttils/music_utils.dart';

class audio_controller extends ChangeNotifier {
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

  Duration totalDuration = Duration.zero;

  audio_controller() {
    init();
  }
  init({int index = 0}) {
    assetsAudioPlayer
        .open(
            Audio(
              music_path + all_music.musics[index]['audio'].toString(),
              metas: Metas(
                title: all_music.musics[index]['title'],
                image: MetasImage.asset(
                  thubnail_path + all_music.musics[index]['thumbnail'],
                ),
              ),
            ),
            autoStart: false,
            showNotification: true)
        .then(
      (value) {
        totalDuration = assetsAudioPlayer.current.value!.audio.duration;
        notifyListeners();
      },
    );
  }

  get_index({required int index}) {
    init(index: index);
  }

  play() async {
    await assetsAudioPlayer.play();
    notifyListeners();
  }

  seek({required int secondes}) async {
    await assetsAudioPlayer.seek(Duration(seconds: secondes));
    notifyListeners();
  }

  pause() async {
    await assetsAudioPlayer.pause();
    notifyListeners();
  }

  get isplaying {
    return assetsAudioPlayer.isPlaying.value;
  }

  get currentposition {
    return assetsAudioPlayer.currentPosition;
  }

  skip({required int seconds}) async {
    assetsAudioPlayer.seekBy(Duration(seconds: seconds));
  }
}
