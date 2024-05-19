import 'package:flutter/material.dart';

class RoundedLinearProgressIndicator extends StatelessWidget {
  final double value;
  final Color backgroundColor;
  final Color valueColor;
  final double borderRadius;
  final double? minHeight;

  const RoundedLinearProgressIndicator({super.key,
    required this.value,
    required this.backgroundColor,
    required this.valueColor,
    this.minHeight,
    this.borderRadius = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: _RoundedLinearProgressPainter(
        value: value,
        backgroundColor: backgroundColor,
        valueColor: valueColor,
        borderRadius: borderRadius,
      ),
      child: LinearProgressIndicator(
        minHeight: minHeight,
        value: value,
        backgroundColor: backgroundColor,
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.transparent),
      ),
    );
  }
}

class _RoundedLinearProgressPainter extends CustomPainter {
  final double value;
  final Color backgroundColor;
  final Color valueColor;
  final double borderRadius;

  _RoundedLinearProgressPainter({
    required this.value,
    required this.backgroundColor,
    required this.valueColor,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()..color = backgroundColor;
    final Paint valuePaint = Paint()..color = valueColor;

    // Draw background bar
    final Rect backgroundRect = Rect.fromLTRB(0, 0, size.width, size.height);
    canvas.drawRRect(
      RRect.fromRectAndRadius(backgroundRect, Radius.circular(borderRadius)),
      backgroundPaint,
    );

    // Draw active bar
    final double activeWidth = size.width * value;
    final Rect valueRect = Rect.fromLTRB(0, 0, activeWidth, size.height);
    canvas.drawRRect(
      RRect.fromRectAndRadius(valueRect, Radius.circular(borderRadius)),
      valuePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
