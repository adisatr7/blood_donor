import 'package:blood_donor/widgets/popups/app_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

import 'package:blood_donor/core/app_routes.dart';

class ApiClient {
  static final Dio instance = Dio(
      BaseOptions(
        baseUrl: '${dotenv.env['API_URL']}/api/v1',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    )
    ..interceptors.add(
      InterceptorsWrapper(
        // Masukkan token ke dalam header semua request
        onRequest: _injectToken,
        // Handle segala macam error
        onError: (DioException error, handler) async {
          // Cek apakah ada masalah koneksi
          _checkforConnectionError(error, handler);

          // Cek apakah token kadaluarsa
          _checkForExpiredToken(error, handler);

          // Jika error disebabkan karena hal lain, lanjutkan request agar
          // error handling diurus oleh controller
          handler.next(error);
        },
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

  /// Method internal untuk mengecek apakah ada masalah koneksi
  static void _checkforConnectionError(DioException error, handler) {
    // Jika error karena masalah koneksi, tampilkan dialog error
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.connectionError) {
      // Buat pesan error untuk ditampilkan di View
      DioException newError = DioException(
        requestOptions: error.requestOptions,
        type: DioExceptionType.connectionError,
        message: 'Koneksi ke server gagal. Periksa koneksi internet Anda.',
      );

      handler.reject(newError); // Jangan lanjutkan request
    }
  }

  /// Method internal untuk mengecek apakah token sudah kadaluarsa
  /// atau tidak valid. Jika ya, hapus semua token dari penyimpanan lokal
  /// dan lempar user kembali ke halaman login
  static void _checkForExpiredToken(DioException error, handler) {
    // Jika error 403, berarti token sudah kadaluarsa atau tidak valid
    if (error.response?.statusCode == 403) {
      GetStorage().erase(); // Hapus semua token dari storage
      Get.offAllNamed(AppRoutes.login); // Lempar ke halaman login

      // Tampilkan dialog untuk memberitahu user mereka harus login lagi
      showAppDialog(
        title: 'Sesi Kadaluarsa',
        message: 'Silakan masuk kembali ke akun Anda.',
      );

      handler.reject(error); // Jangan lanjutkan request
    }
  }
}
