import 'package:flutter/material.dart';
import '../extras/app_assets.dart';
import 'custom_image.dart';

class ShowPassword extends StatelessWidget {
  final bool isPassword;
  final void Function() onTap;

  const ShowPassword({super.key, required this.isPassword, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: isPassword == true
          ? Transform.scale(
              scale: 0.45, // Adjust the scale value as needed
              child: CustomAssetImage(
                height: 2,
                width: 2,
                path: AppIcons.showPassword,
              ))
          : Icon(
              Icons.remove_red_eye_outlined,
              size: 22.5,
              color: Colors.black.withOpacity(0.5),
            ),
    );
  }
}
