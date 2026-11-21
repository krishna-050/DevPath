import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SnackBarType { success, error, warning, info }

class AppSnackBar {
  static const Color _bgColor = Color(0xFFFFFFFF);
  static const Color _textColor = Color(0xFF222222);
  static const Color _subtextColor = Color(0xFF444444);

  static const Color _successGreen = Color(0xFF16A34A);
  static const Color _errorRed = Color(0xFFDC2626);
  static const Color _warningOrange = Color(0xFFF97316);
  static const Color _infoBlue = Color(0xFF1479D4);

  /// Automatically deduces the SnackBarType based on title and message
  static SnackBarType deduceType(String title, String message) {
    final combined = '$title $message'.toLowerCase();

    // Check for error keywords
    if (combined.contains('fail') ||
        combined.contains('error') ||
        combined.contains('wrong') ||
        combined.contains('could not') ||
        combined.contains('unable') ||
        combined.contains('invalid') ||
        combined.contains('expired') ||
        combined.contains('denied') ||
        combined.contains('cancel') ||
        combined.contains('weak')) {
      return SnackBarType.error;
    }

    // Check for success keywords
    if (combined.contains('success') ||
        combined.contains('verified') ||
        combined.contains('unlocked') ||
        combined.contains('mastered') ||
        combined.contains('saved') ||
        combined.contains('updated') ||
        combined.contains('created') ||
        combined.contains('welcome') ||
        combined.contains('copied') ||
        combined.contains('cleared') ||
        combined.contains('sent') ||
        combined.contains('🎉') ||
        combined.contains('deleted') ||
        combined.contains('removed')) {
      return SnackBarType.success;
    }

    // Check for warning keywords
    if (combined.contains('warn') ||
        combined.contains('require') ||
        combined.contains('missing') ||
        combined.contains('not verified') ||
        combined.contains('please verify') ||
        combined.contains('not found') ||
        combined.contains('no learning history') ||
        combined.contains('already')) {
      return SnackBarType.warning;
    }

    return SnackBarType.info;
  }

  static IconData _getIconData(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Icons.check_circle_rounded;
      case SnackBarType.error:
        return Icons.error_rounded;
      case SnackBarType.warning:
        return Icons.warning_rounded;
      case SnackBarType.info:
        return Icons.info_rounded;
    }
  }

  static Color _getIconColor(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return _successGreen;
      case SnackBarType.error:
        return _errorRed;
      case SnackBarType.warning:
        return _warningOrange;
      case SnackBarType.info:
        return _infoBlue;
    }
  }

  /// Displays a consistent, solid white, non-blurred SnackBar across the app.
  static void show({
    required String title,
    required String message,
    SnackBarType? type,
    SnackPosition snackPosition = SnackPosition.BOTTOM,
    Duration duration = const Duration(seconds: 3),
    TextButton? mainButton,
  }) {
    final resolvedType = type ?? deduceType(title, message);
    final iconColor = _getIconColor(resolvedType);
    final iconData = _getIconData(resolvedType);

    Get.snackbar(
      title,
      message,
      snackPosition: snackPosition,
      duration: duration,
      backgroundColor: _bgColor,
      colorText: _textColor,
      borderRadius: 16,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      barBlur: 0.0,
      overlayBlur: 0.0,
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutCubic,
      reverseAnimationCurve: Curves.easeInCubic,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 16,
          offset: const Offset(0, 4),
          spreadRadius: 1,
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
      icon: Container(
        padding: const EdgeInsets.only(left: 12, right: 4),
        child: Icon(iconData, color: iconColor, size: 26),
      ),
      titleText: Text(
        title,
        style: const TextStyle(
          color: _textColor,
          fontWeight: FontWeight.bold,
          fontSize: 14.5,
          letterSpacing: -0.2,
        ),
      ),
      messageText: Text(
        message,
        style: const TextStyle(
          color: _subtextColor,
          fontWeight: FontWeight.w500,
          fontSize: 13,
          height: 1.3,
        ),
      ),
      mainButton: mainButton,
    );
  }

  // Convenience methods
  static void success({
    required String title,
    required String message,
    SnackPosition snackPosition = SnackPosition.BOTTOM,
    Duration duration = const Duration(seconds: 3),
    TextButton? mainButton,
  }) {
    show(
      title: title,
      message: message,
      type: SnackBarType.success,
      snackPosition: snackPosition,
      duration: duration,
      mainButton: mainButton,
    );
  }

  static void error({
    required String title,
    required String message,
    SnackPosition snackPosition = SnackPosition.BOTTOM,
    Duration duration = const Duration(seconds: 3),
    TextButton? mainButton,
  }) {
    show(
      title: title,
      message: message,
      type: SnackBarType.error,
      snackPosition: snackPosition,
      duration: duration,
      mainButton: mainButton,
    );
  }

  static void warning({
    required String title,
    required String message,
    SnackPosition snackPosition = SnackPosition.BOTTOM,
    Duration duration = const Duration(seconds: 3),
    TextButton? mainButton,
  }) {
    show(
      title: title,
      message: message,
      type: SnackBarType.warning,
      snackPosition: snackPosition,
      duration: duration,
      mainButton: mainButton,
    );
  }

  static void info({
    required String title,
    required String message,
    SnackPosition snackPosition = SnackPosition.BOTTOM,
    Duration duration = const Duration(seconds: 3),
    TextButton? mainButton,
  }) {
    show(
      title: title,
      message: message,
      type: SnackBarType.info,
      snackPosition: snackPosition,
      duration: duration,
      mainButton: mainButton,
    );
  }
}
