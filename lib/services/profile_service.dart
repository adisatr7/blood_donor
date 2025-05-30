import 'package:dio/dio.dart';
import 'dart:io';

import 'package:blood_donor/core/api_client.dart';
import 'package:blood_donor/models/db/user.dart';
import 'package:blood_donor/models/api/edit_password_request.dart';

class ProfileService {
  static final ProfileService instance = ProfileService();
  late final Dio _apiClient = ApiClient.instance;

  /// Ambil data profil pengguna dari server.
  Future<User> getProfile() async {
    // Kirim request GET ke server
    final response = await _apiClient.get('/profile');

    // Handle error jika request gagal
    if (response.data == null || response.data['success'] == false) {
      throw Exception(
        'Gagal mengambil profil dengan status code: ${response.statusCode}: ${response.data}',
      );
    }

    // Ambil data profil pengguna untuk diserahkan ke Controller
    return User.fromMap(response.data['data']);
  }

  /// Update data profil pengguna di server (bukan foto profil)
  Future<User> updateProfile(User request) async {
    // Kirim request PATCH ke server dengan data terbaru sebagai request
    final response = await _apiClient.patch('/profile', data: request.toMap());

    // Handle error jika request gagal
    if (response.data == null || response.data['success'] == false) {
      throw Exception(
        'Gagal memperbarui profil dengan status code: ${response.statusCode}: ${response.data}',
      );
    }

    // Serahkan profil profil terbaru ke Controller
    return User.fromMap(response.data['data']);
  }

  /// Update foto profil pengguna di server
  Future<User> updateProfilePicture(File imageFile) async {
    // Buat FormData untuk mengirim file gambar
    final request = FormData.fromMap({
      'profilePicture': await MultipartFile.fromFile(imageFile.path),
    });

    // Kirim request PATCH ke server dengan FormData
    final response = await _apiClient.patch(
      '/profile/update-profile-picture',
      data: request,
    );

    // Handle error jika request gagal
    if (response.data == null || response.data['success'] == false) {
      throw Exception(
        'Gagal memperbarui foto profil dengan status code: ${response.statusCode}: ${response.data}',
      );
    }

    // Serahkan data profil terbaru ke Controller
    return User.fromMap(response.data['data']);
  }

  /// Ubah dan simpan kata sandi user ke database
  Future<void> updatePassword(EditPasswordRequest request) async {
    // Kirim request PATCH ke server
    final response = await _apiClient.patch(
      '/profile/edit-password',
      data: request.toMap(),
    );

    // Handle error jika request gagal
    if (response.data == null || response.data['success'] == false) {
      throw Exception(
        'Gagal memperbarui kata sandi dengan status code: ${response.statusCode}: ${response.data}',
      );
    }
  }
}
