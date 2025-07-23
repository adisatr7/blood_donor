import 'package:dio/dio.dart';

import 'package:blood_donor/core/api_client.dart';
import 'package:blood_donor/models/db/appointment.dart';
import 'package:blood_donor/models/api/create_appointment_request.dart';

class AppointmentService {
  static final AppointmentService instance = AppointmentService();
  final Dio _apiClient = ApiClient.instance;

  /// Method untuk mendaftar sesi kunjungan baru
  Future<void> create(CreateAppointmentRequest request) async {
    // Kirim request POST ke server dengan payload
    final response = await _apiClient.post(
      '/appointments',
      data: request.toMap(),
    );

    // Handle error jika request gagal
    if (response.data == null || response.data['success'] == false) {
      throw Exception(
        'Gagal mendaftar sesi kunjungan dengan status code: ${response.statusCode}: ${response.data}',
      );
    }
  }

  /// Ambil daftar sesi kunjungan milik user dari server
  Future<List<Appointment>> getAll() async {
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
    return data.map((e) => Appointment.fromMap(e)).toList();
  }

  /// Ambil sesi kunjungan berdasarkan ID
  Future<Appointment> getById(int id) async {
    // Kirim request GET ke server untuk mengambil sesi kunjungan berdasarkan ID
    final response = await _apiClient.get('/appointments/$id');

    // Handle error jika request gagal
    if (response.data == null || response.data['success'] == false) {
      throw Exception(
        'Gagal mengambil sesi kunjungan dengan ID $id: ${response.statusCode}: ${response.data}',
      );
    }

    // Ambil data sesi kunjungan untuk diserahkan ke Controller
    return Appointment.fromMap(response.data['data']);
  }

  /// Method untuk upload PDF formulir pendaftaran
  Future<void> uploadPdf(int id, String filePath) async {
    // Kirim request POST ke server untuk mengupload PDF
    final formData = FormData.fromMap({
      'pdf': await MultipartFile.fromFile(filePath),
    });

    final response = await _apiClient.post(
      '/appointments/$id/pdf',
      data: formData,
    );

    // Handle error jika request gagal
    if (response.data == null || response.data['success'] == false) {
      throw Exception(
        'Gagal mengupload PDF untuk sesi kunjungan ID $id (${response.statusCode}): ${response.data}',
      );
    }
  }
}
