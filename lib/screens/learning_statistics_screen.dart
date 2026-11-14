import 'package:dev_path/app/theme/app_color.dart';
import 'package:dev_path/controller/progress_controller.dart';
import 'package:dev_path/data/roadmap_data.dart';
import 'package:dev_path/data/roadmap_step_data.dart';
import 'package:dev_path/models/roadmap_model.dart';
import 'package:dev_path/screens/achievements_screen.dart';
import 'package:dev_path/screens/roadmap_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LearningStatisticsScreen extends StatelessWidget {
  const LearningStatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final progressController = Get.isRegistered<ProgressController>()
        ? Get.find<ProgressController>()
        : Get.put(ProgressController());

    final bgColor = isDark ? const Color(0xFF0B1220) : AppColor.background;
    final surfaceColor = isDark ? const Color(0xFF172235) : AppColor.surface;
    final textPrimaryColor = isDark ? Colors.white : AppColor.textPrimary;
    final textSecondaryColor =
        isDark ? const Color(0xFF94A3B8) : AppColor.textSecondary;
    final borderColor = isDark ? const Color(0xFF334155) : AppColor.border;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bgColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: textPrimaryColor,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Learning Statistics',
          style: TextStyle(
            color: textPrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          // Listen to reactive progress updates
          progressController.progressUpdateTrigger.value;

          int overallTotalTopics = 0;
          int overallCompletedTopics = 0;

          final roadmapStatsList = <Map<String, dynamic>>[];

          for (final roadmap in RoadmapData.roadmaps) {
            final steps =
                RoadmapStepData.getStepsForLanguage(roadmap.language);
            final totalTopics = progressController.getTotalTopicCount(steps);
            final completedTopics = progressController.getCompletedTopicCount(
              roadmap.language,
              steps,
            );
            final remainingTopics = totalTopics - completedTopics;
            final progressRatio =
                totalTopics > 0 ? completedTopics / totalTopics : 0.0;
            final percentage = (progressRatio * 100).toInt();

            overallTotalTopics += totalTopics;
            overallCompletedTopics += completedTopics;

            roadmapStatsList.add({
              'roadmap': roadmap,
              'total': totalTopics,
              'completed': completedTopics,
              'remaining': remainingTopics,
              'progress': progressRatio,
              'percentage': percentage,
            });
          }

          final overallRemainingTopics =
              overallTotalTopics - overallCompletedTopics;
          final overallRatio = overallTotalTopics > 0
              ? overallCompletedTopics / overallTotalTopics
              : 0.0;
          final overallPercentage = (overallRatio * 100).toInt();
          final currentStreak = progressController.getCurrentStreak();
          final longestStreak = progressController.getLongestStreak();

          // Weekly Learning Activity Insights Data
          final weeklyData = progressController.getWeeklyActivityData();
          final dailyList =
              weeklyData['dailyList'] as List<Map<String, dynamic>>;
          final totalWeeklyCompleted =
              weeklyData['totalWeeklyCompleted'] as int;
          final activeDaysCount = weeklyData['activeDaysCount'] as int;
          final maxDailyCount = weeklyData['maxDailyCount'] as int;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Overall Progress Hero Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColor.secondary, Color(0xFF1E3A8A)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.secondary.withValues(alpha: 0.28),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Overall Learning Progress',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Mastery Insights',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '$overallPercentage%',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: overallRatio,
                          minHeight: 8,
                          backgroundColor: Colors.white.withValues(alpha: 0.2),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColor.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),

                      Row(
                        children: [
                          _buildStatCounter(
                            label: 'Total Topics',
                            value: '$overallTotalTopics',
                            icon: Icons.list_alt_rounded,
                            iconColor: AppColor.lightBlue,
                          ),
                          _buildStatCounter(
                            label: 'Completed',
                            value: '$overallCompletedTopics',
                            icon: Icons.check_circle_rounded,
                            iconColor: AppColor.success,
                          ),
                          _buildStatCounter(
                            label: 'Remaining',
                            value: '$overallRemainingTopics',
                            icon: Icons.pending_actions_rounded,
                            iconColor: AppColor.primary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Streak Statistics Section (Current & Longest Streak)
                Row(
                  children: [
                    // Current Streak Card
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: surfaceColor,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: borderColor,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: textPrimaryColor.withValues(alpha: 0.03),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColor.lightOrange,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.local_fire_department_rounded,
                                color: AppColor.primary,
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '$currentStreak Days',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: textPrimaryColor,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Current Streak',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: textSecondaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    // Longest Streak Card
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: surfaceColor,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: borderColor,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: textPrimaryColor.withValues(alpha: 0.03),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? const Color(0xFF1E293B)
                                    : AppColor.lightBlue,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.emoji_events_rounded,
                                color: isDark
                                    ? const Color(0xFF60A5FA)
                                    : AppColor.secondary,
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '$longestStreak Days',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: textPrimaryColor,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Longest Streak',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: textSecondaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // Trophy Hall / Achievements Shortcut Banner
                InkWell(
                  onTap: () => Get.to(() => const AchievementsScreen()),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF1E293B)
                          : AppColor.lightOrange.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColor.primary.withValues(alpha: 0.35),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Text(
                          '🏆',
                          style: TextStyle(fontSize: 22),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'View Trophy Hall & Badges',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: textPrimaryColor,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Track unlocked badges & milestone rewards',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: textSecondaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: isDark ? Colors.white70 : AppColor.primary,
                          size: 22,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // 2. Weekly Learning Activity Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: borderColor,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: textPrimaryColor.withValues(alpha: 0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section Header & Active Days Badge
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? const Color(0xFF1E293B)
                                        : AppColor.lightBlue,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    Icons.date_range_rounded,
                                    color: isDark
                                        ? const Color(0xFF60A5FA)
                                        : AppColor.secondary,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Weekly Learning Activity',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: textPrimaryColor,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'This Week (Mon - Sun)',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: textSecondaryColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColor.lightOrange,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '$activeDaysCount/7 Active Days',
                              style: const TextStyle(
                                color: AppColor.primary,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Weekly Summary Chips
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF0B1220)
                              : AppColor.background,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.bolt_rounded,
                              size: 16,
                              color: AppColor.primary,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                '$totalWeeklyCompleted topics completed this week',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: textPrimaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Weekly Activity Bar Chart (Mon - Sun)
                      SizedBox(
                        height: 125,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: dailyList.map((dayData) {
                            final dayLabel = dayData['dayLabel'] as String;
                            final count = dayData['count'] as int;
                            final isToday = dayData['isToday'] as bool;
                            final isActive = dayData['isActive'] as bool;

                            double barHeightFactor = 0.0;
                            if (maxDailyCount > 0) {
                              barHeightFactor =
                                  (count / maxDailyCount).clamp(0.12, 1.0);
                            }

                            const barMaxHeight = 60.0;
                            final actualBarHeight = isActive
                                ? (barMaxHeight * barHeightFactor)
                                : 8.0;

                            return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  count > 0 ? '$count' : '',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: isToday
                                        ? AppColor.primary
                                        : textSecondaryColor,
                                  ),
                                ),
                                const SizedBox(height: 4),

                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  width: 26,
                                  height: actualBarHeight,
                                  decoration: BoxDecoration(
                                    color: isActive
                                        ? (isToday
                                            ? AppColor.primary
                                            : (isDark
                                                ? const Color(0xFF60A5FA)
                                                : AppColor.secondary))
                                        : (isDark
                                            ? const Color(0xFF0B1220)
                                            : const Color(0xFFE2EAF2)),
                                    borderRadius: BorderRadius.circular(8),
                                    border: isToday
                                        ? Border.all(
                                            color: AppColor.primary,
                                            width: 1.5,
                                          )
                                        : null,
                                    boxShadow: isToday && isActive
                                        ? [
                                            BoxShadow(
                                              color: AppColor.primary
                                                  .withValues(alpha: 0.35),
                                              blurRadius: 6,
                                              offset: const Offset(0, 2),
                                            ),
                                          ]
                                        : null,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                    vertical: 2,
                                  ),
                                  decoration: isToday
                                      ? BoxDecoration(
                                          color: AppColor.primary
                                              .withValues(alpha: 0.15),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        )
                                      : null,
                                  child: Text(
                                    dayLabel,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: isToday
                                          ? FontWeight.bold
                                          : FontWeight.w500,
                                      color: isToday
                                          ? AppColor.primary
                                          : textSecondaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // 3. Individual Roadmaps Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Roadmap Progress',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textPrimaryColor,
                        letterSpacing: -0.3,
                      ),
                    ),
                    Text(
                      '${RoadmapData.roadmaps.length} Roadmaps',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: textSecondaryColor,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // 4. Individual Roadmap Cards List
                ...roadmapStatsList.map((statItem) {
                  final roadmap = statItem['roadmap'] as RoadmapModel;
                  final total = statItem['total'] as int;
                  final completed = statItem['completed'] as int;
                  final remaining = statItem['remaining'] as int;
                  final progress = statItem['progress'] as double;
                  final percentage = statItem['percentage'] as int;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: InkWell(
                      onTap: () =>
                          Get.to(() => RoadmapDetailScreen(roadmap: roadmap)),
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: surfaceColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: borderColor,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: textPrimaryColor.withValues(alpha: 0.03),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 44,
                                  height: 44,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? const Color(0xFF1E293B)
                                        : AppColor.lightBlue,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Image.asset(
                                    roadmap.imgUrl,
                                    fit: BoxFit.contain,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Icon(
                                      Icons.code_rounded,
                                      color: isDark
                                          ? const Color(0xFF60A5FA)
                                          : AppColor.secondary,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        roadmap.language,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: textPrimaryColor,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        roadmap.category,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: textSecondaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: completed == total && total > 0
                                        ? AppColor.success
                                            .withValues(alpha: 0.15)
                                        : AppColor.lightOrange,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    '$percentage%',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: completed == total && total > 0
                                          ? AppColor.success
                                          : AppColor.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),

                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: LinearProgressIndicator(
                                value: progress,
                                minHeight: 6,
                                backgroundColor: borderColor,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  completed == total && total > 0
                                      ? AppColor.success
                                      : AppColor.primary,
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.check_circle_outline_rounded,
                                      size: 14,
                                      color: AppColor.success,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '$completed/$total completed',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: textPrimaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.pending_actions_rounded,
                                      size: 14,
                                      color: textSecondaryColor,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '$remaining remaining',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: textSecondaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildStatCounter({
    required String label,
    required String value,
    required IconData icon,
    required Color iconColor,
  }) {
    return Expanded(
      child: Column(
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 20,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
