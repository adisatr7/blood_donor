import 'package:get/get.dart';
import 'package:blood_donor/models/user.dart';

class GlobalController extends GetxController {
  final Rxn<User> _currentUser = Rxn<User>();

  /// Getter for currentUser
  User? get currentUser => _currentUser.value;

  /// Setter for currentUser
  set currentUser(User? user) {
    _currentUser.value = user;
  }

  /// Check if the user is logged in
  bool isLoggedIn() {
    return currentUser != null;
  }
}
