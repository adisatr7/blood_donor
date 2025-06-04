import 'package:flutter/material.dart';

import 'package:blood_donor/core/theme.dart';

class AiChatInput extends StatelessWidget {
  final TextEditingController messageController;
  final void Function() handleSendMessage;

  const AiChatInput({
    super.key,
    required this.messageController,
    required this.handleSendMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        children: [
          const SizedBox(width: 12),

          // Input field untuk mengetik pesan
          Expanded(
            child: TextField(
              autocorrect: false,
              autofocus: true,
              controller: messageController,
              decoration: const InputDecoration(
                hintText: 'Ketik pesan di sini...',
                border: InputBorder.none,
              ),
              onSubmitted: (_) => handleSendMessage(),
            ),
          ),

          // Tombol kirim pesan
          IconButton(
            icon: const Icon(Icons.send_rounded, color: AppColors.black),
            onPressed: handleSendMessage,
          ),
        ],
      ),
    );
  }
}
