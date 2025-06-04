import 'package:dio/dio.dart';

import 'package:blood_donor/core/api_client.dart';
import 'package:blood_donor/models/db/ai_chat_message.dart';

class AiChatService {
  static final AiChatService instance = AiChatService();
  final Dio _apiClient = ApiClient.instance;

  /// Method untuk mengirim pesan ke AI
  Future<List<AiChatMessage>> sendMessage(AiChatMessage request) async {
    // Kirim pesan terbaru dari user melalui request POST ke server
    final response = await _apiClient.post('/ai/chat', data: request.toMap());

    // Handle error jika request gagal
    if (response.data == null || response.data['success'] == false) {
      throw Exception(
        'Gagal mengirim pesan ke AI dengan status code: ${response.statusCode}: ${response.data}',
      );
    }

    // Ambil data pesan dari response
    final List<dynamic> data = response.data['data'];
    return data.map((e) => AiChatMessage.fromMap(e)).toList();
  }

  /// Method untuk mengambil riwayat chat dengan AI
  Future<List<AiChatMessage>> getHistory() async {
    // Kirim request GET ke server untuk mengambil riwayat chat
    final response = await _apiClient.get('/ai/chat');

    // Handle error jika request gagal
    if (response.data == null || response.data['success'] == false) {
      throw Exception(
        'Gagal mengambil riwayat chat dengan status code: ${response.statusCode}: ${response.data}',
      );
    }

    // Ambil data riwayat chat untuk diserahkan ke Controller
    final List<dynamic> data = response.data['data'];
    return data.map((e) => AiChatMessage.fromMap(e)).toList();
  }

  /// Method untuk menghapus riwayat chat
  Future<void> clearHistory() async {
    // Kirim request DELETE ke server untuk menghapus riwayat chat
    final response = await _apiClient.delete('/ai/chat');

    // Handle error jika request gagal
    if (response.data == null || response.data['success'] == false) {
      throw Exception(
        'Gagal menghapus riwayat chat dengan status code: ${response.statusCode}: ${response.data}',
      );
    }
  }
}
