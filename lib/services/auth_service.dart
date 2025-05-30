import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import 'package:blood_donor/core/api_client.dart';
import 'package:blood_donor/models/api/login_request.dart';
import 'package:blood_donor/models/api/login_response.dart';
import 'package:blood_donor/models/api/signup_request.dart';
import 'package:blood_donor/models/api/signup_response.dart';

class AuthService {
  static final AuthService instance = AuthService();
  static final GetStorage _storageClient = GetStorage();
  final Dio _apiClient = ApiClient.instance;

  /// Login ke server dengan NIK dan password.
  Future<LoginResponse> login(LoginRequest request) async {
    // Kirim request ke server
    final response = await _apiClient.post(
      '/auth/login',
      data: request.toMap(),
    );

    // Handle error jika request gagal
    if (response.data == null || response.data['success'] == false) {
      throw Exception(
        'Login gagal dengan status code: ${response.statusCode}: ${response.data}',
      );
    }

    // Simpan token ke penyimpanan lokal
    _storageClient.write('token', response.data['token']);

    // Return data response ke controller
    return LoginResponse.fromMap(response.data);
  }

  /// Daftar akun baru ke server dengan data pengguna.
  Future<SignupResponse> signup(SignupRequest request) async {
    // Kirim request ke server
    final response = await _apiClient.post(
      '/auth/signup',
      data: await request.toFormData(),
    );

    // Handle error jika request gagal
    if (response.data == null || response.data['success'] == false) {
      throw Exception(
        'Pendaftaran gagal dengan status code: ${response.statusCode}: ${response.data}',
      );
    }

    // Simpan token ke penyimpanan lokal
    _storageClient.write('token', response.data['token']);

    // Return data response ke controller
    return SignupResponse.fromMap(response.data);
  }

  /// Logout dari server dengan menghapus token yang tersimpan.
  /// Ini akan menghapus token dari penyimpanan lokal sehingga pengguna
  /// harus login kembali untuk mengakses aplikasi
  void logout() {
    _storageClient.remove('token'); // Hapus token dari penyimpanan lokal
  }
}
