import 'dart:math';
import 'package:flutter/material.dart';
import 'package:impromptu_project/data_provider/dashboard_provider.dart';
import 'package:impromptu_project/extras/app_assets.dart';
import 'package:impromptu_project/extras/app_text_styles.dart';
import 'package:impromptu_project/extras/extensions.dart';
import 'package:impromptu_project/extras/functions.dart';
import 'package:impromptu_project/screens/dashboard/practise/origional_transcript.dart';
import 'package:impromptu_project/screens/dashboard/review/difficulty_label.dart';
import 'package:impromptu_project/widgets/audio_progress.dart';
import 'package:impromptu_project/widgets/custom_image.dart';
import 'package:impromptu_project/widgets/margin_widget.dart';
import 'package:impromptu_project/widgets/primary_button.dart';
import 'package:provider/provider.dart';
import '../../../extras/colors.dart';
import '../../../widgets/custom_text.dart';

class ReviewCard extends StatefulWidget {
  const ReviewCard({
    super.key,
  });

  @override
  _ReviewCardState createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  bool hideAudio = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          hideAudio = !hideAudio;
        });
        if (hideAudio) {
          Functions.pauseMusic();
        }
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            header(),
            feedback(context),
          ],
        ),
      ),
    );
  }

  Widget feedback(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
          color: CColors.darkBlue),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 12, right: 12, top: 15, bottom: 15),
        child: Column(
          children: [
            CustomText(
              text: "Do you think Youtube is a good way to learn English?",
              color: Colors.white,
              size: 14,
              weight: FontWeight.w300,
            ),
            if (!hideAudio) ...[
              const MarginWidget(factor: 0.6),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: Center(
                    child: AudioProgress(
                  key: Key("${Random().nextInt(10000)}"),
                  isReview: true,
                  url:
                      "https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3",
                  question:
                      "Do you think Youtube is a good way to learn English?",
                )),
              ),
              PrimaryButton(
                onPressed: () {
                  context.push(
                      child: const OriginalTranscript(
                    difficulty: "Easy",
                  ));
                  Provider.of<DashboardProvider>(context, listen: false)
                      .changeScreen("Review");
                },
                text: "View Feedback",
                boxColor: CColors.purple,
                textStyle: AppTextStyles.appleSDGothicNeo(
                  fontWeight: FontWeight.w300,
                  fontSize: 17,
                ),
                borderRadius: 10,
                height: 45,
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget header() {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: Functions.formatDate(DateTime(2023, 12, 1)),
              size: 15,
              weight: FontWeight.w600,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () async {},
                  child: CustomAssetImage(
                      height: 20, width: 20, path: AppIcons.delete),
                ),
                const MarginWidget(isHorizontal: true, factor: 0.7),
                const DifficultyLabel(difficulty: "Easy"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color getColor(String type) {
    if (type == "Easy") {
      return CColors.lightPurple;
    } else if (type == "Medium") {
      return CColors.mediumPurple;
    } else {
      return CColors.primary;
    }
  }
}
