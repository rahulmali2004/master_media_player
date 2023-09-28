import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoController extends ChangeNotifier {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  List<String> myVideos = [
    "assets/videos/Salaar.mp4",
    "assets/videos/Salaar.mp4",
  ];

  VideoController() {
    init();
  }

  init({int index = 0}) {
    videoPlayerController = VideoPlayerController.asset(
      myVideos[index],
    )..initialize().then(
        (value) {
          debugPrint("Initilized=======================>>>>>>>>>>>>>>>");
          chewieController = ChewieController(
            videoPlayerController: videoPlayerController,
            aspectRatio: videoPlayerController.value.aspectRatio,
            autoPlay: false,
          );
          notifyListeners();
        },
      ).catchError(
        (error) {
          debugPrint("ERROR: ${error.toString()}=====================!!!!!!!");
        },
      );
  }

  changeIndex({required int index}) {
    videoPlayerController.pause();
    chewieController.pause();
    init(index: index);
  }

  play() async {
    await videoPlayerController.play();
    notifyListeners();
  }

  pause() async {
    await videoPlayerController.pause();
    notifyListeners();
  }
}
