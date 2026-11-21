import 'package:dev_path/Widgets/app_snackbar.dart';
import 'package:dev_path/app/theme/app_color.dart';
import 'package:dev_path/controller/progress_controller.dart';
import 'package:dev_path/controller/saved_controller.dart';
import 'package:dev_path/data/roadmap_step_data.dart';
import 'package:dev_path/models/roadmap_model.dart';
import 'package:dev_path/screens/roadmap_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoadmapListWidget extends StatelessWidget {
  final RoadmapModel item;

  const RoadmapListWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final savedController = Get.isRegistered<SavedController>()
        ? Get.find<SavedController>()
        : Get.put(SavedController());

    final progressController = Get.isRegistered<ProgressController>()
        ? Get.find<ProgressController>()
        : Get.put(ProgressController());

    final surfaceColor = isDark ? const Color(0xFF172235) : AppColor.surface;
    final textPrimaryColor = isDark ? Colors.white : AppColor.textPrimary;
    final textSecondaryColor = isDark
        ? const Color(0xFF94A3B8)
        : AppColor.textSecondary;
    final borderColor = isDark ? const Color(0xFF334155) : AppColor.border;

    final steps = RoadmapStepData.getStepsForLanguage(item.language);

    return InkWell(
      onTap: () => Get.to(() => RoadmapDetailScreen(roadmap: item)),
      borderRadius: BorderRadius.circular(18),
      child: Container(
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: borderColor, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: textPrimaryColor.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Tech Logo Squircle Container
            Container(
              width: 52,
              height: 52,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF1E293B)
                    : AppColor.lightBlue.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isDark
                      ? const Color(0xFF334155)
                      : const Color(0xFFBFDBFE).withValues(alpha: 0.5),
                ),
              ),
              child: Image.asset(
                item.imgUrl,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.code_rounded,
                  color: isDark ? const Color(0xFF60A5FA) : AppColor.secondary,
                  size: 26,
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Content Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title + Category Pill + Bookmark
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                item.language,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15.5,
                                  fontWeight: FontWeight.bold,
                                  color: textPrimaryColor,
                                  letterSpacing: -0.2,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? const Color(0xFF332014)
                                    : AppColor.lightOrange,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                item.category,
                                style: const TextStyle(
                                  color: AppColor.primary,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Obx(() {
                        final isBookmarked = savedController.isSaved(item);
                        return SizedBox(
                          width: 34,
                          height: 34,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: Icon(
                              isBookmarked
                                  ? Icons.bookmark_rounded
                                  : Icons.bookmark_outline_rounded,
                              color: isBookmarked
                                  ? AppColor.primary
                                  : textSecondaryColor,
                              size: 20,
                            ),
                            onPressed: () {
                              savedController.toggleSaved(item);
                              AppSnackBar.show(
                                title: isBookmarked
                                    ? 'Removed from Saved'
                                    : 'Saved to Library',
                                message: '${item.language} Roadmap',
                                duration: const Duration(seconds: 2),
                              );
                            },
                          ),
                        );
                      }),
                    ],
                  ),

                  const SizedBox(height: 3),

                  // Description
                  Text(
                    item.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: textSecondaryColor,
                      height: 1.3,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // Duration Chip
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF1E293B)
                              : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.schedule_rounded,
                              size: 12,
                              color: textSecondaryColor,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              item.duration,
                              style: TextStyle(
                                fontSize: 10.5,
                                color: textSecondaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Progress Bar if user has started this roadmap
                  Obx(() {
                    progressController.progressUpdateTrigger.value;
                    final total = progressController.getTotalTopicCount(steps);
                    final completed = progressController.getCompletedTopicCount(
                      item.language,
                      steps,
                    );

                    if (completed == 0) return const SizedBox.shrink();

                    final progress = total > 0 ? completed / total : 0.0;
                    final percentage = (progress * 100).toInt();

                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '$completed of $total topics completed',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: textSecondaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '$percentage%',
                                style: const TextStyle(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF10B981),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: progress,
                              minHeight: 4,
                              backgroundColor: isDark
                                  ? const Color(0xFF334155)
                                  : const Color(0xFFE2EAF2),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFF10B981),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            const SizedBox(width: 6),

            // Right Chevron
            Icon(
              Icons.chevron_right_rounded,
              color: textSecondaryColor.withValues(alpha: 0.6),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
