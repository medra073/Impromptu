
import 'package:flutter/cupertino.dart';
import '../extras/functions.dart';


class DashboardProvider extends ChangeNotifier {
  DashboardProvider() {
    _tabController = CupertinoTabController(initialIndex: 0);
  }

  bool _isVisible = true;

  late CupertinoTabController _tabController;
  String screen = "";
  String _countDown = "01:00";
  bool _isRecording = false;

  int _secondsRemaining = 60;

  set isVisible(bool s) {
    _isVisible = s;
    notifyListeners();
  }

  set isRecording(bool value) {
    _isRecording = value;
    notifyListeners();
  }

  set countDown(String value) {
    _countDown = value;
    notifyListeners();
  }

  set secondsRemaining(int value) {
    _secondsRemaining = value;
    _countDown = Functions.formatTime(secondsRemaining);
    notifyListeners();
  }

  String get countDown => _countDown;

  int get secondsRemaining => _secondsRemaining;

  bool get isVisible => _isVisible;

  bool get isRecording => _isRecording;

  CupertinoTabController get tabController => _tabController;

  void changeScreen(String str) {
    screen = str;
  }

  void changeTab(int index) {
    _tabController.index = index;
    notifyListeners();
  }
}
