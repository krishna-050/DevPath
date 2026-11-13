import 'package:dev_path/app/theme/app_color.dart';
import 'package:dev_path/controller/progress_controller.dart';
import 'package:dev_path/controller/saved_controller.dart';
import 'package:dev_path/data/roadmap_data.dart';
import 'package:dev_path/data/roadmap_step_data.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Stack(
        children: [
          // Top Organic Curved Blue Wave Design (Matching reference image)
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
                              icon: const Icon(
                                Icons.arrow_back_rounded,
                                color: AppColor.textPrimary,
                                size: 22,
                              ),
                              onPressed: () => Get.back(),
                            )
                          : const SizedBox(width: 44),
                      const Text(
                        'Profile',
                        style: TextStyle(
                          color: AppColor.textPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          letterSpacing: -0.3,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.settings_outlined,
                          color: AppColor.textPrimary,
                          size: 22,
                        ),
                        onPressed: () {},
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
                        // User Avatar & Info Section (Horizontal Row matching the image)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 8,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Left: Avatar with Edit Pencil Badge
                              Stack(
                                children: [
                                  Container(
                                    width: 88,
                                    height: 88,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColor.lightBlue,
                                      border: Border.all(
                                        color: Colors.white,
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
                                      backgroundColor: AppColor.lightBlue,
                                      child: Image.asset(
                                        'assets/images/app_icon.png',
                                        fit: BoxFit.contain,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(
                                          Icons.person_rounded,
                                          size: 48,
                                          color: AppColor.secondary,
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
                                          color: Colors.white,
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
                                    const Text(
                                      'Krishna',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.textPrimary,
                                        letterSpacing: -0.5,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    const Text(
                                      'Learner',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColor.textSecondary,
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
                                          color: const Color(0xFFF1F5F9),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.workspace_premium_outlined,
                                              size: 16,
                                              color: AppColor.primary,
                                            ),
                                            SizedBox(width: 6),
                                            Text(
                                              'Beginner',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: AppColor.textPrimary,
                                              ),
                                            ),
                                            SizedBox(width: 4),
                                            Icon(
                                              Icons.chevron_right_rounded,
                                              size: 16,
                                              color: AppColor.textSecondary,
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
                          final progressController =
                              Get.isRegistered<ProgressController>()
                                  ? Get.find<ProgressController>()
                                  : Get.put(ProgressController());

                          // Listen to reactive progress update trigger
                          progressController.progressUpdateTrigger.value;

                          final stats = calculateStats(progressController);
                          final completedCount = stats['completed'] ?? 0;
                          final totalTopicsCount = stats['topics'] ?? 0;
                          final pointsCount = totalTopicsCount * 25;

                          return Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            decoration: BoxDecoration(
                              color: AppColor.surface,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColor.border.withValues(alpha: 0.7),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.textPrimary
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
                                      const Icon(
                                        Icons.menu_book_rounded,
                                        color: AppColor.secondary,
                                        size: 26,
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        '$completedCount',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.textPrimary,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      const Text(
                                        'Courses\nCompleted',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: AppColor.textSecondary,
                                          height: 1.2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Container(
                                  height: 40,
                                  width: 1,
                                  color: AppColor.border,
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
                                      const Text(
                                        '12',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.textPrimary,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      const Text(
                                        'Day Streak',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: AppColor.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Container(
                                  height: 40,
                                  width: 1,
                                  color: AppColor.border,
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
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.textPrimary,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      const Text(
                                        'Total Points',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: AppColor.textSecondary,
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
                            color: AppColor.lightBlue,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: AppColor.secondary.withValues(alpha: 0.2),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
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
                                    const Text(
                                      'Keep Learning!',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.textPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    const Text(
                                      "You're doing great. Take the next step towards your goal.",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: AppColor.textSecondary,
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
                                onPressed: () {},
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
                          icon: Icons.person_outline_rounded,
                          iconColor: AppColor.secondary,
                          title: 'Account Information',
                          subtitle: 'View and edit your profile details',
                          onTap: () {},
                        ),
                        const SizedBox(height: 10),

                        _buildMenuItem(
                          icon: Icons.bar_chart_rounded,
                          iconColor: AppColor.primary,
                          title: 'Learning Statistics',
                          subtitle: 'Track your progress and insights',
                          onTap: () {},
                        ),
                        const SizedBox(height: 10),

                        _buildMenuItem(
                          icon: Icons.notifications_none_rounded,
                          iconColor: AppColor.secondary,
                          title: 'Notifications',
                          subtitle: 'Manage your notifications',
                          onTap: () {},
                        ),
                        const SizedBox(height: 10),

                        _buildMenuItem(
                          icon: Icons.shield_outlined,
                          iconColor: const Color(0xFF16A34A),
                          title: 'Privacy & Security',
                          subtitle: 'Control your data and privacy',
                          onTap: () {},
                        ),
                        const SizedBox(height: 10),

                        _buildMenuItem(
                          icon: Icons.help_outline_rounded,
                          iconColor: const Color(0xFF9333EA),
                          title: 'Help & Support',
                          subtitle: 'Get help or contact us',
                          onTap: () {},
                        ),
                        const SizedBox(height: 10),

                        _buildMenuItem(
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
                              backgroundColor: Colors.white,
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
                                backgroundColor: AppColor.surface,
                                colorText: AppColor.textPrimary,
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
          color: AppColor.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColor.border.withValues(alpha: 0.7),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColor.textPrimary.withValues(alpha: 0.03),
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
                color: iconColor.withValues(alpha: 0.1),
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
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColor.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColor.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColor.textSecondary,
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
    // 1. Soft blue base wave
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

    // 2. Medium blue wave accent on top right
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

    // 3. Deep blue wave accent on far right
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


