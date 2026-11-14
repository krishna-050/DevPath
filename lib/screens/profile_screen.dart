import 'package:dev_path/app/theme/app_color.dart';
import 'package:dev_path/controller/progress_controller.dart';
import 'package:dev_path/data/roadmap_data.dart';
import 'package:dev_path/data/roadmap_step_data.dart';
import 'package:dev_path/screens/achievements_screen.dart';
import 'package:dev_path/screens/learning_statistics_screen.dart';
import 'package:dev_path/screens/setting_screen.dart';
import 'package:dev_path/screens/step_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Map<String, int> calculateStats(
    ProgressController controller,
  ) {
    int completedRoadmaps = 0;
    int completedTopics = 0;

    for (final roadmap in RoadmapData.roadmaps) {
      final steps = RoadmapStepData.getStepsForLanguage(
        roadmap.language,
      );

      final total = controller.getTotalTopicCount(steps);

      final completed = controller.getCompletedTopicCount(
        roadmap.language,
        steps,
      );

      completedTopics += completed;

      if (total > 0 && completed == total) {
        completedRoadmaps++;
      }
    }

    return {
      'roadmaps': completedRoadmaps,
      'topics': completedTopics,
    };
  }

  void continueLearning(ProgressController controller) {
    final roadmapTitle = controller.getLastRoadmap();
    final stepId = controller.getLastStepId();

    if (roadmapTitle == null || stepId == null) {
      Get.snackbar(
        'No Learning History',
        'Start a roadmap to continue your learning.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final roadmaps = RoadmapData.roadmaps
        .where((roadmap) => roadmap.language == roadmapTitle)
        .toList();

    if (roadmaps.isEmpty) {
      Get.snackbar('Not Found', 'Roadmap could not be found.');
      return;
    }

    final steps = RoadmapStepData.getStepsForLanguage(roadmapTitle);
    final matchingSteps =
        steps.where((step) => step.id == stepId).toList();

    if (matchingSteps.isEmpty) {
      Get.snackbar('Not Found', 'Learning step could not be found.');
      return;
    }

    Get.to(
      () => StepDetailScreen(
        step: matchingSteps.first,
        roadmapTitle: roadmapTitle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final progressController = Get.find<ProgressController>();

    final bgColor = isDark ? const Color(0xFF0B1220) : AppColor.background;
    final surfaceColor = isDark ? const Color(0xFF172235) : AppColor.surface;
    final textPrimaryColor = isDark ? Colors.white : AppColor.textPrimary;
    final textSecondaryColor =
        isDark ? const Color(0xFF94A3B8) : AppColor.textSecondary;
    final borderColor = isDark ? const Color(0xFF334155) : AppColor.border;
    final pillBgColor = isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9);

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          // Top Organic Curved Blue Wave Design
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 170,
            child: CustomPaint(
              painter: _TopWavePainter(),
            ),
          ),

          // Main Content
          SafeArea(
            child: Column(
              children: [
                // Top Custom Header / AppBar
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Navigator.canPop(context)
                          ? IconButton(
                              icon: Icon(
                                Icons.arrow_back_rounded,
                                color: textPrimaryColor,
                                size: 22,
                              ),
                              onPressed: () => Get.back(),
                            )
                          : const SizedBox(width: 44),
                      Text(
                        'Profile',
                        style: TextStyle(
                          color: textPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          letterSpacing: -0.3,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.settings_outlined,
                          color: textPrimaryColor,
                          size: 22,
                        ),
                        onPressed: () {
                          Get.to(() => const SettingScreen());
                        },
                      ),
                    ],
                  ),
                ),

                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Column(
                      children: [
                        // User Avatar & Info Section (Horizontal Row)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 8,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Left: Avatar with Edit Badge
                              Stack(
                                children: [
                                  Container(
                                    width: 88,
                                    height: 88,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isDark
                                          ? const Color(0xFF1E293B)
                                          : AppColor.lightBlue,
                                      border: Border.all(
                                        color: isDark
                                            ? const Color(0xFF334155)
                                            : Colors.white,
                                        width: 3,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColor.secondary
                                              .withValues(alpha: 0.12),
                                          blurRadius: 16,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: CircleAvatar(
                                      radius: 42,
                                      backgroundColor: isDark
                                          ? const Color(0xFF1E293B)
                                          : AppColor.lightBlue,
                                      child: Image.asset(
                                        'assets/images/app_icon.png',
                                        fit: BoxFit.contain,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Icon(
                                          Icons.person_rounded,
                                          size: 48,
                                          color: isDark
                                              ? const Color(0xFF60A5FA)
                                              : AppColor.secondary,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: AppColor.secondary,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: isDark
                                              ? const Color(0xFF0B1220)
                                              : Colors.white,
                                          width: 2,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.edit_rounded,
                                        size: 13,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(width: 18),

                              // Right: User Name, Role & Level Badge
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Krishna',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: textPrimaryColor,
                                        letterSpacing: -0.5,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Learner',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: textSecondaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    InkWell(
                                      onTap: () {},
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: pillBgColor,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(
                                              Icons.workspace_premium_outlined,
                                              size: 16,
                                              color: AppColor.primary,
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              'Beginner',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: textPrimaryColor,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            Icon(
                                              Icons.chevron_right_rounded,
                                              size: 16,
                                              color: textSecondaryColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Stats Overview Card (3 Columns)
                        Obx(() {

                          progressController.progressUpdateTrigger.value;
                          final currentStreak = progressController.getCurrentStreak();

                          final stats = calculateStats(progressController);
                          final completedCount = stats['roadmaps'] ?? 0;
                          final totalTopicsCount = stats['topics'] ?? 0;
                          final pointsCount = totalTopicsCount * 25;

                          return Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            decoration: BoxDecoration(
                              color: surfaceColor,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: borderColor,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: textPrimaryColor
                                      .withValues(alpha: 0.04),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // Col 1: Courses Completed
                                Expanded(
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.menu_book_rounded,
                                        color: isDark
                                            ? const Color(0xFF60A5FA)
                                            : AppColor.secondary,
                                        size: 26,
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        '$completedCount',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: textPrimaryColor,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'Courses\nCompleted',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: textSecondaryColor,
                                          height: 1.2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Container(
                                  height: 40,
                                  width: 1,
                                  color: borderColor,
                                ),

                                // Col 2: Day Streak
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Icon(
                                        Icons.local_fire_department_rounded,
                                        color: AppColor.primary,
                                        size: 26,
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        currentStreak.toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: textPrimaryColor,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'Day Streak',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: textSecondaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Container(
                                  height: 40,
                                  width: 1,
                                  color: borderColor,
                                ),

                                // Col 3: Total Points
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Icon(
                                        Icons.star_rounded,
                                        color: Color(0xFFEAB308),
                                        size: 26,
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        '$pointsCount',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: textPrimaryColor,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'Total Points',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: textSecondaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),

                        const SizedBox(height: 16),

                        // Keep Learning Banner Card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF1E293B)
                                : AppColor.lightBlue,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: isDark
                                  ? const Color(0xFF334155)
                                  : AppColor.secondary.withValues(alpha: 0.2),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? const Color(0xFF172235)
                                      : Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.emoji_events_rounded,
                                  color: Color(0xFFEAB308),
                                  size: 26,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Keep Learning!',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: textPrimaryColor,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      "You're doing great. Take the next step towards your goal.",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: textSecondaryColor,
                                        height: 1.3,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.primary,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 10,
                                  ),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {
                                  continueLearning(progressController);
                                },
                                child: const Text(
                                  'Continue →',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Menu List Items
                        _buildMenuItem(
                          isDark: isDark,
                          icon: Icons.person_outline_rounded,
                          iconColor: isDark
                              ? const Color(0xFF60A5FA)
                              : AppColor.secondary,
                          title: 'Account Information',
                          subtitle: 'View and edit your profile details',
                          onTap: () {},
                        ),
                        const SizedBox(height: 10),

                        _buildMenuItem(
                          isDark: isDark,
                          icon: Icons.bar_chart_rounded,
                          iconColor: AppColor.primary,
                          title: 'Learning Statistics',
                          subtitle: 'Track your progress and insights',
                          onTap: () {
                            Get.to(() => const LearningStatisticsScreen());
                          },
                        ),
                        const SizedBox(height: 10),

                        _buildMenuItem(
                          isDark: isDark,
                          icon: Icons.emoji_events_outlined,
                          iconColor: const Color(0xFFEAB308),
                          title: 'Achievements & Badges',
                          subtitle: 'View unlocked trophies and rewards',
                          onTap: () {
                            Get.to(() => const AchievementsScreen());
                          },
                        ),
                        const SizedBox(height: 10),

                        _buildMenuItem(
                          isDark: isDark,
                          icon: Icons.notifications_none_rounded,
                          iconColor: isDark
                              ? const Color(0xFF60A5FA)
                              : AppColor.secondary,
                          title: 'Notifications',
                          subtitle: 'Manage your notifications',
                          onTap: () {},
                        ),
                        const SizedBox(height: 10),

                        _buildMenuItem(
                          isDark: isDark,
                          icon: Icons.shield_outlined,
                          iconColor: const Color(0xFF16A34A),
                          title: 'Privacy & Security',
                          subtitle: 'Control your data and privacy',
                          onTap: () {},
                        ),
                        const SizedBox(height: 10),

                        _buildMenuItem(
                          isDark: isDark,
                          icon: Icons.help_outline_rounded,
                          iconColor: const Color(0xFF9333EA),
                          title: 'Help & Support',
                          subtitle: 'Get help or contact us',
                          onTap: () {},
                        ),
                        const SizedBox(height: 10),

                        _buildMenuItem(
                          isDark: isDark,
                          icon: Icons.info_outline_rounded,
                          iconColor: AppColor.primary,
                          title: 'About App',
                          subtitle: 'Version 1.0.0',
                          onTap: () {},
                        ),

                        const SizedBox(height: 20),

                        // Logout Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: isDark
                                  ? const Color(0xFF172235)
                                  : Colors.white,
                              side: BorderSide(
                                color: AppColor.primary.withValues(alpha: 0.6),
                                width: 1.5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              Get.snackbar(
                                'Logout',
                                'Successfully logged out.',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: surfaceColor,
                                colorText: textPrimaryColor,
                                margin: const EdgeInsets.all(16),
                                borderRadius: 12,
                              );
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.logout_rounded,
                                  color: AppColor.primary,
                                  size: 20,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Logout',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
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
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.15)
                  : AppColor.textPrimary.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
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

class _TopWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintBase = Paint()
      ..color = const Color(0xFFD6EBFF).withValues(alpha: 0.8)
      ..style = PaintingStyle.fill;

    final pathBase = Path();
    pathBase.moveTo(0, 0);
    pathBase.lineTo(0, size.height * 0.7);
    pathBase.quadraticBezierTo(
      size.width * 0.35,
      size.height * 1.15,
      size.width * 0.75,
      size.height * 0.65,
    );
    pathBase.quadraticBezierTo(
      size.width * 0.9,
      size.height * 0.45,
      size.width,
      size.height * 0.55,
    );
    pathBase.lineTo(size.width, 0);
    pathBase.close();
    canvas.drawPath(pathBase, paintBase);

    final paintAccent = Paint()
      ..color = const Color(0xFF60A5FA).withValues(alpha: 0.45)
      ..style = PaintingStyle.fill;

    final pathAccent = Path();
    pathAccent.moveTo(size.width * 0.45, 0);
    pathAccent.quadraticBezierTo(
      size.width * 0.65,
      size.height * 0.8,
      size.width,
      size.height * 0.6,
    );
    pathAccent.lineTo(size.width, 0);
    pathAccent.close();
    canvas.drawPath(pathAccent, paintAccent);

    final paintDeep = Paint()
      ..color = const Color(0xFF2563EB).withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;

    final pathDeep = Path();
    pathDeep.moveTo(size.width * 0.7, 0);
    pathDeep.quadraticBezierTo(
      size.width * 0.82,
      size.height * 0.9,
      size.width,
      size.height * 0.75,
    );
    pathDeep.lineTo(size.width, 0);
    pathDeep.close();
    canvas.drawPath(pathDeep, paintDeep);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
