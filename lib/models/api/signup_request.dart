import 'package:dio/dio.dart';

import 'package:blood_donor/models/db/user.dart';

class SignupRequest {
  final User user;

  SignupRequest({required this.user});

  Future<FormData> toFormData() async {
    return await user.toFormData();
  }
}
