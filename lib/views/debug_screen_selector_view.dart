import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:blood_donor/widgets/scaffolds/app_scaffold.dart';
import 'package:blood_donor/widgets/buttons/wide_button.dart';
import 'package:blood_donor/core/app_routes.dart';

class DebugScreenSelectorView extends StatelessWidget {
  const DebugScreenSelectorView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Debug Screen Selector',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          WideButton(
            label: 'Login',
            onPressed: () {
              Get.toNamed(AppRoutes.login);
            },
          ),
          SizedBox(height: 16),

          WideButton(
            label: 'Sign Up',
            onPressed: () {
              Get.toNamed(AppRoutes.signUp);
            },
          ),
          SizedBox(height: 16),

          WideButton(
            label: 'Address Sign Up',
            onPressed: () {
              Get.toNamed(AppRoutes.addressSignUp);
            },
          ),
          SizedBox(height: 16),

          WideButton(
            label: 'Home',
            onPressed: () {
              Get.toNamed(AppRoutes.home);
            },
          ),
          SizedBox(height: 16),

          WideButton(
            label: 'Settings',
            onPressed: () {
              Get.toNamed(AppRoutes.settings);
            },
          ),
          SizedBox(height: 16),

          WideButton(
            label: 'Questionare Form',
            onPressed: () {
              Get.toNamed(AppRoutes.questionareForm);
            },
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
