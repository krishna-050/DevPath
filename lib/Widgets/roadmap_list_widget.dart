import 'package:dev_path/app/theme/app_color.dart';
import 'package:dev_path/controller/saved_controller.dart';
import 'package:dev_path/models/roadmap_model.dart';
import 'package:dev_path/screens/roadmap_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class RoadmapListWidget extends StatelessWidget {
  final RoadmapModel item;

  const RoadmapListWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final savedController = Get.isRegistered<SavedController>()
        ? Get.find<SavedController>()
        : Get.put(SavedController());

    return InkWell(
      onTap: () => Get.to(() => RoadmapDetailScreen(roadmap: item)),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColor.border.withValues(alpha: 0.6),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColor.textPrimary.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo Box
            Container(
              width: 52,
              height: 52,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColor.lightBlue.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(
                item.imgUrl,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.code_rounded,
                  color: AppColor.secondary,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.language,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColor.textPrimary,
                          ),
                        ),
                      ),
                      Obx(() {
                        final isBookmarked = savedController.isSaved(item);
                        return SizedBox(
                          width: 36,
                          height: 36,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: Icon(
                              isBookmarked
                                  ? Icons.bookmark_rounded
                                  : Icons.bookmark_outline_rounded,
                              color: isBookmarked
                                  ? AppColor.primary
                                  : AppColor.textPrimary,
                              size: 22,
                            ),
                            onPressed: () {
                              savedController.toggleSaved(item);
                              Get.snackbar(
                                isBookmarked
                                    ? 'Removed from Favorites'
                                    : 'Saved to Favorites',
                                '${item.language} Roadmap',
                                snackPosition: SnackPosition.BOTTOM,
                                duration: const Duration(seconds: 2),
                                backgroundColor: AppColor.surface,
                                colorText: AppColor.textPrimary,
                                margin: const EdgeInsets.all(16),
                                borderRadius: 12,
                              );
                            },
                          ),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColor.textSecondary,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time_rounded,
                        size: 14,
                        color: AppColor.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        item.duration,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColor.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(
                        Icons.workspace_premium_outlined,
                        size: 14,
                        color: AppColor.primary,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          item.level,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColor.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // Right Chevron Arrow
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


