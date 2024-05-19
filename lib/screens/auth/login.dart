import 'dart:io';
import 'package:flutter/material.dart';
import 'package:impromptu_project/extras/constants.dart';
import 'package:impromptu_project/extras/extensions.dart';
import 'package:impromptu_project/screens/auth/forgot_password.dart';
import 'package:impromptu_project/screens/dashboard.dart';
import 'package:impromptu_project/widgets/custom_text.dart';
import 'package:impromptu_project/widgets/show_password.dart';
import 'package:impromptu_project/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';
import '../../data_provider/dashboard_provider.dart';
import '../../extras/app_assets.dart';
import '../../extras/colors.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/margin_widget.dart';
import '../../widgets/primary_button.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isPassword = true;
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: Constants.backgroundDecoration,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 31, left: 31, right: 31),
              child: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  reverse: true,
                  child: Column(
                    children: [
                      const MarginWidget(factor: 4),
                      CustomAssetImage(
                          height: 269, width: 276, path: AppImages.logo),
                      const MarginWidget(),
                      CustomText(
                        text: "Login",
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          rememberMeWidget(context),
                          InkWell(
                            onTap: () {
                              context.push(child: ForgotPassword());
                            },
                            child: CustomText(
                              text: "Forgot Password?",
                              color: Colors.black,
                              size: 15,
                            ),
                          )
                        ],
                      ),
                      const MarginWidget(factor: 1.5),
                      PrimaryButton(
                          textColor: Colors.white,
                          text: "Login",
                          onPressed: () {

                            signIn();
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

  Widget rememberMeWidget(BuildContext context) {
    return Row(
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor: Colors.white,
            // Color for unselected checkbox
            checkboxTheme: CheckboxThemeData(
              fillColor: MaterialStateColor.resolveWith((states) {
                return Colors
                    .white; // Color for checkbox box (same for both selected and unselected states)
              }),
            ),
          ),
          child: Checkbox(
              checkColor: Colors.black,
              value: rememberMe,
              onChanged: (val) {
                setState(() {
                  rememberMe = !rememberMe;
                });
              }),
        ),
        CustomText(
          text: "Remember Me",
          color: Colors.black,
          size: 15,
        ),
      ],
    );
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
