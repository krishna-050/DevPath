import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final GetStorage box = GetStorage();

  final Rx<ThemeMode> selectedTheme = ThemeMode.light.obs;

  bool get isDarkMode => selectedTheme.value == ThemeMode.dark;

  @override
  void onInit() {
    super.onInit();
    final savedTheme = box.read('themeMode') ?? 'light';
    changeTheme(savedTheme);
  }

  void changeTheme(String value) {
    final theme = switch (value) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };

    selectedTheme.value = theme;
    box.write('themeMode', value);
    Get.changeThemeMode(theme);
  }

  void toggleTheme(bool isDark) {
    changeTheme(isDark ? 'dark' : 'light');
  }
}
