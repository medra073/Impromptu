import 'package:flutter/material.dart';
import 'package:impromptu_project/data_provider/dashboard_provider.dart';
import 'package:impromptu_project/extras/app_assets.dart';
import 'package:impromptu_project/extras/colors.dart';
import 'package:impromptu_project/extras/extensions.dart';
import 'package:impromptu_project/screens/auth/delete_account.dart';
import 'package:impromptu_project/screens/splash/onboard_page.dart';
import 'package:impromptu_project/widgets/choice_box.dart';
import 'package:impromptu_project/widgets/custom_image.dart';
import 'package:impromptu_project/widgets/custom_text.dart';
import 'package:impromptu_project/widgets/margin_widget.dart';
import 'package:provider/provider.dart';
import '../../widgets/dashboard_background.dart';
import '../auth/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DashboardProvider provider;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<DashboardProvider>(context);

    return Scaffold(
      key: scaffoldKey,
      drawer: drawerWidget(context),
      body: DashboardBackground(
        childWidget: Padding(
          padding: const EdgeInsets.only(left: 35, right: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MarginWidget(factor: 3.5),
              InkWell(
                onTap: () {
                  scaffoldKey.currentState!.openDrawer();
                },
                child: const Icon(Icons.menu),
              ),
              const MarginWidget(factor: 2),
              greetings(),
              const MarginWidget(factor: 2),
              ChoiceBox(
                text: "Start Practice",
                onTap: () async {
                  provider.changeTab(1);
                },
              ),
              const MarginWidget(factor: 1.5),
              ChoiceBox(
                  onTap: () {
                    provider.changeTab(2);
                  },
                  text: "Review Practice"),
              const MarginWidget(factor: 1.5),
              ChoiceBox(
                  onTap: () {
                    provider.changeTab(3);
                  },
                  text: "Daily Challenge"),
            ],
          ),
        ),
      ),
    );
  }

  Drawer drawerWidget(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: CColors.mediumPurple,
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomAssetImage(
                      height: 100, width: 100, path: AppImages.logo),
                  const MarginWidget(isHorizontal: true),
                  CustomText(text: "IMPROMPTU")
                ],
              ),
            ),
          ),
          const MarginWidget(),
          ListTile(
            onTap: () {
              scaffoldKey.currentState!.closeDrawer();
              context.push(child: DeleteAccount());
            },
            leading: Icon(Icons.delete_forever, color: CColors.primary),
            title: const Text("Delete Account"),
            trailing: Icon(
              Icons.arrow_forward_ios_sharp,
              color: CColors.primary,
              size: 20,
            ),
          ),
          const MarginWidget(),
          const Expanded(child: SizedBox()),
          InkWell(
            onTap: () async {
              Navigator.of(context, rootNavigator: true).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => const OnboardScreen()));
              provider.isVisible = false;
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.logout, color: CColors.primary),
                const MarginWidget(isHorizontal: true, factor: 0.5),
                CustomText(text: "Logout", size: 16, color: CColors.primary),
                const MarginWidget(isHorizontal: true, factor: 1.5),
              ],
            ),
          ),
          const MarginWidget(factor: 5.5),
        ],
      ),
    );
  }

  Widget greetings() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomText(textAlign: TextAlign.left, text: "Hi, Tom"),
        ),
        CustomAssetImage(height: 95, width: 92, path: AppImages.logo),
      ],
    );
  }
}
