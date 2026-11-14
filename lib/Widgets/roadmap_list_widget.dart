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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final savedController = Get.isRegistered<SavedController>()
        ? Get.find<SavedController>()
        : Get.put(SavedController());

    final surfaceColor = isDark ? const Color(0xFF172235) : AppColor.surface;
    final textPrimaryColor = isDark ? Colors.white : AppColor.textPrimary;
    final textSecondaryColor =
        isDark ? const Color(0xFF94A3B8) : AppColor.textSecondary;
    final borderColor = isDark ? const Color(0xFF334155) : AppColor.border;

    return InkWell(
      onTap: () => Get.to(() => RoadmapDetailScreen(roadmap: item)),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: textPrimaryColor.withValues(alpha: 0.03),
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
                color: isDark
                    ? const Color(0xFF1E293B)
                    : AppColor.lightBlue.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(12),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.language,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textPrimaryColor,
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
                                  : textPrimaryColor,
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
                                backgroundColor: surfaceColor,
                                colorText: textPrimaryColor,
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
                    style: TextStyle(
                      fontSize: 12,
                      color: textSecondaryColor,
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
                        style: TextStyle(
                          fontSize: 11,
                          color: textSecondaryColor,
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
                          style: TextStyle(
                            fontSize: 11,
                            color: textSecondaryColor,
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
            Icon(
              Icons.chevron_right_rounded,
              color: textSecondaryColor,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
