import 'package:dev_path/data/roadmap_data.dart';
import 'package:dev_path/data/roadmap_step_data.dart';
import 'package:dev_path/models/achievement_model.dart';
import 'package:dev_path/models/roadmap_model.dart';
import 'package:dev_path/models/roadmap_step_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProgressController extends GetxController {
  final box = GetStorage();
  RxInt progressUpdateTrigger = 0.obs;

  static const String _weeklyActivityKey = 'weekly_activity_map';
  static const String _unlockedAchievementsKey = 'unlocked_achievements_map';
  static const String _lastActivityDateKey = 'last_activity_date';
  static const String _currentStreakKey = 'current_streak';
  static const String _longestStreakKey = 'longest_streak';

  String _formatDateKey(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  void saveProgress(String key, List<bool> completedTopics) {
    // Read previous completed topics count to measure new completions
    final previousSaved = box.read(key);
    int previousCompletedCount = 0;
    if (previousSaved != null && previousSaved is List) {
      previousCompletedCount =
          previousSaved.where((val) => val == true).length;
    }

    final newCompletedCount =
        completedTopics.where((val) => val == true).length;
    final newlyCompleted = newCompletedCount - previousCompletedCount;

    box.write(key, completedTopics);

    if (newlyCompleted > 0) {
      recordActivity(newlyCompleted);
    } else {
      progressUpdateTrigger.value++;
    }
  }

  void recordActivity(int count) {
    if (count <= 0) return;

    final todayKey = _formatDateKey(DateTime.now());
    final rawMap = box.read(_weeklyActivityKey);

    Map<String, int> activityMap = {};
    if (rawMap != null && rawMap is Map) {
      rawMap.forEach((k, v) {
        if (k is String && v is int) {
          activityMap[k] = v;
        }
      });
    }

    final currentCount = activityMap[todayKey] ?? 0;
    activityMap[todayKey] = currentCount + count;
    box.write(_weeklyActivityKey, activityMap);

    updateLearningStreak();
    checkAchievements(RoadmapData.roadmaps);
    progressUpdateTrigger.value++;
  }

  List<bool> loadProgress(String key, int totalTopics) {
    final saveTopics = box.read(key);

    if (saveTopics == null || saveTopics is! List) {
      return List<bool>.filled(totalTopics, false);
    }
    return List<bool>.generate(
      totalTopics,
      (index) => index < saveTopics.length ? saveTopics[index] == true : false,
    );
  }

  // Get total completed topics across the roadmap
  int getCompletedTopicCount(
    String roadmapTitle,
    List<RoadmapStepModel> steps,
  ) {
    int completedCount = 0;

    for (final step in steps) {
      final completedTopics = loadProgress(
        '${roadmapTitle}_${step.id}',
        step.subtopics.length,
      );

      completedCount += completedTopics
          .where((completed) => completed)
          .length;
    }

    return completedCount;
  }

  // Get total topics across the roadmap
  int getTotalTopicCount(List<RoadmapStepModel> steps) {
    int totalCount = 0;

    for (final step in steps) {
      totalCount += step.subtopics.length;
    }

    return totalCount;
  }

  void saveLastOpenedStep(String roadmapTitle, int stepId) {
    box.write('last_roadmap', roadmapTitle);
    box.write('last_step_id', stepId);
  }

  String? getLastRoadmap() {
    return box.read('last_roadmap');
  }

  int? getLastStepId() {
    return box.read('last_step_id');
  }

  DateTime _dateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  void updateLearningStreak() {
    final today = _dateOnly(DateTime.now());

    final savedDateString = box.read(_lastActivityDateKey);
    final currentStreak = box.read(_currentStreakKey) ?? 0;

    int newStreak;

    if (savedDateString == null) {
      newStreak = 1;
    } else {
      final lastDate = DateTime.parse(savedDateString);
      final difference = today.difference(lastDate).inDays;

      if (difference == 0) {
        return; // Already counted today
      } else if (difference == 1) {
        newStreak = currentStreak + 1;
      } else {
        newStreak = 1;
      }
    }

    final longestStreak = box.read(_longestStreakKey) ?? 0;

    box.write(_lastActivityDateKey, today.toIso8601String());
    box.write(_currentStreakKey, newStreak);

    if (newStreak > longestStreak) {
      box.write(_longestStreakKey, newStreak);
    }
  }

  int getCurrentStreak() {
    final savedDateString = box.read(_lastActivityDateKey);

    if (savedDateString == null) return 0;

    final lastDate = _dateOnly(DateTime.parse(savedDateString));
    final today = _dateOnly(DateTime.now());

    final difference = today.difference(lastDate).inDays;

    if (difference > 1) return 0;

    return box.read(_currentStreakKey) ?? 0;
  }

  int getLongestStreak() {
    return box.read(_longestStreakKey) ?? 0;
  }

  /// Map of unlocked achievement IDs to unlock ISO date strings
  Map<String, String> getUnlockedAchievements() {
    final rawMap = box.read(_unlockedAchievementsKey);
    Map<String, String> resultMap = {};
    if (rawMap != null && rawMap is Map) {
      rawMap.forEach((k, v) {
        if (k is String && v is String) {
          resultMap[k] = v;
        }
      });
    }
    return resultMap;
  }

  /// Automatically check achievement conditions
  void checkAchievements(List<RoadmapModel> roadmaps) {
    final unlockedMap = getUnlockedAchievements();
    bool newlyUnlocked = false;

    int totalCompletedTopics = 0;
    int completedRoadmapsCount = 0;

    for (final roadmap in roadmaps) {
      final steps = RoadmapStepData.getStepsForLanguage(roadmap.language);
      final total = getTotalTopicCount(steps);
      final completed = getCompletedTopicCount(roadmap.language, steps);

      totalCompletedTopics += completed;
      if (total > 0 && completed == total) {
        completedRoadmapsCount++;
      }
    }

    final streak = getCurrentStreak();
    final longestStreak = getLongestStreak();
    final maxStreak = streak > longestStreak ? streak : longestStreak;

    for (final ach in AchievementModel.allAchievements) {
      if (unlockedMap.containsKey(ach.id)) continue;

      bool shouldUnlock = false;

      if (ach.type == 'topic' && totalCompletedTopics >= ach.targetValue) {
        shouldUnlock = true;
      } else if (ach.type == 'streak' && maxStreak >= ach.targetValue) {
        shouldUnlock = true;
      } else if (ach.type == 'roadmap' &&
          completedRoadmapsCount >= ach.targetValue) {
        shouldUnlock = true;
      }

      if (shouldUnlock) {
        final nowIso = DateTime.now().toIso8601String();
        unlockedMap[ach.id] = nowIso;
        newlyUnlocked = true;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.snackbar(
            '🎉 Achievement Unlocked!',
            '${ach.iconEmoji} ${ach.title}: ${ach.description}',
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 3),
          );
        });
      }
    }

    if (newlyUnlocked) {
      box.write(_unlockedAchievementsKey, unlockedMap);
      progressUpdateTrigger.value++;
    }
  }

  /// Returns current week (Monday to Sunday) activity insights
  Map<String, dynamic> getWeeklyActivityData() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // Monday of current week (DateTime.monday is 1)
    final monday = today.subtract(Duration(days: today.weekday - 1));

    final rawMap = box.read(_weeklyActivityKey);
    Map<String, int> activityMap = {};
    if (rawMap != null && rawMap is Map) {
      rawMap.forEach((k, v) {
        if (k is String && v is int) {
          activityMap[k] = v;
        }
      });
    }

    final dayLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final List<Map<String, dynamic>> dailyList = [];

    int totalWeeklyCompleted = 0;
    int activeDaysCount = 0;
    int maxDailyCount = 0;

    final todayKey = _formatDateKey(now);

    for (int i = 0; i < 7; i++) {
      final dayDate = monday.add(Duration(days: i));
      final dateKey = _formatDateKey(dayDate);
      final count = activityMap[dateKey] ?? 0;

      totalWeeklyCompleted += count;
      if (count > 0) {
        activeDaysCount++;
      }
      if (count > maxDailyCount) {
        maxDailyCount = count;
      }

      dailyList.add({
        'dayLabel': dayLabels[i],
        'dateKey': dateKey,
        'count': count,
        'isToday': dateKey == todayKey,
        'isActive': count > 0,
      });
    }

    return {
      'dailyList': dailyList,
      'totalWeeklyCompleted': totalWeeklyCompleted,
      'activeDaysCount': activeDaysCount,
      'maxDailyCount': maxDailyCount,
    };
  }
}
