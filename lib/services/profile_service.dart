import 'package:dio/dio.dart';

import 'package:blood_donor/core/api_client.dart';
import 'package:blood_donor/models/db/user.dart';

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
  Future<User> updateProfile(User user) async {
    // Kirim request PUT ke server dengan data pengguna
    final response = await _apiClient.put('/profile', data: user.toMap());

    // Handle error jika request gagal
    if (response.data == null || response.data['success'] == false) {
      throw Exception(
        'Gagal memperbarui profil dengan status code: ${response.statusCode}: ${response.data}',
      );
    }

    // Kembalikan data profil yang telah diperbarui
    return User.fromMap(response.data['data']);
  }
}
