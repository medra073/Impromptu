import 'package:flutter/cupertino.dart';

class CustomAssetImage extends StatelessWidget {
  final String path;
  final double width, height;

  const CustomAssetImage(
      {super.key,
      required this.height,
      required this.width,
      required this.path});

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage(path),
      width: width,
      height: height,
    );
  }
}
