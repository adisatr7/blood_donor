import 'package:flutter/material.dart';

import 'package:blood_donor/models/db/ai_chat_message.dart';
import 'package:blood_donor/core/theme.dart';

class AiChatBubble extends StatelessWidget {
  final AiChatMessage message;

  const AiChatBubble({super.key, required this.message});

  /// Dekorasi tampilan chat bubble
  BoxDecoration get _chatBubbleDecoration {
    return BoxDecoration(
      // Warna bubble
      color:
          message.sender == ChatSender.user
              ? AppColors
                  .primary // Merah untuk user
              : AppColors.white, // Putih untuk AI
      // Efek sudut bundar/halus
      borderRadius: BorderRadius.only(
        topLeft: const Radius.circular(16),
        topRight: const Radius.circular(16),
        // Sudut bawah dibuat lancip tergantung siapa pengirimnya
        // Untuk lebih jelas, lihat saja langsung di UI-nya
        bottomLeft:
            message.sender == ChatSender.user
                ? const Radius.circular(16)
                : const Radius.circular(0),
        bottomRight:
            message.sender == ChatSender.user
                ? const Radius.circular(0)
                : const Radius.circular(16),
      ),
      boxShadow: [AppStyles.cardShadow], // Efek bayangan
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMe = message.sender == ChatSender.user;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          // Margin atas untuk memberi jarak antar pesan
          top: 16,
          // Margin kiri/kanan tergantung siapa yang mengirim
          left: isMe ? 48 : 8,
          right: isMe ? 8 : 48,
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: _chatBubbleDecoration,
        child: Text(
          message.message,
          style: isMe ? AppTextStyles.bodyWhite : AppTextStyles.body,
        ),
      ),
    );
  }
}
