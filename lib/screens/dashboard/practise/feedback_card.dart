import 'package:flutter/material.dart';
import '../../../extras/colors.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/margin_widget.dart';

class FeedbackCard extends StatelessWidget {
  final String? heading;
  final String text;

  const FeedbackCard({super.key, required this.text, this.heading});

  @override
  Widget build(BuildContext context) {
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
                  text: heading ?? "Your transcript",
                  weight: FontWeight.w700,
                  size: 20),
              Padding(
                padding: const EdgeInsets.only(
                    left: 5, right: 5, bottom: 5, top: 15),
                child:
                    CustomText(textAlign: TextAlign.left, text: text, size: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
