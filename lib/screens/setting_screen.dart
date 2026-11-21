import 'package:dev_path/Widgets/app_button_loader.dart';
import 'package:dev_path/Widgets/app_snackbar.dart';
import 'package:dev_path/app/theme/app_color.dart';
import 'package:dev_path/controller/notification_controller.dart';
import 'package:dev_path/controller/theme_controller.dart';
import 'package:dev_path/screens/about_app_screen.dart';
import 'package:dev_path/screens/account_info_screen.dart';
import 'package:dev_path/screens/help_support_screen.dart';
import 'package:dev_path/screens/privacy_security_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  // ── Safe Clear Cache Confirmation Dialog ──────────────────────────────
  void _showClearCacheDialog(BuildContext context, bool isDark) {
    final surfaceColor = isDark ? const Color(0xFF172235) : AppColor.surface;
    final textPrimaryColor = isDark ? Colors.white : AppColor.textPrimary;
    final textSecondaryColor = isDark
        ? const Color(0xFF94A3B8)
        : AppColor.textSecondary;
    final isClearing = ValueNotifier<bool>(false);

    Get.dialog(
      ValueListenableBuilder<bool>(
        valueListenable: isClearing,
        builder: (context, clearing, _) {
          return AlertDialog(
            backgroundColor: surfaceColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.cleaning_services_outlined,
                    color: Color(0xFFEF4444),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Clear Cache',
                  style: TextStyle(
                    color: textPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            content: Text(
              'This will clear temporary in-memory image and UI caches. Your saved roadmaps, learning progress, personal notes, and account data will NOT be deleted.',
              style: TextStyle(
                color: textSecondaryColor,
                fontSize: 13,
                height: 1.45,
              ),
            ),
            actions: [
              TextButton(
                onPressed: clearing ? null : () => Get.back(),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: textSecondaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEF4444),
                  foregroundColor: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size(100, 38),
                ),
                onPressed: clearing
                    ? null
                    : () async {
                        isClearing.value = true;
                        try {
                          // Clear memory and image provider caches safely
                          PaintingBinding.instance.imageCache.clear();
                          PaintingBinding.instance.imageCache.clearLiveImages();

                          // Short pause for tactile feedback
                          await Future.delayed(
                            const Duration(milliseconds: 400),
                          );

                          Get.back();

                          AppSnackBar.show(
                            title: 'Cache Cleared',
                            message: 'Temporary cache files have been cleared successfully.',
                            type: SnackBarType.success,
                          );
                        } catch (_) {
                          AppSnackBar.show(
                            title: 'Error',
                            message: 'Unable to clear cache. Please try again.',
                            type: SnackBarType.error,
                          );
                        } finally {
                          isClearing.value = false;
                        }
                      },
                child: clearing
                    ? const AppButtonLoader(size: 18)
                    : const Text(
                        'Clear Cache',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

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
        backgroundColor: isDark ? const Color(0xFF0B1220) : AppColor.background,
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
              Builder(
                builder: (context) {
                  final notificationController =
                      Get.isRegistered<NotificationController>()
                          ? Get.find<NotificationController>()
                          : Get.put(NotificationController(), permanent: true);

                  return Obx(() {
                    return Column(
                      children: [
                        _buildSwitchTile(
                          isDark: isDark,
                          icon: Icons.notifications_none_rounded,
                          iconColor: AppColor.secondary,
                          title: 'Push Notifications',
                          subtitle: 'Receive daily learning reminders',
                          value: notificationController
                              .isNotificationsEnabled
                              .value,
                          onChanged: (val) {
                            notificationController.toggleNotifications(val);
                          },
                        ),
                        const SizedBox(height: 10),

                        // Sound & Effects Switch
                        _buildSwitchTile(
                          isDark: isDark,
                          icon: Icons.volume_up_outlined,
                          iconColor: AppColor.primary,
                          title: 'Sound & Effects',
                          subtitle: 'Play sound with notifications & steps',
                          value:
                              notificationController.isSoundEnabled.value,
                          onChanged: (val) {
                            notificationController.toggleSound(val);
                          },
                        ),
                      ],
                    );
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
                onTap: () {
                  Get.to(() => const AccountInfoScreen());
                },
              ),
              const SizedBox(height: 10),

              _buildActionTile(
                isDark: isDark,
                icon: Icons.shield_outlined,
                iconColor: const Color(0xFF16A34A),
                title: 'Privacy & Security',
                subtitle: 'Control your data and privacy',
                onTap: () {
                  Get.to(() => const PrivacySecurityScreen());
                },
              ),
              const SizedBox(height: 10),

              _buildActionTile(
                isDark: isDark,
                icon: Icons.help_outline_rounded,
                iconColor: const Color(0xFF9333EA),
                title: 'Help & Support',
                subtitle: 'Get help or contact us',
                onTap: () {
                  Get.to(() => const HelpSupportScreen());
                },
              ),
              const SizedBox(height: 10),

              _buildActionTile(
                isDark: isDark,
                icon: Icons.info_outline_rounded,
                iconColor: AppColor.primary,
                title: 'About App',
                subtitle: 'Version 1.0.0',
                onTap: () {
                  Get.to(() => const AboutAppScreen());
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
                onTap: () => _showClearCacheDialog(context, isDark),
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
                        color: isDark ? const Color(0xFF172235) : Colors.white,
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
                      'Learning Path • v1.0.0',
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
                        color: isDark ? Colors.white38 : AppColor.textSecondary,
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
            child: Icon(icon, color: iconColor, size: 22),
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
              child: Icon(icon, color: iconColor, size: 22),
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
              color: isDark ? const Color(0xFF94A3B8) : AppColor.textSecondary,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
