import 'dart:io';
import 'package:flutter/material.dart';
import 'package:impromptu_project/data_provider/dashboard_provider.dart';
import 'package:impromptu_project/extras/extensions.dart';
import 'package:impromptu_project/extras/functions.dart';
import 'package:impromptu_project/screens/dashboard/practise/origional_transcript.dart';
import 'package:impromptu_project/widgets/audio_progress.dart';
import 'package:impromptu_project/widgets/custom_text.dart';
import 'package:impromptu_project/widgets/dashboard_background.dart';
import 'package:impromptu_project/widgets/margin_widget.dart';
import 'package:impromptu_project/widgets/record_widget.dart';
import 'package:impromptu_project/widgets/primary_button.dart';
import 'package:impromptu_project/widgets/refresh_button.dart';
import 'package:provider/provider.dart';

class PractiseQuestion extends StatefulWidget {
  final String? difficulty;


  const PractiseQuestion({super.key, this.difficulty});

  @override
  _PractiseQuestionState createState() => _PractiseQuestionState();
}

class _PractiseQuestionState extends State<PractiseQuestion> {
  late double originalSize = 166;

  String recordPath = "";

  late DashboardProvider provider;


  @override
  Widget build(BuildContext context) {
    provider = Provider.of<DashboardProvider>(context);


    return Scaffold(
      body: DashboardBackground(
        childWidget: Padding(
          padding: const EdgeInsets.all(35),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const MarginWidget(factor: 4),
                RefreshButton(provider: provider),
                if (widget.difficulty == null) ...[
                  CustomText(
                    text: "Today's challenge",
                    size: 23,
                    weight: FontWeight.w900,
                  ),
                ] else ...[
                  CustomText(text: widget.difficulty!, size: 20),
                ],
                const MarginWidget(factor: 0.5),
                questionStr(),
                recordSound(),
                if (recordPath.isEmpty && provider.isRecording == false) ...[
                  CustomText(
                    text: "Hold the button to start recording",
                    size: 23,
                  ),
                  const MarginWidget(factor: 2),
                ] else if (provider.isRecording) ...[
                  CustomText(
                    text: provider.countDown,
                    size: 65,
                    weight: FontWeight.w500,
                  ),
                  const MarginWidget(factor: 2),
                ],
                if (recordPath.isNotEmpty && provider.isRecording == false) ...[
                  AudioProgress(filePath: recordPath),
                  const MarginWidget(factor: 2),
                ],
                PrimaryButton(
                    onPressed: () async {
                      if (recordPath.isNotEmpty) {
                        var audioFile;
                        if (Platform.isIOS) {
                          audioFile = File.fromUri(Uri.parse(recordPath));
                        } else {
                          audioFile = File(
                              recordPath); // Replace with the path to your audio file
                        }



                        context.push(
                            child: OriginalTranscript(
                          question: getDummyQuestion(),
                          difficulty: widget.difficulty ?? "Hard",
                          recordPath: recordPath,
                        ));

                      } else {
                        Functions.showSnackBar(context, "Please Record first");
                      }
                    },
                    text: "Continue",
                    textColor: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget questionStr() {

    return CustomText(text: getDummyQuestion(), weight: FontWeight.w700, size: 23);
  }

  String getDummyQuestion() {
    switch (widget.difficulty?.toLowerCase() ?? "easy") {
      case 'easy':
        return 'Describe your favorite hobby.';
      case 'medium':
        return 'Explain the process of making a sandwich.';
      case 'hard':
        return 'Discuss the impact of technology on modern society.';
      default:
        return 'Unknown question';
    }
  }

  Widget recordSound() {
    return Container(
      height: 270,
      width: double.infinity,
      alignment: Alignment.center,
      child: RecordWidget(
        callBack: (value) {
          return recordPath = value;
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
