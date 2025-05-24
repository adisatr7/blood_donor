import 'package:dio/dio.dart';

import 'package:blood_donor/core/api_client.dart';
import 'package:blood_donor/models/api/auth/login_request.dart';
import 'package:blood_donor/models/api/auth/login_response.dart';
import 'package:blood_donor/models/api/auth/signup_request.dart';
import 'package:blood_donor/models/api/auth/signup_response.dart';

class AuthService {
  static final AuthService instance = AuthService();
  late final Dio _apiClient = ApiClient.instance;

  /// Login ke server dengan NIK dan password.
  Future<LoginResponse> login(LoginRequest request) async {
    // Kirim request ke server
    final response = await _apiClient.post(
      '/auth/login',
      data: request.toJson(),
    );

    // Handle error jika request gagal
    if (response.data == null || response.data['success'] == false) {
      throw Exception(
        'Login gagal dengan status code: ${response.statusCode}: ${response.data}',
      );
    }

    // Return data response ke controller
    return LoginResponse.fromJson(response.data);
  }

  /// Daftar akun baru ke server dengan data pengguna.
  Future<SignupResponse> signup(SignupRequest request) async {
    // Kirim request ke server
    final response = await _apiClient.post(
      '/auth/signup',
      data: request.toFormData(),
    );

    // Handle error jika request gagal
    if (response.data == null || response.data['success'] == false) {
      throw Exception(
        'Pendaftaran gagal dengan status code: ${response.statusCode}: ${response.data}',
      );
    }

    // Return data response ke controller
    return SignupResponse.fromJson(response.data);
  }
}
