import 'package:get/get.dart';
import 'package:blood_donor/core/app_routes.dart';

class SettingsController extends GetxController {
  /// Go to edit profile
  void goToEditProfile() {
    Get.toNamed(AppRoutes.editProfile);
  }

  /// Go to address settings
  void goToEditAddress() {
    Get.toNamed(AppRoutes.editAddress);
  }

  /// Go to change password
  void goToEditPassword() {
    Get.toNamed(AppRoutes.editPassword);
  }

  /// Logout the user
  void logout() {
    // TODO: Implement logout logic here
    // For example, clear user session and navigate to login screen
    // Get.offAllNamed(AppRoutes.login);
  }
}
