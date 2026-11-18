
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class AiService {
  static const String _workerUrl =
      'https://learning-path-ai.krishnac-personal.workers.dev/chat';

  Future<String> sendMessage(String message) async {
    try {
      // Check whether the user is logged in.
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception('Your session has expired. Please login again.');
      }

      // Get Firebase ID token.
      final idToken = await user.getIdToken();

      if (idToken == null) {
        throw Exception('Unable to verify your account. Please login again.');
      }

      // Send message to Cloudflare Worker.
      final response = await http
          .post(
        Uri.parse(_workerUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $idToken',
        },
        body: jsonEncode({
          'message': message,
        }),
      )
          .timeout(const Duration(seconds: 60));

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        return data['reply'] ??
            'Sorry, I could not generate a response.';
      }

      throw Exception(
        data['error'] ?? 'Something went wrong. Please try again.',
      );
    } catch (e) {
      throw Exception('AI Error: $e');
    }
  }

  void resetChat() {
    // Worker currently handles each message independently.
    // No local chat session needs resetting.
  }
}
