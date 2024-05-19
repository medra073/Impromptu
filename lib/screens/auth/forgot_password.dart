import 'package:flutter/material.dart';
import 'package:impromptu_project/extras/app_assets.dart';
import 'package:impromptu_project/extras/colors.dart';
import 'package:impromptu_project/extras/extensions.dart';
import 'package:impromptu_project/extras/functions.dart';
import 'package:impromptu_project/widgets/custom_image.dart';
import 'package:impromptu_project/widgets/custom_text.dart';
import 'package:impromptu_project/widgets/margin_widget.dart';
import 'package:impromptu_project/widgets/primary_button.dart';
import 'package:impromptu_project/widgets/text_field_widget.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CColors.primary,
        elevation: 0,
        title: CustomText(
          text: "Forgot Password",
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const MarginWidget(factor: 5),
              CustomAssetImage(height: 170, width: 170, path: AppImages.logo),
              const MarginWidget(factor: 2),
              CustomText(
                text:
                    "Please enter the email address associated with your account to reset your password.",
                size: 18,
              ),
              const MarginWidget(factor: 2.5),
              Align(
                alignment: Alignment.centerLeft,
                child: CustomText(text: "Email:"),
              ),
              const MarginWidget(factor: 0.5),
              TextFieldWidget(
                controller: email,
                hint: "Email",
                prefixWidget: Icons.email_outlined,
              ),
              const MarginWidget(factor: 2),
              PrimaryButton(
                  onPressed: () async {
                    context.pop();

                    Functions.showSnackBar(context,
                        'Password reset email sent. Please check your inbox.');
                  },
                  text: "Reset",
                  textColor: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
