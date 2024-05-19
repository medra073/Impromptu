import 'package:flutter/cupertino.dart';
import 'package:impromptu_project/data_provider/dashboard_provider.dart';
import 'package:impromptu_project/screens/dashboard/home_page.dart';
import 'package:impromptu_project/screens/dashboard/review.dart';
import 'package:provider/provider.dart';
import '../extras/app_assets.dart';
import '../extras/colors.dart';
import 'dashboard/challenge.dart';
import 'dashboard/start_practice.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key, this.index});

  final int? index;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late List<Widget> tabScreens;
  late List<GlobalKey<NavigatorState>> tabNavigatorKeys;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    currentIndex = widget.index ?? 0;

    tabScreens = [
      const HomePage(),
      const StartPractise(),
      const Review(),
      const Challenge(),
    ];

    tabNavigatorKeys = List.generate(
      tabScreens.length,
      (_) => GlobalKey<NavigatorState>(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (ctx, value, child) {
        return WillPopScope(
          onWillPop: () async {
            final currentNavigator =
                tabNavigatorKeys[currentIndex].currentState!;
            if (currentNavigator.canPop()) {
              currentNavigator.pop();
              return false;
            } else if (currentIndex != 0) {
              value.changeTab(0);
              return false;
            }
            return true;
          },
          child: CupertinoTabScaffold(
            controller: value.tabController,
            tabBar: CupertinoTabBar(
              currentIndex: currentIndex,
              activeColor: CColors.darkBlue,
              inactiveColor: CColors.purple,
              onTap: (i) {
                value.changeTab(i);
                setState(() {
                  currentIndex = i;
                });
              },
              items: [
                bottomNavItemWidget(AppIcons.home, "Home"),
                bottomNavItemWidget(AppIcons.practise, "Practice"),
                bottomNavItemWidget(AppIcons.review, "Review"),
                bottomNavItemWidget(AppIcons.challenge, "Challenge"),
              ],
            ),
            tabBuilder: (ctx, i) {
              return CupertinoTabView(
                navigatorKey: tabNavigatorKeys[i],
                builder: (ctx) => tabScreens[i],
              );
            },
          ),
        );
      },
    );
  }

  BottomNavigationBarItem bottomNavItemWidget(
    String icon,
    String text,
  ) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 7, top: 7),
        child: ImageIcon(
          AssetImage(icon),
          size: 22,
        ),
      ),
      label: text,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
