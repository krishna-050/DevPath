import 'package:dev_path/app/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = isDark ? const Color(0xFF172235) : AppColor.surface;
    final textPrimaryColor = isDark ? Colors.white : AppColor.textPrimary;
    final textSecondaryColor =
        isDark ? const Color(0xFF94A3B8) : AppColor.textSecondary;
    final borderColor = isDark ? const Color(0xFF334155) : AppColor.border;

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
            color: textPrimaryColor,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'About App',
          style: TextStyle(
            color: textPrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              // Branding Header Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: borderColor),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF1E293B)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: isDark
                              ? const Color(0xFF334155)
                              : AppColor.border,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.secondary.withValues(alpha: 0.15),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/images/app_icon.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Learning Path',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: textPrimaryColor,
                            letterSpacing: -0.4,
                          ),
                        ),
                        Container(
                          width: 6,
                          height: 6,
                          margin: const EdgeInsets.only(left: 4, top: 4),
                          decoration: const BoxDecoration(
                            color: AppColor.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Version 1.0.0 (Build 1)',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: textSecondaryColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Learn skills. Build projects. Grow your career.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: textSecondaryColor,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Purpose & Features Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: borderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About Learning Path',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: textPrimaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Learning Path is a comprehensive developer learning platform designed to guide developers from fundamentals to mastery across frontend, backend, mobile, cloud, AI, and cybersecurity.',
                      style: TextStyle(
                        fontSize: 13,
                        color: textSecondaryColor,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildFeatureBullet(
                      isDark: isDark,
                      icon: Icons.alt_route_rounded,
                      title: 'Structured Roadmaps',
                      desc: 'Curated step-by-step tracks for 15+ tech stacks.',
                    ),
                    const SizedBox(height: 10),
                    _buildFeatureBullet(
                      isDark: isDark,
                      icon: Icons.check_circle_outline_rounded,
                      title: 'Progress & Streaks',
                      desc: 'Real-time topic tracking, day streaks, and stats.',
                    ),
                    const SizedBox(height: 10),
                    _buildFeatureBullet(
                      isDark: isDark,
                      icon: Icons.emoji_events_outlined,
                      title: 'Badges & Achievements',
                      desc: 'Earn rewards as you hit milestones and master topics.',
                    ),
                    const SizedBox(height: 10),
                    _buildFeatureBullet(
                      isDark: isDark,
                      icon: Icons.edit_note_rounded,
                      title: 'Personal Notes',
                      desc: 'Capture personal code snippets and thoughts offline.',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Legal & Footer
              Text(
                '© 2026 Learning Path. All rights reserved.',
                style: TextStyle(
                  fontSize: 11,
                  color: textSecondaryColor.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureBullet({
    required bool isDark,
    required IconData icon,
    required String title,
    required String desc,
  }) {
    final textPrimaryColor = isDark ? Colors.white : AppColor.textPrimary;
    final textSecondaryColor =
        isDark ? const Color(0xFF94A3B8) : AppColor.textSecondary;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: AppColor.secondary),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: textPrimaryColor,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 12,
                  color: textSecondaryColor,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
