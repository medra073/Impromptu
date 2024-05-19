import 'package:flutter/material.dart';
import '../extras/app_text_styles.dart';

class CustomText extends StatelessWidget {
  final String text;
  Color? color;
  TextStyle? textStyle;
  double? size;
  FontWeight? weight;
  TextAlign? textAlign;

  CustomText(
      {super.key,
      this.size,
        this.textAlign,
      required this.text,
      this.textStyle,
      this.color,
      this.weight});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.zero,
      child: Text(
        text,
        textAlign: textAlign ?? TextAlign.center,
        style: textStyle ??
            AppTextStyles.appleSDGothicNeo(
                color: color ?? Colors.black,
                fontSize: size ?? 25,
                fontWeight: weight ?? FontWeight.w400),
      ),
    );
  }
}
