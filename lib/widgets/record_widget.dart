import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:impromptu_project/data_provider/dashboard_provider.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import '../extras/app_assets.dart';
import 'custom_image.dart';

typedef StringValue = String Function(String);

class RecordWidget extends StatefulWidget {
  RecordWidget({super.key, required this.callBack});
  StringValue callBack;


  @override
  _RecordWidgetState createState() => _RecordWidgetState();
}

class _RecordWidgetState extends State<RecordWidget>
    with TickerProviderStateMixin {
  late DashboardProvider provider;

  late AnimationController _controller;
  late Animation<double> _animation;
  double _currentSize = 100.0;
  double originalSize = 166;

  Timer? _timer;

  final _audioRecorder = Record();

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  double micIcon = 145, squareIcon = 100;

  @override
  void initState() {

    super.initState();
    _currentSize = 166;

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(_controller)
      ..addListener(() {
        setState(() {
          _currentSize = originalSize * _animation.value - 25;
        });
      });

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<DashboardProvider>(context);

    return GestureDetector(
      onLongPress: _startAnimation,
      onLongPressEnd: (_) => _stopAnimation(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (BuildContext context, Widget? child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: AnimatedContainer(
              height: _currentSize,
              width: _currentSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: _currentSize == 166
                        ? Colors.transparent
                        : Colors.blue.withOpacity(0.5),
                    spreadRadius: 2.0,
                    blurRadius: 10.0,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              duration: const Duration(milliseconds: 500),
              child: CustomAssetImage(
                  height: 166,
                  width: 166,
                  path: provider.isRecording == false
                      ? AppIcons.mic
                      : AppIcons.playing),
            ),
          );
        },
      ),
    );
  }

  Future<void> _startRecord() async {
    provider.isRecording = true;
    try {
      if (await _audioRecorder.hasPermission()) {
        final isSupported = await _audioRecorder.isEncoderSupported(
          AudioEncoder.aacLc,
        );
        if (kDebugMode) {
          print('${AudioEncoder.aacLc.name} supported: $isSupported');
        }

        await _audioRecorder.start();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> _stopRecord() async {
    final path = await _audioRecorder.stop();

    widget.callBack(path ?? "");
    provider.isRecording = false;
    if (path != null) {
      log("Recorded Path: $path");
    }
  }

  void _startAnimation() {
    _startRecord();
    startTimer();
    _controller.repeat(reverse: true);
    _animationController.forward();
  }

  void _stopAnimation() {
    _stopRecord();
    _animationController.reverse();

    _controller.stop();
    setState(() {
      _currentSize = originalSize;
    });
  }

  void startTimer() {
    provider.secondsRemaining = 60;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (provider.secondsRemaining == 0) {
        timer.cancel();
        _stopAnimation();
      } else {
        if (provider.isRecording == false) {
          timer.cancel();
        } else {
          provider.secondsRemaining--;
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    _controller.dispose();
    super.dispose();
  }
}
