import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:blood_donor/controllers/global_controller.dart';
import 'package:blood_donor/core/theme.dart';
import 'package:blood_donor/core/app_routes.dart';
import 'package:blood_donor/views/login_view.dart';
import 'package:blood_donor/views/signup_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Register global controllers
  Get.put(GlobalController(), permanent: true);

  // Initialize the app and routing
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      customTransition: AppViewTransition(),
      transitionDuration: const Duration(milliseconds: 300),
      getPages: [
        GetPage(name: AppRoutes.login, page: () => LoginView()),
        GetPage(name: AppRoutes.signUp, page: () => SignUpView()),
      ],
      initialRoute: AppRoutes.login,
    ),
  );
}
