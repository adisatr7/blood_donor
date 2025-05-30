import 'package:get/get.dart';

import 'package:blood_donor/services/profile_service.dart';
import 'package:blood_donor/models/db/user.dart';

class GlobalController extends GetxController {
  final ProfileService _profileService = ProfileService.instance;
  Rxn<User> currentUser = Rxn<User>();

  /// Method untuk memperbarui data user yang sedang login
  void refreshCurrentUser() async {
    currentUser.value = await _profileService.getProfile();
  }

  /// Method untuk menghapus data user yang sedang login. Biasanya
  /// digunakan saat user keluar
  void clearCurrentUser() {
    currentUser.value = null;
  }
}
