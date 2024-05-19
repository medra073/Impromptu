import 'package:flutter/material.dart';
import 'package:impromptu_project/data_provider/dashboard_provider.dart';
import 'package:impromptu_project/extras/app_assets.dart';
import 'package:impromptu_project/extras/app_text_styles.dart';
import 'package:impromptu_project/extras/colors.dart';
import 'package:impromptu_project/extras/extensions.dart';
import 'package:impromptu_project/screens/auth/login.dart';
import 'package:impromptu_project/screens/auth/signup.dart';
import 'package:impromptu_project/screens/dashboard.dart';
import 'package:impromptu_project/widgets/custom_image.dart';
import 'package:impromptu_project/widgets/margin_widget.dart';
import 'package:impromptu_project/widgets/primary_button.dart';
import 'package:provider/provider.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  _OnboardScreen createState() => _OnboardScreen();
}

class _OnboardScreen extends State<OnboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 31, bottom: 31),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const MarginWidget(factor: 4),
              CustomAssetImage(height: 249, width: 256, path: AppImages.logo),
              const MarginWidget(),
              Text(
                "IMPROMPTU",
                style: AppTextStyles.appleSDGothicNeo(
                  fontSize: 48,
                  color: CColors.purple,
                ),
              ),
              Expanded(
                child: Text(
                  "Ready, Set, Speak!",
                  style: AppTextStyles.appleSDGothicNeo(
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                height: 1,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 5.0,
                      offset: Offset(3.0, 2),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 31, right: 31),
                child: Column(
                  children: [
                    const MarginWidget(factor: 2),
                    PrimaryButton(
                        textColor: Colors.white,
                        text: "Login",
                        onPressed: () {
                          context.push(child: const Login());
                        }),
                    const MarginWidget(),
                    PrimaryButton(
                      onPressed: () {
                        context.push(child: const SignUp());
                      },
                      boxColor: Colors.white,
                      borderColor: CColors.primary,
                      text: "Sign Up",
                      textColor: CColors.primary,
                    ),
                    TextButton(
                      onPressed: () {
                        context.pushAndRemoveUntil(
                          child: ChangeNotifierProvider(
                            create: (_)=> DashboardProvider(),
                            child: Dashboard(),
                          ),
                        );
                      },
                      child: Text(
                        "Continue without login",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
