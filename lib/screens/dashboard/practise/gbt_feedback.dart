import 'package:flutter/material.dart';
import 'package:impromptu_project/data_provider/dashboard_provider.dart';
import 'package:impromptu_project/extras/colors.dart';
import 'package:impromptu_project/extras/extensions.dart';
import 'package:impromptu_project/widgets/dashboard_background.dart';
import 'package:provider/provider.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/margin_widget.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/refresh_button.dart';
import '../../dashboard.dart';

class GBTFeedback extends StatefulWidget {
  final bool isGrammar;
  final bool isOrg;
  final bool isIdeas;
  final bool isVocab;
  final bool isChange;
  final DashboardProvider provider;
  final String difficulty;

  const GBTFeedback(
      {super.key,
      required this.isChange,
      required this.isGrammar,
      required this.isIdeas,
      required this.isOrg,
      required this.provider,
      required this.difficulty,
      required this.isVocab});

  @override
  State<GBTFeedback> createState() => _GBTFeedbackState();
}

class _GBTFeedbackState extends State<GBTFeedback> {
  bool isOpen = false;
  late DashboardProvider provider;
  String url = "";

  List<String> heading = [];
  List<String> response = [];

  @override
  void initState() {
    provider = widget.provider;
    if (widget.isGrammar) {
      checkType("Grammar");
    }
    if (widget.isVocab) {
      checkType("Vocabulary");
    }
    if (widget.isIdeas) {
      checkType("Ideas");
    }
    if (widget.isOrg) {
      checkType("Organization");
    }
    super.initState();
  }

  checkType(String value) {
    heading.add(value);
    response.add(
        """Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Sit amet consectetur adipiscing elit. Adipiscing elit duis tristique sollicitudin nibh sit amet commodo nulla. Augue lacus viverra vitae congue eu consequat ac felis. Id aliquet risus feugiat in ante metus. Mauris commodo quis imperdiet massa tincidunt nunc. Ullamcorper a lacus vestibulum sed arcu non odio euismod. Euismod lacinia at quis risus sed. Morbi non arcu risus quis varius. Mattis vulputate enim nulla aliquet porttitor. Et pharetra pharetra massa massa ultricies mi quis hendrerit dolor. Nulla aliquet porttitor lacus luctus accumsan tortor posuere ac. Vulputate mi sit amet mauris commodo quis imperdiet massa tincidunt. Erat nam at lectus urna duis. """);
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<DashboardProvider>(context);

    if (provider.screen == "Review") {
      url =
          "https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3";
    }

    return Scaffold(
      body: DashboardBackground(
        childWidget: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const MarginWidget(factor: 3),
                Row(
                  children: [
                    if (provider.screen == "Challenge") ...[
                      Expanded(
                        child: CustomText(
                          textAlign: TextAlign.center,
                          text: "Today's challenge",
                          size: 23,
                          weight: FontWeight.w900,
                        ),
                      ),
                    ] else ...[
                      Expanded(
                        child: CustomText(
                            textAlign: TextAlign.center,
                            text: widget.difficulty,
                            size: 20),
                      ),
                    ],
                    RefreshButton(provider: provider),
                  ],
                ),
                const MarginWidget(factor: 0.5),
                CustomText(
                    text: getDummyQuestion(),
                    weight: FontWeight.w700,
                    size: 23),
                const MarginWidget(factor: 2),
                isOpen == false
                    ? openedFeedback()
                    : toExpandFeedback(heading[0]),
                const MarginWidget(),
                isOpen == false
                    ? toExpandFeedback(heading[1])
                    : openedFeedback(),
                if (!isOpen) ...[
                  const MarginWidget(factor: 4.5),
                ] else ...[
                  const MarginWidget(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: PrimaryButton(
                      onPressed: () async {
                        startAgain();
                      },
                      height: 55,
                      text: getText(),
                      boxColor: Colors.white,
                      borderColor: CColors.darkBlue,
                    ),
                  ),
                  const MarginWidget(factor: 3),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getText() {
    if (provider.screen == "Review") {
      return "Back to Review Page";
    } else if (provider.screen == "Challenge") {
      return "Back to Challenge Page";
    } else {
      return "Start again";
    }
  }

  Widget toExpandFeedback(String str) {
    return PrimaryButton(
      onPressed: () {
        setState(() {
          isOpen = !isOpen;
        });
      },
      childIcon: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomText(
            text: str,
            color: Colors.white,
            size: 20,
            weight: FontWeight.w700,
          ),
          const MarginWidget(isHorizontal: true, factor: 0.3),
          const Icon(
            Icons.add_circle_outlined,
            color: Colors.white,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget openedFeedback() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: CColors.purple,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const MarginWidget(factor: 0.5),
              CustomText(
                  text: isOpen == false ? heading[0] : heading[1],
                  weight: FontWeight.w700,
                  size: 20),
              // Html(
              //   data: isOpen == false ? response[0] : response[1],
              // ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 5, right: 5, bottom: 5, top: 15),
                child: CustomText(
                    textAlign: TextAlign.left,
                    text: isOpen == false ? response[0] : response[1],
                    size: 16),
              )
            ],
          ),
        ),
      ),
    );
  }

  startAgain() async {
    int index = 1;
    if (provider.screen == "Review") {
      index = 2;
    } else if (provider.screen == "Challenge") {
      index = 3;
    }
    context.pushAndRemoveUntil(child: Dashboard(index: index));
    provider.changeScreen("");
  }

  String getDummyQuestion() {
    switch (widget.difficulty.toLowerCase() ?? "easy") {
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
}
