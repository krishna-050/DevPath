
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:dev_path/models/chat_message.dart';
import 'package:dev_path/services/ai_service.dart';

class AiController extends GetxController {
  final AiService _aiService = AiService();

  final RxList<ChatMessage> messages = <ChatMessage>[
    ChatMessage(
      text: 'Hello! 👋 I am your Personal AI mentor. Ask me anything about programming, concepts, or interview prep!',
      isUser: false,
      timeStamp: DateTime.now(),
    ),
  ].obs;

  final RxBool isTyping = false.obs;

  Future<void> sendMessage(String message) async {
    final query = message.trim();

    if (query.isEmpty || isTyping.value) return;

    messages.add(
      ChatMessage(
        text: query,
        isUser: true,
        timeStamp: DateTime.now(),
      ),
    );

    isTyping.value = true;

    try {
      final reply = await _aiService.sendMessage(query);

      messages.add(
        ChatMessage(
          text: reply,
          isUser: false,
          timeStamp: DateTime.now(),
        ),
      );
    } catch (e, stackTrace) {
      debugPrint('AI ERROR: $e');
      debugPrint('AI STACKTRACE: $stackTrace');

      messages.add(
        ChatMessage(
          text: 'Sorry! Something went wrong. Please try again.',
          isUser: false,
          timeStamp: DateTime.now(),
        ),
      );
    } finally {
      isTyping.value = false;
    }
  }

  void clearChat() {
    _aiService.resetChat();
    messages.clear();

    messages.add(
      ChatMessage(
        text: 'Chat reset ho gaya hai! Kahiye main aapki kya madad kar sakta hoon? 😊',
        isUser: false,
        timeStamp: DateTime.now(),
      ),
    );
  }
}
