import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:blood_donor/controllers/ai_chat_controller.dart';
import 'package:blood_donor/core/theme.dart';
import 'package:blood_donor/widgets/buttons/app_back_button.dart';
import 'package:blood_donor/widgets/ai_chat/ai_chat_bubble.dart';
import 'package:blood_donor/widgets/ai_chat/ai_chat_input.dart';

class AiChatView extends StatelessWidget {
  final AiChatController controller = Get.put(AiChatController());

  AiChatView({super.key});

  Widget _buildTypingIndicator() {
    return Container(
      color: AppColors.secondary,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: const Row(
          children: [
            SpinKitThreeBounce(color: AppColors.gray, size: 24.0),
            SizedBox(width: 8),
            Text('AI sedang mengetik...', style: AppTextStyles.bodyGray),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Row(
              children: [
                // Tombol kembali
                AppBackButton(label: ''),

                // Judul halaman
                const Expanded(
                  child: Text(
                    'Chat dengan AI',
                    style: AppTextStyles.subheading,
                    textAlign: TextAlign.center,
                  ),
                ),

                // Tombol untuk menghapus chat
                IconButton(
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    color: AppColors.danger,
                  ),
                  onPressed: controller.handleClearChat,
                  tooltip: 'Hapus Chat',
                ),
              ],
            ),

            // Area chat yang dapat di-scrol
            Expanded(
              child: Container(
                color: AppColors.secondary,
                child: Obx(() {
                  final int msgCount = controller.messages.length;

                  return ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: msgCount,
                    itemBuilder: (context, index) {
                      final message = controller.messages[msgCount - 1 - index];

                      return AiChatBubble(message: message);
                    },
                  );
                }),
              ),
            ),

            // Animasi ketika AI sedang mengetik
            Obx(
              () =>
                  controller.isAiTyping.value
                      ? _buildTypingIndicator()
                      : const SizedBox.shrink(),
            ),

            // Kotak input untuk mengirim pesan
            const Divider(height: 1),
            AiChatInput(
              messageController: controller.messageController,
              handleSendMessage: controller.handleSendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
