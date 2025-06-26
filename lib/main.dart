import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:blood_donor/controllers/global_controller.dart';
import 'package:blood_donor/core/theme.dart';
import 'package:blood_donor/core/app_routes.dart';
import 'package:blood_donor/views/login_view.dart';
import 'package:blood_donor/views/signup_view.dart';
import 'package:blood_donor/views/address_signup_view.dart';
import 'package:blood_donor/views/home_view.dart';
import 'package:blood_donor/views/map_view.dart';
import 'package:blood_donor/views/about_view.dart';
import 'package:blood_donor/views/questionare_form_view.dart';
import 'package:blood_donor/views/appointment_detail_view.dart';
import 'package:blood_donor/views/pdf_print_view.dart';
import 'package:blood_donor/views/ai_chat_view.dart';
import 'package:blood_donor/views/settings_view.dart';
import 'package:blood_donor/views/edit_profile_view.dart';
import 'package:blood_donor/views/edit_address_view.dart';
import 'package:blood_donor/views/edit_password_view.dart';

void main() async {
  // Pastikan binding Flutter sudah diinisialisasi sebelum memanggil fungsi lain
  WidgetsFlutterBinding.ensureInitialized();

  // Muat data dari file `.env`
  await dotenv.load(fileName: '.env');

  // Atur format tanggal untuk bahasa Indonesia
  await initializeDateFormatting('id', null);

  // Inisiasi GlobalController agar data user dapat diakses di seluruh halaman di aplikasi
  Get.put(GlobalController(), permanent: true);

  // Initialize the app and routing
  runApp(
    GetMaterialApp(
      theme: ThemeData(primaryColor: AppColors.white),
      debugShowCheckedModeBanner: false,
      customTransition: AppViewTransition(),
      transitionDuration: const Duration(milliseconds: 300),
      getPages: [
        GetPage(name: AppRoutes.login, page: () => LoginView()),
        GetPage(name: AppRoutes.signup, page: () => SignupView()),
        GetPage(name: AppRoutes.addressSignup, page: () => AddressSignupView()),
        GetPage(name: AppRoutes.home, page: () => HomeView()),
        GetPage(name: AppRoutes.map, page: () => MapView()),
        GetPage(name: AppRoutes.about, page: () => AboutView()),
        GetPage(name: AppRoutes.questionareForm, page: () => QuestionnaireFormView()),
        GetPage(name: AppRoutes.appointmentDetail, page: () => AppointmentDetailView()),
        GetPage(name: AppRoutes.pdfPrint, page: () => PdfPrintView()),
        GetPage(name: AppRoutes.aiChat, page: () => AiChatView()),
        GetPage(name: AppRoutes.settings, page: () => SettingsView()),
        GetPage(name: AppRoutes.editProfile, page: () => EditProfileView()),
        GetPage(name: AppRoutes.editAddress, page: () => EditAddressView()),
        GetPage(name: AppRoutes.editPassword, page: () => EditPasswordView()),
      ],
      initialRoute: AppRoutes.login,
    ),
  );
}
