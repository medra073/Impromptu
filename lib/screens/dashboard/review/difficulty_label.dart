import 'package:flutter/material.dart';
import 'package:impromptu_project/extras/colors.dart';
import 'package:impromptu_project/widgets/custom_text.dart';

class DifficultyLabel extends StatefulWidget {
  final String difficulty;

  const DifficultyLabel({super.key, required this.difficulty});

  @override
  State<DifficultyLabel> createState() => _DifficultyLabelState();
}

class _DifficultyLabelState extends State<DifficultyLabel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: getColor(),
        ),
        alignment: Alignment.center,
        width: 75,
        height: 20,
        child: CustomText(
          text: widget.difficulty,
          size: 11,
          weight: FontWeight.w300,
          color: getTextColor(),
        ),
      ),
    );
  }

  getTextColor() {
    if (widget.difficulty == "Hard") {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  getColor() {
    if (widget.difficulty == "Hard") {
      return CColors.darkBlue;
    } else if (widget.difficulty == "Medium") {
      return CColors.mediumPurple;
    } else {
      return CColors.lightPurple;
    }
  }
}
