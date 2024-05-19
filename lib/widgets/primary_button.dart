import 'package:flutter/material.dart';
import 'package:impromptu_project/widgets/custom_text.dart';

class PrimaryButton extends StatelessWidget {
  final String? text;
  final Function() onPressed;
  Color? boxColor;
  Color? textColor;
  double? height;
  double borderRadius;
  Widget? childIcon;
  TextStyle? textStyle;
  Color? borderColor;
  double? width;

  PrimaryButton(
      {this.text,
      required this.onPressed,
      this.boxColor,
      this.textColor,
      this.height,
      this.childIcon,
      this.width,
      this.borderRadius = 17,
      this.textStyle,
      this.borderColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height ?? 50,
        width: width ?? double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: boxColor ?? const Color(0xff6A61CF),
          border: Border.all(color: borderColor ?? Colors.transparent),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: childIcon ??
            CustomText(
              text: text ?? "",
              textStyle: textStyle,
              color: textColor,
              size: 25,
            ),
      ),
    );
  }
}
