import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:blood_donor/core/theme.dart';
import 'package:blood_donor/core/app_routes.dart';
import 'package:blood_donor/views/login_view.dart';

void main() {
  // Initialize the app and routing
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      customTransition: AppViewTransition(),
      transitionDuration: const Duration(milliseconds: 300),
      getPages: [
        GetPage(
          name: AppRoutes.login,
          page: () => LoginView(),
        ),
      ],
      initialRoute: AppRoutes.login,
    ),
  );
}
