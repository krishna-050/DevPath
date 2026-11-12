
import 'package:dev_path/app/theme/app_color.dart';
import 'package:dev_path/controller/progress_controller.dart';
import 'package:dev_path/data/roadmap_step_data.dart';
import 'package:dev_path/models/roadmap_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoadmapProgressWidget extends StatelessWidget {
  final RoadmapModel roadmap;

  const RoadmapProgressWidget({
    super.key,
    required this.roadmap,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProgressController>();

    final steps = RoadmapStepData.getStepsForLanguage(
      roadmap.language,
    );

    final totalTopics = controller.getTotalTopicCount(steps);

    final completedTopics = controller.getCompletedTopicCount(
      roadmap.language,
      steps,
    );

    final progress = totalTopics > 0
        ? completedTopics / totalTopics
        : 0.0;

    final percentage = (progress * 100).toInt();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Progress',
              style: TextStyle(
                fontSize: 11,
                color: AppColor.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '$percentage%',
              style: const TextStyle(
                fontSize: 11,
                color: AppColor.success,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        LinearProgressIndicator(
          value: progress,
          minHeight: 5,
          borderRadius: BorderRadius.circular(10),
          backgroundColor: AppColor.border,
          valueColor: const AlwaysStoppedAnimation<Color>(
            AppColor.success,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '$completedTopics/$totalTopics topics completed',
          style: const TextStyle(
            fontSize: 10,
            color: AppColor.textSecondary,
          ),
        ),
      ],
    );
  }
}
