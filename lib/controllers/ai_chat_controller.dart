import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:blood_donor/services/ai_chat_service.dart';
import 'package:blood_donor/models/db/ai_chat_message.dart';
import 'package:blood_donor/widgets/popups/app_dialog.dart';

class AiChatController extends GetxController {
  final AiChatService _aiChatService = AiChatService.instance;

  final TextEditingController messageController = TextEditingController();
  final RxList<AiChatMessage> messages = <AiChatMessage>[].obs;

  final RxBool isAiTyping = false.obs;

  @override
  void onReady() {
    super.onReady();
    _fetchMessages(); // Ambil riwayat percakapan saat user membuka halaman
  }

  /// Method untuk mengirim pesan baru
  void handleSendMessage() async {
    try {
      // Ambil text pesan dari controller
      final messageText = messageController.text.trim();

      // Validasi pesan tidak boleh kosong
      if (messageText.isEmpty) {
        showAppDialog(
          title: 'Pesan Tidak Boleh Kosong',
          message: 'Silakan masukkan pesan sebelum mengirim.',
        );
        return;
      }

      // Siapkan request payload untuk dikirim
      final request = AiChatMessage(
        sender: ChatSender.user,
        message: messageText,
      );

      // Mulai animasi mengetik
      isAiTyping.value = true;

      // Kirim pesan ke service AI dan tunggu respons
      final response = await _aiChatService.sendMessage(request);

      // Hapus teks di input field setelah mengirim pesan
      messageController.clear();

      // Tampilkan pesan-pesan baru di UI
      messages.assignAll(response);
    } on Exception catch (e) {
      // Tampilkan pesan error jika gagal
      showAppError('Gagal Mengirim Pesan', e);
    } finally {
      // Hentikan animasi loading
      isAiTyping.value = false;
    }
  }

  /// Method untuk menghapus riwayat percakapan
  void handleClearChat() {
    // Tampilkan dialog konfirmasi sebelum menghapus chat
    showAppDialog(
      title: 'Hapus Percakapan?',
      message: 'Percakapan yang sudah dihapus tidak dapat dikembalikan.',
      confirmText: 'Hapus',
      cancelText: 'Batal',
      onConfirm: () async {
        try {
          await _aiChatService.clearHistory();
          messages.clear();
        } on Exception catch (e) {
          showAppError('Gagal Menghapus Percakapan', e);
        }
      },
    );
  }

  /// Method internal untuk mengambil riwayat percakapan
  void _fetchMessages() async {
    try {
      // Ambil riwayat percakapan dari service
      messages.assignAll(await _aiChatService.getHistory());
    } on Exception catch (e) {
      // Tampilkan pesan error jika gagal
      showAppError('Gagal Memuat Percakapan', e);
    }
  }
}
