import 'package:flutter/material.dart';
import 'package:impromptu_project/extras/extensions.dart';
import 'package:provider/provider.dart';
import '../data_provider/dashboard_provider.dart';
import '../extras/colors.dart';
import 'custom_text.dart';

class ChoiceBox extends StatelessWidget {
  final String text;
  Color? boxColor, textColor;
  Widget? childWidget;
  double? textSize;
  FontWeight? weight;
  double? height, width;
  void Function()? onTap;

  ChoiceBox(
      {super.key,
      required this.text,
      this.boxColor,
      this.textColor,
      this.textSize,
      this.height,
      this.width,
      this.weight,
      this.onTap,
      this.childWidget});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () {
            if (childWidget != null) {
              context.push(child: childWidget!);
              Provider.of<DashboardProvider>(context, listen: false)
                  .changeScreen("Practice");
            }
          },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        color: boxColor ?? CColors.purple,
        elevation: 4,
        child: Container(
          height: height ?? 87,
          width: width ?? double.infinity,
          alignment: Alignment.center,
          child: CustomText(
              text: text,
              weight: weight ?? FontWeight.w600,
              color: textColor,
              size: textSize),
        ),
      ),
    );
  }
}
