import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:impromptu_project/extras/functions.dart';

class AudioController extends ChangeNotifier {
  AudioPlayer audioPlayer;
  String url = "";
  int total = 1;
  String time = "00:00";
  PlayerState playerState = PlayerState.stopped;
  bool isDisposed = false;

  // bool _isShimmer = false;

  AudioController({required this.audioPlayer, required this.url}) {
    duration = audioPlayer.onPositionChanged.listen((event) async {
      if (url != Functions.currentUrl) {
        completed = 0;
      } else {
        if (audioPlayer.state == PlayerState.playing) {
          Duration? duration = await audioPlayer.getDuration();
          total = duration?.inSeconds ?? 0;
        }

        completed = event.inSeconds / total;

        String minutes = (event.inSeconds ~/ 60).toString();
        String seconds = (event.inSeconds % 60).toString().padLeft(2, '0');

        time = '${minutes.padLeft(2, '0')}:$seconds';
      }

      if (!isDisposed) {
        notifyListeners();
      }
    });
    audioPlayer.onPlayerStateChanged.listen((s) {
      if (url != Functions.currentUrl) {
        playerState = PlayerState.stopped;
      } else {
        playerState = s;
      }

      if (!isDisposed) {
        if (url == Functions.currentUrl) {
          notifyListeners();
        }
      }
    });
  }

  StreamSubscription<Duration>? duration;

  double completed = 0;

  @override
  void dispose() {
    duration?.cancel();
    isDisposed = true;
    super.dispose();
  }
}
