import 'package:flutter/material.dart';
import 'package:impromptu_project/data_provider/dashboard_provider.dart';
import 'package:impromptu_project/extras/extensions.dart';
import 'package:impromptu_project/extras/functions.dart';
import '../extras/app_assets.dart';
import '../screens/dashboard.dart';
import 'custom_image.dart';

class RefreshButton extends StatelessWidget {
  const RefreshButton({super.key, required this.provider});

  final DashboardProvider provider;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Functions.pauseMusic();
        int index = 1;
        if (provider.screen == "Review") {
          index = 2;
        } else if (provider.screen == "Challenge") {
          index = 3;
        }
        context.push(child: Dashboard(index: index));
      },
      child: Align(
        alignment: Alignment.centerRight,
        child: CustomAssetImage(height: 30, width: 30, path: AppIcons.restart),
      ),
    );
  }
}
