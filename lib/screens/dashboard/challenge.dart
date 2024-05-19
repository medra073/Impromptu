import 'package:flutter/material.dart';
import 'package:impromptu_project/data_provider/dashboard_provider.dart';
import 'package:impromptu_project/extras/app_assets.dart';
import 'package:impromptu_project/extras/colors.dart';
import 'package:impromptu_project/extras/extensions.dart';
import 'package:impromptu_project/screens/dashboard/practise/practice_question.dart';
import 'package:impromptu_project/widgets/choice_box.dart';
import 'package:impromptu_project/widgets/custom_image.dart';
import 'package:impromptu_project/widgets/custom_text.dart';
import 'package:impromptu_project/widgets/margin_widget.dart';
import 'package:provider/provider.dart';
import '../../widgets/dashboard_background.dart';

class Challenge extends StatefulWidget {
  const Challenge({super.key});

  @override
  _Challenge createState() => _Challenge();
}

class _Challenge extends State<Challenge> {
  late DashboardProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<DashboardProvider>(context);

    return Scaffold(
      body: DashboardBackground(
        childWidget: Padding(
          padding: const EdgeInsets.all(27),
          child: Column(
            children: [
              const MarginWidget(factor: 3.5),
              header(),
              const MarginWidget(factor: 2),
              streakHeader(),
              const MarginWidget(),
              streakCard(),
              const MarginWidget(factor: 2),
              dailyChallenge(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget dailyChallenge(BuildContext context) {


    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: ChoiceBox(
        onTap: () async {
          context.push(child: const PractiseQuestion());
          provider.changeScreen("Challenge");
        },
        weight: FontWeight.w600,
        height: 107,
        width: 300,
        boxColor: CColors.darkBlue,
        text: "Start Daily\nChallenge",
        textColor: Colors.white,
      ),
    );
  }

  Widget streakCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        height: 257,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomAssetImage(height: 100, width: 80, path: AppImages.streak),
            const MarginWidget(),
            streakDisplay(),
          ],
        ),
      ),
    );
  }

  Widget streakDisplay() {
    return CustomText(
        text: "14 Days",
        weight: FontWeight.w900,
        size: 40);
  }

  Widget streakHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
            text: "Your Challenge Streak", weight: FontWeight.w600, size: 18),
        CustomText(
            text: "Only visible to you.", weight: FontWeight.w300, size: 12),
      ],
    );
  }

  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              child: CustomText(
                text: "Tom",
                weight: FontWeight.w600,
              ),
            ),
            CustomText(
                text: "You joined impromptu 2 months ago.",
                weight: FontWeight.w300,
                size: 13),
          ],
        ),
        CustomAssetImage(height: 53, width: 56, path: AppImages.logo),
      ],
    );
  }
}
