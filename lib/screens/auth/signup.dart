import 'package:flutter/material.dart';
import 'package:impromptu_project/data_provider/dashboard_provider.dart';
import 'package:impromptu_project/extras/extensions.dart';
import 'package:impromptu_project/screens/dashboard.dart';
import 'package:impromptu_project/widgets/custom_text.dart';
import 'package:impromptu_project/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';
import '../../extras/app_assets.dart';
import '../../extras/colors.dart';
import '../../extras/constants.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/margin_widget.dart';
import '../../widgets/primary_button.dart';
import 'dart:io';

import '../../widgets/show_password.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUp createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: Constants.backgroundDecoration,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(31),
              child: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  reverse: true,
                  child: Column(
                    children: [
                      const MarginWidget(factor: 4),
                      CustomAssetImage(
                          height: 269, width: 256, path: AppImages.logo),
                      const MarginWidget(),
                      CustomText(
                        text: "Sign Up",
                        color: Colors.black,
                        size: 23,
                        weight: FontWeight.w700,
                      ),
                      const MarginWidget(factor: 2),
                      TextFieldWidget(
                        labelText: "Email",
                        prefixWidget: Icons.email_outlined,
                        controller: email,
                        hint: "example@gmail.com",
                      ),
                      const MarginWidget(),
                      TextFieldWidget(
                        prefixWidget: Icons.lock,
                        controller: password,
                        labelText: "Password",
                        hint: "examplePassword",
                        secureText: isPassword,
                        suffix: ShowPassword(
                            isPassword: isPassword,
                            onTap: () {
                              setState(() {
                                isPassword = !isPassword;
                              });
                            }),
                      ),
                      const MarginWidget(factor: 5),
                      PrimaryButton(
                          textColor: Colors.white,
                          text: "Sign up",
                          onPressed: () async {
                            await signup();
                          }),
                      const MarginWidget(),
                      if (Platform.isAndroid) ...[
                        PrimaryButton(
                          onPressed: () {
                            signInWithGoogle();
                          },
                          boxColor: Colors.white,
                          borderColor: Colors.black,
                          childIcon: loginType("Google", AppIcons.google),
                        ),
                      ] else ...[
                        PrimaryButton(
                          onPressed: () {
                            signInWithApple();
                          },
                          boxColor: Colors.white,
                          borderColor: Colors.black,
                          childIcon: loginType("Apple", AppIcons.apple1),
                        ),
                      ],
                      const MarginWidget(factor: 2),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget loginType(String str, String path) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          text: "Login with",
          color: CColors.primary,
          size: 22,
        ),
        const MarginWidget(isHorizontal: true),
        CustomAssetImage(
          height: 31,
          width: 31,
          path: path,
        ),
        CustomText(
          text: str,
          color: CColors.primary,
          size: 22,
        ),
      ],
    );
  }

  signup() async {
    context.pushAndRemoveUntil(
        child: ChangeNotifierProvider(
            create: (ctx) => DashboardProvider(), child: const Dashboard()));
  }

  signInWithApple() async {
    navigateToDashboard();
  }

  signInWithGoogle() async {
    navigateToDashboard();
  }

  signIn() async {
    navigateToDashboard();
  }

  navigateToDashboard() async {
    context.pushAndRemoveUntil(
        child: ChangeNotifierProvider(
            create: (ctx) => DashboardProvider(), child: const Dashboard()));
  }
}
