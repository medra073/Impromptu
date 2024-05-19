import 'package:flutter/material.dart';
import 'package:impromptu_project/data_provider/dashboard_provider.dart';
import 'package:impromptu_project/extras/colors.dart';
import 'package:impromptu_project/extras/extensions.dart';
import 'package:impromptu_project/extras/functions.dart';
import 'package:impromptu_project/screens/dashboard/practise/gbt_feedback.dart';
import 'package:impromptu_project/widgets/choice_box.dart';
import 'package:impromptu_project/widgets/custom_text.dart';
import 'package:impromptu_project/widgets/dashboard_background.dart';
import 'package:impromptu_project/widgets/margin_widget.dart';
import 'package:provider/provider.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/refresh_button.dart';

class FeedbackType extends StatefulWidget {
  const FeedbackType(
      {required this.difficulty,
      this.question,
      this.text,
      this.filePath,
      super.key});

  final String? question;
  final String difficulty;
  final String? text;
  final String? filePath;

  @override
  _FeedbackTypeState createState() => _FeedbackTypeState();
}

class _FeedbackTypeState extends State<FeedbackType> {
  late DashboardProvider provider;

  // List<ResponseModel> responseList = [];

  bool anyChange = false;

  bool grammar = false, org = false, idea = false, vocab = false;

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<DashboardProvider>(context);

    return Scaffold(
      body: DashboardBackground(
        childWidget: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              const MarginWidget(factor: 5),
              RefreshButton(provider: provider),
              const MarginWidget(),
              CustomText(
                text: "Choose 2 types of feedback you’d like to receive:",
                size: 23,
                weight: FontWeight.w500,
              ),
              const MarginWidget(factor: 4),
              choiceRow("Grammar", "Organization",
                  boxColor1:
                      grammar == true ? CColors.lightPurple : Colors.white,
                  boxColor2: org == true ? CColors.lightPurple : Colors.white),
              const MarginWidget(),
              choiceRow("Ideas", "Vocabulary",
                  boxColor1: idea == true ? CColors.lightPurple : Colors.white,
                  boxColor2:
                      vocab == true ? CColors.lightPurple : Colors.white),
              const MarginWidget(factor: 4),
              PrimaryButton(
                  onPressed: () async {
                    if (selected < 2) {
                      Functions.showSnackBar(
                          context, "Please select atleast 2 types");
                      return;
                    }



                    context.push(
                        child: GBTFeedback(
                      difficulty: widget.difficulty,
                      provider: provider,
                      isChange: anyChange,
                      isGrammar: grammar,
                      isIdeas: idea,
                      isOrg: org,
                      isVocab: vocab,
                    ));

                    grammar = false;
                  },
                  text: "Continue",
                  textColor: Colors.white),
            ],
          ),
        ),
      ),
    );
  }





  Widget choiceRow(String str1, String str2,
      {Color? boxColor1, Color? boxColor2}) {
    return Row(
      children: [
        Expanded(
          child: ChoiceBox(
            onTap: () {
              selection(str1);
            },
            text: str1,
            weight: FontWeight.w500,
            textSize: 17,
            boxColor: boxColor1,
          ),
        ),
        const MarginWidget(isHorizontal: true),
        Expanded(
          child: ChoiceBox(
            onTap: () {
              selection(str2);
            },
            text: str2,
            weight: FontWeight.w500,
            textSize: 17,
            boxColor: boxColor2,
          ),
        ),
      ],
    );
  }

  selection(String str) {
    switch (str) {
      case "Grammar":
        setState(() {
          if (grammar) {
            selected--;
            grammar = false;
          } else {
            if (selected != 2) {
              selected++;
              grammar = true;
            }
          }
        });
        break;
      case "Organization":
        setState(() {
          if (org) {
            selected--;
            org = false;
          } else {
            if (selected != 2) {
              selected++;
              org = true;
            }
          }
        });

        break;
      case "Ideas":
        setState(() {
          if (idea) {
            selected--;
            idea = false;
          } else {
            if (selected != 2) {
              selected++;
              idea = true;
            }
          }
        });

        break;
      case "Vocabulary":
        setState(() {
          if (vocab) {
            selected--;
            vocab = false;
          } else {
            if (selected != 2) {
              selected++;
              vocab = true;
            }
          }
        });
        break;
    }
  }
}
