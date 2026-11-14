import 'package:dev_path/app/theme/app_color.dart';
import 'package:dev_path/controller/theme_controller.dart';
import 'package:dev_path/screens/webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _notificationsEnabled = true;
  bool _soundEnabled = true;

  @override
  Widget build(BuildContext context) {
    final themeController = Get.isRegistered<ThemeController>()
        ? Get.find<ThemeController>()
        : Get.put(ThemeController(), permanent: true);

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0B1220) : AppColor.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            isDark ? const Color(0xFF0B1220) : AppColor.background,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: isDark ? Colors.white : AppColor.textPrimary,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Settings',
          style: TextStyle(
            color: isDark ? Colors.white : AppColor.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Appearance Section Header
              _buildSectionHeader('Appearance', isDark),
              const SizedBox(height: 10),

              // Dark Mode Switch Tile
              Obx(() {
                final isDarkMode = themeController.isDarkMode;
                return _buildSwitchTile(
                  isDark: isDark,
                  icon: isDarkMode
                      ? Icons.dark_mode_rounded
                      : Icons.light_mode_rounded,
                  iconColor: isDarkMode
                      ? const Color(0xFF60A5FA)
                      : const Color(0xFFEAB308),
                  title: 'Dark Mode',
                  subtitle: isDarkMode
                      ? 'Dark theme is currently active'
                      : 'Switch to Dark Mode for night reading',
                  value: isDarkMode,
                  onChanged: (val) {
                    themeController.toggleTheme(val);
                  },
                );
              }),

              const SizedBox(height: 24),

              // 2. Preferences & Notifications Header
              _buildSectionHeader('Preferences', isDark),
              const SizedBox(height: 10),

              // Push Notifications Switch
              _buildSwitchTile(
                isDark: isDark,
                icon: Icons.notifications_none_rounded,
                iconColor: AppColor.secondary,
                title: 'Push Notifications',
                subtitle: 'Receive daily learning reminders',
                value: _notificationsEnabled,
                onChanged: (val) {
                  setState(() {
                    _notificationsEnabled = val;
                  });
                },
              ),
              const SizedBox(height: 10),

              // Sound & Effects Switch
              _buildSwitchTile(
                isDark: isDark,
                icon: Icons.volume_up_outlined,
                iconColor: AppColor.primary,
                title: 'Sound & Effects',
                subtitle: 'Play sound on topic completion',
                value: _soundEnabled,
                onChanged: (val) {
                  setState(() {
                    _soundEnabled = val;
                  });
                },
              ),

              const SizedBox(height: 24),

              // 3. Account & Security Header
              _buildSectionHeader('Account & Security', isDark),
              const SizedBox(height: 10),

              _buildActionTile(
                isDark: isDark,
                icon: Icons.person_outline_rounded,
                iconColor: AppColor.secondary,
                title: 'Account Information',
                subtitle: 'View & update account profile',
                onTap: () {},
              ),
              const SizedBox(height: 10),

              _buildActionTile(
                isDark: isDark,
                icon: Icons.lock_outline_rounded,
                iconColor: const Color(0xFF16A34A),
                title: 'Privacy Policy',
                subtitle: 'Read our privacy policy & terms',
                onTap: () {
                  Get.to(
                    () => const WebViewScreen(
                      url: 'https://roadmap.sh/privacy',
                      title: 'Privacy Policy',
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              // 4. Storage & Data Header
              _buildSectionHeader('Data & Storage', isDark),
              const SizedBox(height: 10),

              _buildActionTile(
                isDark: isDark,
                icon: Icons.cleaning_services_outlined,
                iconColor: const Color(0xFFEF4444),
                title: 'Clear Cache',
                subtitle: 'Free up local temporary files',
                onTap: () {
                  Get.snackbar(
                    'Cache Cleared',
                    'Temporary files have been cleaned up.',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: isDark
                        ? const Color(0xFF172235)
                        : AppColor.surface,
                    colorText: isDark ? Colors.white : AppColor.textPrimary,
                    margin: const EdgeInsets.all(16),
                    borderRadius: 12,
                  );
                },
              ),

              const SizedBox(height: 28),

              // App Version Footer Card
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF172235)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isDark
                              ? const Color(0xFF334155)
                              : AppColor.border,
                        ),
                      ),
                      child: Image.asset(
                        'assets/images/app_icon.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'DevPath • v1.0.0',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white70 : AppColor.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Build skills. Build projects. Grow career.',
                      style: TextStyle(
                        fontSize: 11,
                        color: isDark
                            ? Colors.white38
                            : AppColor.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, bool isDark) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: isDark ? const Color(0xFF60A5FA) : AppColor.secondary,
        letterSpacing: 0.2,
      ),
    );
  }

  Widget _buildSwitchTile({
    required bool isDark,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF172235) : AppColor.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? const Color(0xFF334155) : AppColor.border,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColor.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark
                        ? const Color(0xFF94A3B8)
                        : AppColor.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            activeThumbColor: AppColor.primary,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile({
    required bool isDark,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF172235) : AppColor.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? const Color(0xFF334155) : AppColor.border,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : AppColor.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark
                          ? const Color(0xFF94A3B8)
                          : AppColor.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: isDark
                  ? const Color(0xFF94A3B8)
                  : AppColor.textSecondary,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
