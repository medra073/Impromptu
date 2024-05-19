import 'package:flutter/material.dart';
import '../extras/app_text_styles.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget({
    required this.controller,
    required this.hint,
    this.maxLines = 1,
    this.secureText,
    this.prefixWidget,
    this.boxColor,
    this.labelText,
    this.height = 59,
    this.suffix,
    this.borderRadius,
    this.hintStyle,
    this.type = TextInputType.text,
    this.onSubmit,
    Key? key,
  }) : super(key: key);

  TextEditingController controller;
  String hint;
  int maxLines;
  bool? secureText;
  IconData? prefixWidget;
  Color? boxColor;
  double height;
  double? borderRadius;
  TextStyle? hintStyle;
  Widget? suffix;
  String? labelText;
  Color? borderColor;
  TextInputType type;
  void Function(String)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      // decoration: BoxDecoration(
      //   border: Border.all(color: borderColor ?? Colors.black, width: 1.5),
      //   color: boxColor ?? Colors.white,
      //   borderRadius: BorderRadius.circular(borderRadius ?? 25),
      // ),
      // padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        onSubmitted: onSubmit,
        controller: controller,
        maxLines: maxLines,
        obscureText: secureText ?? false,
        style: AppTextStyles.appleSDGothicNeo(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.normal,
        ),
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 18.0),
            child: Icon(prefixWidget, color: Colors.black),
          ),
          suffixIcon: SizedBox(child: suffix),
          prefixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          labelText: labelText,
          hintText: hint,
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(20)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),

            borderSide: const BorderSide(
                width: 1.0), // Set the same border width for enabled state
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),

            borderSide: const BorderSide(
                width: 1.0), // Set the same border width for focused state
          ),
          // isDense: true,
          labelStyle: AppTextStyles.appleSDGothicNeo(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
          hintStyle: hintStyle ??
              AppTextStyles.appleSDGothicNeo(
                color: Colors.black.withOpacity(0.5),
                fontSize: 17,
                fontWeight: FontWeight.normal,
              ),
        ),
      ),
    );
  }
}
