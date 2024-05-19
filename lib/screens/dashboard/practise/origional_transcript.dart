import 'package:impromptu_project/extras/extensions.dart';
import 'package:impromptu_project/screens/dashboard/practise/feedback_card.dart';
import 'package:flutter/material.dart';
import 'package:impromptu_project/data_provider/dashboard_provider.dart';
import 'package:impromptu_project/extras/colors.dart';
import 'package:impromptu_project/widgets/dashboard_background.dart';
import 'package:provider/provider.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/margin_widget.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/refresh_button.dart';
import 'feedback_type.dart';

class OriginalTranscript extends StatefulWidget {
  final String? question;
  final String? speechText;
  final String? recordPath;
  final String difficulty;


  const OriginalTranscript({
    super.key,
    this.question,
    this.speechText,
    required this.difficulty,
    this.recordPath,
  });

  @override
  State<OriginalTranscript> createState() => _OriginalTranscript();
}

class _OriginalTranscript extends State<OriginalTranscript> {
  late DashboardProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<DashboardProvider>(context);
    return Scaffold(
      body: DashboardBackground(
        childWidget: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Column(
                children: [
                  const MarginWidget(factor: 4),
                  RefreshButton(provider: provider),
                  const MarginWidget(factor: 2),
                  CustomText(
                      textAlign: TextAlign.center,
                      text: "Do you think Youtube is a good way to learn English?",
                      size: 20),
                  const MarginWidget(),
                  const FeedbackCard(
                      text: """Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Sit amet consectetur adipiscing elit. Adipiscing elit duis tristique sollicitudin nibh sit amet commodo nulla. Augue lacus viverra vitae congue eu consequat ac felis. Id aliquet risus feugiat in ante metus. Mauris commodo quis imperdiet massa tincidunt nunc. Ullamcorper a lacus vestibulum sed arcu non odio euismod. Euismod lacinia at quis risus sed. Morbi non arcu risus quis varius. Mattis vulputate enim nulla aliquet porttitor. Et pharetra pharetra massa massa ultricies mi quis hendrerit dolor. Nulla aliquet porttitor lacus luctus accumsan tortor posuere ac. Vulputate mi sit amet mauris commodo quis imperdiet massa tincidunt. Erat nam at lectus urna duis. """),
                  const MarginWidget(factor: 3),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: PrimaryButton(
                      onPressed: () async {
                        // if (widget.feedbackModel == null) {
                          context.push(
                              child: FeedbackType(
                                  filePath: widget.recordPath,
                                  question: widget.question,
                                  text: widget.speechText,
                                  difficulty: widget.difficulty));
                        // } else {
                        //   context.push(
                        //       child: FeedbackType(
                        //           feedbackModel: widget.feedbackModel));
                        // }
                      },
                      height: 55,
                      text: "Continue",
                      boxColor: Colors.white,
                      borderColor: CColors.darkBlue,
                    ),
                  ),
                  const MarginWidget(factor: 3),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
