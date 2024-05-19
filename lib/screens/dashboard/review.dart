import 'package:flutter/material.dart';
import 'package:impromptu_project/extras/app_text_styles.dart';
import 'package:impromptu_project/extras/colors.dart';
import 'package:impromptu_project/screens/dashboard/review/review_card.dart';
import 'package:impromptu_project/widgets/custom_text.dart';
import 'package:impromptu_project/widgets/margin_widget.dart';
import 'package:impromptu_project/widgets/primary_button.dart';
import 'package:provider/provider.dart';
import '../../data_provider/dashboard_provider.dart';
import '../../widgets/dashboard_background.dart';

class Review extends StatefulWidget {
  const Review({super.key});

  @override
  _Review createState() => _Review();
}

class _Review extends State<Review> {
  late DashboardProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<DashboardProvider>(context);

    return Scaffold(
      body: DashboardBackground(
        childWidget: Padding(
          padding: const EdgeInsets.only(left: 27, right: 27),
          child: CustomScrollView(
            slivers: [
              const MarginWidget(factor: 5, isSliver: true),
              SliverToBoxAdapter(
                child: CustomText(
                  text:
                      "Tap on the question to replay the recording and to review the feedback:",
                  weight: FontWeight.w500,
                  size: 19,
                ),
              ),
              const MarginWidget(factor: 0.6, isSliver: true),
              SliverToBoxAdapter(
                child: Align(
                  alignment: Alignment.topRight,
                  child: customizeButton("View all", 90),
                ),
              ),
              const MarginWidget(isSliver: true),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext ctx, int index) {
                    return const Column(
                      children: [
                        ReviewCard(),
                        MarginWidget(),
                      ],
                    );
                  },
                  childCount: 3,
                ),
              ),
              const MarginWidget(isSliver: true, factor: 4.5),
            ],
          ),
        ),
      ),
    );
  }

  Widget customizeButton(String name, double width,
      {Color? boxColor, Color textColor = Colors.black}) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: PrimaryButton(
        width: width,
        textColor: Colors.white,
        boxColor: boxColor ?? CColors.purple,
        onPressed: () {},
        text: name,
        height: 20,
        textStyle: AppTextStyles.appleSDGothicNeo(
          fontSize: 13,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
