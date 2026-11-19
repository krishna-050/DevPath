import 'package:dev_path/app/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  Future<void> _openEmailSupport() async {
    final uri = Uri(
      scheme: 'mailto',
      path: 'support@learningpath.app',
      queryParameters: {
        'subject': 'Learning Path App Support Request',
      },
    );

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        Get.snackbar(
          'Contact Support',
          'Reach us at support@learningpath.app',
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
        );
      }
    } catch (_) {
      Get.snackbar(
        'Contact Support',
        'Reach us at support@learningpath.app',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
    }
  }

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
          'Help & Support',
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Contact Banner Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF172235)
                      : AppColor.lightBlue,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isDark
                        ? const Color(0xFF334155)
                        : AppColor.secondary.withValues(alpha: 0.25),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF9333EA)
                                .withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.support_agent_rounded,
                            color: Color(0xFF9333EA),
                            size: 26,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Need Assistance?',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: textPrimaryColor,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'We are here to help your learning journey',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: textSecondaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 46,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primary,
                          foregroundColor: Colors.white,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: _openEmailSupport,
                        icon: const Icon(Icons.mail_rounded, size: 18),
                        label: const Text(
                          'Contact via Email',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Frequently Asked Questions Header
              Text(
                'Frequently Asked Questions',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isDark ? const Color(0xFF60A5FA) : AppColor.secondary,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 10),

              _buildFaqItem(
                isDark: isDark,
                question: 'How do I track my learning progress?',
                answer:
                    'Open any roadmap from Explore or Home, select a step, and check off completed topics. Your streak, points, and completion percentage update automatically.',
              ),
              const SizedBox(height: 10),

              _buildFaqItem(
                isDark: isDark,
                question: 'Can I use Learning Path offline?',
                answer:
                    'Yes! Your completed progress, personal notes, and saved roadmaps are stored locally on your device and remain accessible anytime.',
              ),
              const SizedBox(height: 10),

              _buildFaqItem(
                isDark: isDark,
                question: 'How do I add personal notes to topics?',
                answer:
                    'Navigate to any learning step detail and tap the "Add Note" section. All your notes can be managed together in "My Notes".',
              ),
              const SizedBox(height: 10),

              _buildFaqItem(
                isDark: isDark,
                question: 'How do I earn badges and trophies?',
                answer:
                    'Complete roadmap steps, keep up your daily streak, and master topics to automatically unlock achievements and badges in your Profile.',
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFaqItem({
    required bool isDark,
    required String question,
    required String answer,
  }) {
    final surfaceColor = isDark ? const Color(0xFF172235) : AppColor.surface;
    final textPrimaryColor = isDark ? Colors.white : AppColor.textPrimary;
    final textSecondaryColor =
        isDark ? const Color(0xFF94A3B8) : AppColor.textSecondary;
    final borderColor = isDark ? const Color(0xFF334155) : AppColor.border;

    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Theme(
        data: ThemeData(dividerColor: Colors.transparent),
        child: ExpansionTile(
          iconColor: AppColor.secondary,
          collapsedIconColor: textSecondaryColor,
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          childrenPadding:
              const EdgeInsets.only(left: 16, right: 16, bottom: 14),
          title: Text(
            question,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: textPrimaryColor,
            ),
          ),
          children: [
            Text(
              answer,
              style: TextStyle(
                fontSize: 13,
                color: textSecondaryColor,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
