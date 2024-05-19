import 'package:flutter/material.dart';
import 'package:impromptu_project/extras/colors.dart';
import 'package:impromptu_project/screens/dashboard/practise/practice_question.dart';
import 'package:impromptu_project/widgets/custom_text.dart';
import 'package:impromptu_project/widgets/dashboard_background.dart';
import '../../widgets/choice_box.dart';
import '../../widgets/margin_widget.dart';

class StartPractise extends StatelessWidget {
  const StartPractise({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DashboardBackground(
        childWidget: Padding(
          padding: const EdgeInsets.only(left: 35, right: 35),
          child: Column(
            children: [
              const MarginWidget(factor: 9.5),
              CustomText(
                text: "Choose the level of difficulty: ",
                size: 18,
              ),
              const MarginWidget(factor: 2),
              ChoiceBox(
                text: "Easy",
                boxColor: CColors.lightPurple,
                childWidget:  const PractiseQuestion(difficulty: "Easy"),
              ),
              const MarginWidget(factor: 1.5),
              ChoiceBox(
                text: "Medium",
                childWidget:  const PractiseQuestion(difficulty: "Medium"),
              ),
              const MarginWidget(factor: 1.5),
              ChoiceBox(
                  childWidget:  const PractiseQuestion(difficulty: "Hard"),
                  text: "Hard",
                  boxColor: CColors.primary,
                  textColor: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
