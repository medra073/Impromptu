import 'package:flutter/material.dart';
import 'package:impromptu_project/extras/colors.dart';

class DashboardBackground extends StatelessWidget {
  final Widget childWidget;

  const DashboardBackground({super.key, required this.childWidget});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            height: 241,
            decoration: backgroundImage(),
          ),
          childWidget,
        ],
      ),
    );
  }

  BoxDecoration backgroundImage() {
    return BoxDecoration(gradient: CColors.backgroundGradient);
  }
}
