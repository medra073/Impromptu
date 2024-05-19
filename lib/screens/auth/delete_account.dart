import 'package:flutter/material.dart';
import 'package:impromptu_project/extras/app_assets.dart';
import 'package:impromptu_project/extras/colors.dart';
import 'package:impromptu_project/extras/functions.dart';
import 'package:impromptu_project/widgets/custom_image.dart';
import 'package:impromptu_project/widgets/custom_text.dart';
import 'package:impromptu_project/widgets/margin_widget.dart';
import 'package:impromptu_project/widgets/primary_button.dart';
import 'package:impromptu_project/widgets/text_field_widget.dart';
import '../splash/onboard_page.dart';

class DeleteAccount extends StatefulWidget {
  @override
  State<DeleteAccount> createState() => _DeleteAccount();
}

class _DeleteAccount extends State<DeleteAccount> {
  late TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CColors.primary,
        elevation: 0,
        title: CustomText(
          text: "Delete Account",
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const MarginWidget(factor: 3),
              CustomAssetImage(height: 170, width: 170, path: AppImages.logo),
              const MarginWidget(factor: 2),
              CustomText(
                text:
                    "Instructions: Please note that deleting your account is irreversible and will result in the permanent loss of all data associated with it.",
                size: 13,
                textAlign: TextAlign.center,
              ),
              const MarginWidget(factor: 5),
                TextFieldWidget(
                  controller: password,
                  hint: "Password",
                  prefixWidget: Icons.lock,
                  labelText: 'Password',
                ),
                const MarginWidget(factor: 3),
              PrimaryButton(
                  onPressed: () async {
                    Navigator.of(context, rootNavigator: true)
                        .pushReplacement(MaterialPageRoute(
                        builder: (context) => const OnboardScreen()));

                    Functions.showSnackBar(context, 'Account Deleted');
                  },
                  text: "Delete Account",
                  textColor: Colors.white),
            ],
          ),
        ),
      ),
    );
  }


}
