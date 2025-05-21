import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

import 'package:blood_donor/core/app_routes.dart';

class ApiClient {
  static final Dio instance =
      Dio(
          BaseOptions(
            baseUrl: dotenv.env['API_URL'] ?? '',
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
          ),
        )
        ..interceptors.add(
          InterceptorsWrapper(
            // Masukkan token ke dalam header semua request
            onRequest: _injectToken,
            // Cek apakah token sudah kadaluarsa setiap ada error
            onError: _checkForExpiredToken,
          ),
        );

  /// Method internal untuk menyuntikkan token ke dalam header setiap request
  /// yang dikirim ke server. Beberapa API endpoint di Backend memerlukan
  /// token untuk alasan keamanan
  static void _injectToken(options, handler) {
    // Ambil token dari penyimpanan lokal
    final String? token = GetStorage().read('token');
    // Jika ada token, masukkan ke dalam header Authorization
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    // Lanjutkan ke interceptor berikutnya
    handler.next(options);
  }

  /// Method internal untuk mengecek apakah token sudah kadaluarsa
  /// atau tidak valid. Jika ya, hapus semua token dari penyimpanan lokal
  /// dan lempar user kembali ke halaman login
  static void _checkForExpiredToken(DioException error, handler) async {
    // Jika error 403, berarti token sudah kadaluarsa atau tidak valid
    if (error.response?.statusCode == 403) {
      // Hapus semua token dari storage
      GetStorage().erase();
      // Lempar ke halaman login
      Get.offAllNamed(AppRoutes.login);
      // Jangan lanjutkan request
      handler.reject(error);
    }
    // Jika error disebabkan karena hal lain, lanjutkan request agar
    // error handling diurus oleh controller
    handler.next(error);
  }
}
