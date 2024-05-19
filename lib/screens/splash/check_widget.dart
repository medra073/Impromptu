import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data_provider/dashboard_provider.dart';
import '../dashboard.dart';
import 'onboard_page.dart';

class CheckWidget extends StatefulWidget {
  @override
  _CheckWidgetState createState() => _CheckWidgetState();
}

class _CheckWidgetState extends State<CheckWidget> {
  Widget? childWidget;

  @override
  void initState() {
    super.initState();
    checkWidget();
  }

  checkWidget() async {
    var prefs = await SharedPreferences.getInstance();


    childWidget = const OnboardScreen();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: childWidget ?? const CircularProgressIndicator(),
    );
  }
}
