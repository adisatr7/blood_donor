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
    return User.fromJson(response.data['data']);
  }
}
