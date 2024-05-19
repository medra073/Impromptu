import 'package:flutter/material.dart';
import 'package:impromptu_project/extras/app_assets.dart';
import 'package:impromptu_project/extras/extensions.dart';
import 'package:impromptu_project/widgets/custom_image.dart';

import 'check_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1200), () {
      context.pushReplacement(
        child:  CheckWidget());
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomAssetImage(height: 249, width: 256, path: AppImages.logo),
      ),
    );
  }
}
