import 'package:dev_path/app/theme/app_color.dart';
import 'package:dev_path/controller/home_controller.dart';
import 'package:dev_path/controller/progress_controller.dart';
import 'package:dev_path/data/roadmap_step_data.dart';
import 'package:dev_path/models/roadmap_model.dart';
import 'package:dev_path/screens/roadmap_detail_screen.dart';
import 'package:dev_path/screens/personal_ai_screen.dart';
import 'package:dev_path/Widgets/roadmap_progress_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onExploreTap;
  const HomeScreen({super.key, required this.onExploreTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    final controller = Get.isRegistered<HomeController>()
        ? Get.find<HomeController>()
        : Get.put(HomeController());

    final progressController = Get.isRegistered<ProgressController>()
        ? Get.find<ProgressController>()
        : Get.put(ProgressController());

    final isTablet = screenWidth > 600;
    final horizontalPadding = screenWidth * 0.045;
    final gridCrossAxisCount = isTablet ? 3 : 2;

    final bgColor = isDark ? const Color(0xFF0B1220) : AppColor.background;
    final surfaceColor = isDark ? const Color(0xFF172235) : AppColor.surface;
    final textPrimaryColor = isDark ? Colors.white : AppColor.textPrimary;
    final textSecondaryColor = isDark
        ? const Color(0xFF94A3B8)
        : AppColor.textSecondary;
    final borderColor = isDark ? const Color(0xFF334155) : AppColor.border;

    final user = FirebaseAuth.instance.currentUser;
    final userName = user?.displayName?.isNotEmpty == true
        ? user!.displayName!
        : 'Developer';

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bgColor,
        titleSpacing: horizontalPadding,
        title: Row(
          children: [
            // App Branding Logo
            Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E293B) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: borderColor),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.secondary.withValues(alpha: 0.12),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Image.asset(
                'assets/images/app_icon.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 10),

            // Title & Subtitle Column
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Learning Path',
                  style: TextStyle(
                    color: textPrimaryColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    letterSpacing: -0.4,
                  ),
                ),
                Text(
                  'Structured Learning Paths',
                  style: TextStyle(
                    color: textSecondaryColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          // Personal AI Chat Button

          // User Profile Avatar
          Padding(
            padding: EdgeInsets.only(right: horizontalPadding, left: 2.0),
            child: CircleAvatar(
              radius: 17,
              backgroundColor: isDark
                  ? const Color(0xFF1E293B)
                  : AppColor.lightBlue,
              child: Text(
                userName.substring(0, 1).toUpperCase(),
                style: TextStyle(
                  color: isDark ? const Color(0xFF60A5FA) : AppColor.secondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),

                // 1. Welcome Greeting Header
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello, $userName 👋',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: textPrimaryColor,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            'What skill do you want to master today?',
                            style: TextStyle(
                              fontSize: 13,
                              color: textSecondaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // 2. Quick Stats Highlights Strip
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: borderColor),
                    boxShadow: [
                      BoxShadow(
                        color: textPrimaryColor.withValues(alpha: 0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem(
                        icon: Icons.alt_route_rounded,
                        iconColor: const Color(0xFF0072FF),
                        title: '${controller.roadmapList.length}+',
                        subtitle: 'Roadmaps',
                        isDark: isDark,
                        textPrimary: textPrimaryColor,
                        textSecondary: textSecondaryColor,
                      ),
                      Container(height: 28, width: 1, color: borderColor),
                      _buildStatItem(
                        icon: Icons.check_circle_outline_rounded,
                        iconColor: const Color(0xFF10B981),
                        title: '9800+',
                        subtitle: 'Topics',
                        isDark: isDark,
                        textPrimary: textPrimaryColor,
                        textSecondary: textSecondaryColor,
                      ),
                      Container(height: 28, width: 1, color: borderColor),
                      _buildStatItem(
                        icon: Icons.workspace_premium_rounded,
                        iconColor: const Color(0xFFF59E0B),
                        title: '100%',
                        subtitle: 'Free & Curated',
                        isDark: isDark,
                        textPrimary: textPrimaryColor,
                        textSecondary: textSecondaryColor,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // 3. Hero Showcase Banner
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(screenWidth * 0.05),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isDark
                          ? [
                              const Color(0xFF1E293B),
                              const Color(0xFF0F172A),
                              const Color(0xFF1E3A8A),
                            ]
                          : [
                              const Color(0xFF0F172A),
                              const Color(0xFF1E3A8A),
                              const Color(0xFF2563EB),
                            ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1E3A8A).withValues(alpha: 0.35),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '⚡ FEATURED ROADMAP',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: screenWidth * 0.60,
                            child: const Text(
                              'Master Flutter & Modern Development',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                height: 1.25,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          SizedBox(
                            width: screenWidth * 0.58,
                            child: const Text(
                              'Complete step-by-step roadmap from Dart syntax to full architecture.',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                                height: 1.35,
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 10,
                              ),
                              elevation: 3,
                              shadowColor: AppColor.primary.withValues(
                                alpha: 0.4,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              final flutterRoadmap =
                                  controller.roadmapList.isNotEmpty
                                  ? controller.roadmapList.first
                                  : null;
                              Get.to(
                                () => RoadmapDetailScreen(
                                  roadmap: flutterRoadmap,
                                ),
                              );
                            },
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Start Flutter Path',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 6),
                                Icon(Icons.arrow_forward_rounded, size: 16),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        right: -10,
                        bottom: -15,
                        top: 0,
                        child: Icon(
                          Icons.alt_route_rounded,
                          size: screenWidth * 0.28,
                          color: Colors.white.withValues(alpha: 0.12),
                        ),
                      ),
                    ],
                  ),
                ),

                // 4. Continue Learning Section (Shows if any progress made)
                Obx(() {
                  progressController.progressUpdateTrigger.value;
                  final inProgressRoadmaps = controller.roadmapList.where((r) {
                    final steps = RoadmapStepData.getStepsForLanguage(
                      r.language,
                    );
                    final completed = progressController.getCompletedTopicCount(
                      r.language,
                      steps,
                    );
                    return completed > 0;
                  }).toList();

                  if (inProgressRoadmaps.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 22),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Continue Learning',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: textPrimaryColor,
                              letterSpacing: -0.3,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF10B981)
                                  .withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '${inProgressRoadmaps.length} in progress',
                              style: const TextStyle(
                                color: Color(0xFF10B981),
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 120,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: inProgressRoadmaps.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 12),
                          itemBuilder: (context, index) {
                            final roadmap = inProgressRoadmaps[index];
                            return _buildContinueLearningCard(
                              roadmap: roadmap,
                              surfaceColor: surfaceColor,
                              borderColor: borderColor,
                              textPrimaryColor: textPrimaryColor,
                              textSecondaryColor: textSecondaryColor,
                              isDark: isDark,
                              progressController: progressController,
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }),

                const SizedBox(height: 22),

                // 5. Popular Roadmaps Section Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Popular Roadmaps',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                            color: textPrimaryColor,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Top developer career tracks',
                          style: TextStyle(
                            fontSize: 12,
                            color: textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: onExploreTap,
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF1E293B)
                              : AppColor.lightBlue,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'View All',
                              style: TextStyle(
                                color: AppColor.secondary,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.5,
                              ),
                            ),
                            SizedBox(width: 3),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 11,
                              color: AppColor.secondary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // 6. Roadmaps Grid (Cards Redesigned)
                Obx(() {
                  final list = controller.roadmapList;
                  final displayCount = list.length > 6 ? 6 : list.length;

                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: displayCount,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gridCrossAxisCount,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: isTablet ? 1.05 : 0.79,
                    ),
                    itemBuilder: (context, index) {
                      final item = list[index];
                      return _buildRoadmapGridCard(
                        item: item,
                        surfaceColor: surfaceColor,
                        borderColor: borderColor,
                        textPrimaryColor: textPrimaryColor,
                        textSecondaryColor: textSecondaryColor,
                        isDark: isDark,
                      );
                    },
                  );
                }),

                const SizedBox(height: 26),

                // 7. "Why Learning Path?" Learning Pillars Banner (Bottom Feature Strip)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isDark
                          ? [const Color(0xFF172235), const Color(0xFF1E293B)]
                          : [
                              const Color(0xFFEEF6FF),
                              const Color(0xFFF6FAFE),
                              Colors.white,
                            ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isDark
                          ? const Color(0xFF334155)
                          : const Color(0xFFBAE6FD),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: textPrimaryColor.withValues(alpha: 0.04),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0072FF)
                                  .withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.auto_awesome_rounded,
                              color: Color(0xFF0072FF),
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Why Learn with Learning Path?',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: textPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildPillarRow(
                        icon: Icons.checklist_rounded,
                        color: const Color(0xFF10B981),
                        title: 'Step-by-step roadmap structure',
                        subtitle:
                            'Never get lost wondering what to learn next.',
                        textPrimary: textPrimaryColor,
                        textSecondary: textSecondaryColor,
                      ),
                      const SizedBox(height: 8),
                      _buildPillarRow(
                        icon: Icons.library_books_outlined,
                        color: const Color(0xFF8B5CF6),
                        title: 'Curated high-quality resources',
                        subtitle: 'Official documentation, codelabs, and playgrounds.',
                        textPrimary: textPrimaryColor,
                        textSecondary: textSecondaryColor,
                      ),
                      const SizedBox(height: 8),
                      _buildPillarRow(
                        icon: Icons.insights_rounded,
                        color: const Color(0xFFF97316),
                        title: 'Interactive topic tracking',
                        subtitle: 'Mark topics completed and monitor your real growth.',
                        textPrimary: textPrimaryColor,
                        textSecondary: textSecondaryColor,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool isDark,
    required Color textPrimary,
    required Color textSecondary,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 18, color: iconColor),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: textPrimary,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 10.5,
                color: textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContinueLearningCard({
    required RoadmapModel roadmap,
    required Color surfaceColor,
    required Color borderColor,
    required Color textPrimaryColor,
    required Color textSecondaryColor,
    required bool isDark,
    required ProgressController progressController,
  }) {
    final steps = RoadmapStepData.getStepsForLanguage(roadmap.language);
    final total = progressController.getTotalTopicCount(steps);
    final completed = progressController.getCompletedTopicCount(
      roadmap.language,
      steps,
    );
    final progress = total > 0 ? completed / total : 0.0;
    final percentage = (progress * 100).toInt();

    return InkWell(
      onTap: () {
        Get.to(() => RoadmapDetailScreen(roadmap: roadmap));
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 240,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor),
          boxShadow: [
            BoxShadow(
              color: textPrimaryColor.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF1E293B)
                        : AppColor.lightBlue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(
                    roadmap.imgUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.code_rounded,
                      size: 20,
                      color: AppColor.secondary,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        roadmap.language,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: textPrimaryColor,
                        ),
                      ),
                      Text(
                        '$completed of $total topics done',
                        style: TextStyle(
                          fontSize: 11,
                          color: textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '$percentage%',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF10B981),
                  ),
                ),
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 5,
                backgroundColor: isDark
                    ? const Color(0xFF334155)
                    : const Color(0xFFE2EAF2),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF10B981),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  roadmap.category,
                  style: TextStyle(
                    fontSize: 11,
                    color: textSecondaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Row(
                  children: [
                    Text(
                      'Resume',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.bold,
                        color: AppColor.primary,
                      ),
                    ),
                    SizedBox(width: 2),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 13,
                      color: AppColor.primary,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoadmapGridCard({
    required RoadmapModel item,
    required Color surfaceColor,
    required Color borderColor,
    required Color textPrimaryColor,
    required Color textSecondaryColor,
    required bool isDark,
  }) {
    return InkWell(
      onTap: () {
        Get.to(() => RoadmapDetailScreen(roadmap: item));
      },
      borderRadius: BorderRadius.circular(18),
      child: Container(
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: borderColor),
          boxShadow: [
            BoxShadow(
              color: textPrimaryColor.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Logo & Category Chip
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF1E293B)
                        : AppColor.lightBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset(
                    item.imgUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.code_rounded,
                      color: isDark
                          ? const Color(0xFF60A5FA)
                          : AppColor.secondary,
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF332014)
                          : AppColor.lightOrange,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      item.category,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColor.primary,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Roadmap Title
            Text(
              item.language,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: textPrimaryColor,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 3),

            // Roadmap Description
            Expanded(
              child: Text(
                item.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: textSecondaryColor,
                  fontSize: 11.5,
                  height: 1.3,
                ),
              ),
            ),
            const SizedBox(height: 6),

            // Roadmap Progress Widget
            RoadmapProgressWidget(roadmap: item),
          ],
        ),
      ),
    );
  }

  Widget _buildPillarRow({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required Color textPrimary,
    required Color textSecondary,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Icon(icon, color: color, size: 16),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: textPrimary,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(fontSize: 11, color: textSecondary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
