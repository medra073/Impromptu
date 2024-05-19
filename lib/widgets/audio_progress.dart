import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:impromptu_project/data_provider/audio_controller.dart';
import 'package:impromptu_project/data_provider/dashboard_provider.dart';
import 'package:impromptu_project/extras/functions.dart';
import 'package:impromptu_project/widgets/rounded_progress_bar.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../extras/colors.dart';
import 'custom_text.dart';
import 'margin_widget.dart';

class AudioProgress extends StatefulWidget {
  const AudioProgress({
    Key? key,
    this.isReview = false,
    this.question,
    this.filePath,
    this.url,
  }) : super(key: key);

  final bool isReview;
  final String? filePath;
  final String? url;
  final String? question;


  @override
  _AudioProgressState createState() => _AudioProgressState();
}

class _AudioProgressState extends State<AudioProgress> {
  late DashboardProvider provider;

  String url = "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3";
  late Widget childWidget;
  String? currentAudioUrl;

  // PlayerState playerState = PlayerState.stopped;
  late AudioController controller;

  bool isShimmer = false;

  @override
  void initState() {
    super.initState();

    Functions.audioPlayer.onPlayerStateChanged.listen((s) {
      if (Functions.audioPlayer.state == PlayerState.playing) {
        if (mounted) {
          setState(() {
            isShimmer = false;
          });
        }
      }
    });

  }

  @override
  Widget build(BuildContext context) {

    provider = Provider.of<DashboardProvider>(context);


    return ChangeNotifierProvider(
      create: (ctx) => AudioController(
          audioPlayer: Functions.audioPlayer,
          url: widget.filePath ?? widget.url ?? url),
      child: Consumer<AudioController>(builder: (context, value, child) {

        controller = value;

        if (widget.filePath != null) {
          return audioControls(value);
        }
        return (!isShimmer) ? audioControls(value) : shimmerWidget();
      }),
    );
  }

  Widget audioControls(AudioController value) {
    return Column(
      children: [
        Row(
          children: [
            playIcon(),
            const MarginWidget(isHorizontal: true, factor: 1.3),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: RoundedLinearProgressIndicator(
                  value: value.completed,
                  valueColor: CColors.purple,
                  backgroundColor: CColors.lightGrey,
                  minHeight: 13,
                ),
              ),
            ),
          ],
        ),
        if (!widget.isReview) ...[
          Align(
            alignment: Alignment.bottomRight,
            child: CustomText(
              text: value.time,
              weight: FontWeight.w500,
              size: 15,
            ),
          ),
        ],
      ],
    );
  }

  Widget shimmerWidget() {
    return SizedBox(
      height: 10,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: Container(
          height: 10,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }

  Widget playIcon() {
    return InkWell(
      onTap: () async {


        if (!(widget.filePath == null && widget.url == null)) {
          if (controller.playerState != PlayerState.playing) {
            setState(() {
              isShimmer = true;
            });
            Functions.playMusic(widget.filePath ?? widget.url ?? url,
                isUrl: widget.filePath != null ? false : true);
          } else {
            Functions.pauseMusic();
            setState(() {
              isShimmer = false;
            });
          }
        }
      },
      child: Container(
        height: 30,
        width: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.isReview == false ? CColors.darkBlue : Colors.white,
        ),
        child: Icon(
          controller.playerState != PlayerState.playing
              ? Icons.play_arrow
              : Icons.pause,
          color: widget.isReview == false ? Colors.white : CColors.darkBlue,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
