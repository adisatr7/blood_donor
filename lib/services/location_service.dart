import 'package:dio/dio.dart';

import 'package:blood_donor/core/api_client.dart';
import 'package:blood_donor/models/db/location.dart';

class LocationService {
  static final LocationService instance = LocationService();
  final Dio _apiClient = ApiClient.instance;

  /// Mengambil semua lokasi dari server
  Future<List<Location>> getAll() async {
    final response = await _apiClient.get('/locations');

    if (response.data == null || response.data['success'] == false) {
      throw Exception('Gagal mengambil lokasi: ${response.statusCode}');
    }

    return (response.data['data'] as List)
        .map((loc) => Location.fromMap(loc))
        .toList();
  }

  /// Mencari nama lokasi berdasarkan query
  Future<List<Location>> search(String query) async {
    // Jika query kosong, serahkan hasil kosong. Pastikan di
    // MapController jika search query kosong, panggil method
    // getAllLocations() saja
    if (query.isEmpty) {
      return [];
    }

    final response = await _apiClient.get(
      '/locations/search',
      queryParameters: {'name': query},
    );

    if (response.data == null || response.data['success'] == false) {
      throw Exception('Gagal mencari lokasi: ${response.statusCode}');
    }

    return (response.data['data'] as List)
        .map((loc) => Location.fromMap(loc))
        .toList();
  }
}
