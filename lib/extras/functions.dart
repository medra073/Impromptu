import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'colors.dart';
import 'package:intl/intl.dart';

class Functions {
  static final AudioPlayer audioPlayer = AudioPlayer();
  static String currentUrl = "";

  static Future<void> playMusic(String url, {bool isUrl = true}) async {
    if (audioPlayer.state == PlayerState.playing) {
      await audioPlayer.pause();
    }

    currentUrl = url;

    if (isUrl) {
      await audioPlayer.play(UrlSource(url));
    } else {
      await audioPlayer.play(DeviceFileSource(url));
    }
  }

  static Future<void> pauseMusic() async {
    await audioPlayer.pause();
  }

  static showSnackBar(BuildContext context, String message) {
    Get.rawSnackbar(
      message: message,
      backgroundColor: CColors.primary,
    );
  }

  static showLoaderDialog(BuildContext context, {String text = 'Loading'}) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: CColors.primary,
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Text(
                "$text...",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static String removeExtraNewLines(String text) {
    return text.trim().replaceAll("\t", "");
  }

  static String formatDate(DateTime dateTime) {
    return DateFormat('MMMM d\'th\', y - h:mma').format(dateTime);
  }

  static String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');

    if (remainingSeconds.length < 2) {
      return '$minutes:0$remainingSeconds';
    } else {
      return '$minutes:$remainingSeconds';
    }
  }
}
