import 'package:blood_donor/core/api_client.dart';
import 'package:blood_donor/models/db/appointment.dart';
import 'package:dio/dio.dart';

class AppointmentService {
  static final AppointmentService instance = AppointmentService();
  final Dio _apiClient = ApiClient.instance;

  /// Ambil daftar sesi kunjungan milik user dari server
  Future<List<Appointment>> getAppointments() async {
    // Kirim request GET ke server
    final response = await _apiClient.get('/appointments');

    // Handle error jika request gagal
    if (response.data == null || response.data['success'] == false) {
      throw Exception(
        'Gagal mengambil daftar sesi kunjungan dengan status code: ${response.statusCode}: ${response.data}',
      );
    }

    // Ambil data sesi kunjungan untuk diserahkan ke Controller
    final List<dynamic> data = response.data['data'];
    return data.map((e) => Appointment.fromJson(e)).toList();
  }
}
