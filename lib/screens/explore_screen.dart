
import 'package:dev_path/app/theme/app_color.dart';
import 'package:dev_path/controller/home_controller.dart';
import 'package:dev_path/models/roadmap_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String selectedCategory = 'All';

  final List<String> categories = const [
    'All',
    'Frontend',
    'Backend',
    'Mobile',
  ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final isTablet = screenWidth > 600;

    final controller = Get.isRegistered<HomeController>()
        ? Get.find<HomeController>()
        : Get.put(HomeController());

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.background,
        centerTitle: false,
        titleSpacing: 16,
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: AppColor.textPrimary,
                ),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        title: const Text(
          'All Roadmaps',
          style: TextStyle(
            color: AppColor.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            letterSpacing: -0.3,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search_rounded,
              color: AppColor.textPrimary,
              size: 24,
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Filter Pills Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 38,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: categories.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          final isSelected = selectedCategory == category;

                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedCategory = category;
                              });
                            },
                            borderRadius: BorderRadius.circular(20),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColor.primary
                                    : AppColor.surface,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColor.primary
                                      : AppColor.border,
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  category,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : AppColor.textPrimary,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Filter Action Button
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: AppColor.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColor.border),
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.tune_rounded,
                        color: AppColor.textPrimary,
                        size: 20,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 4),

            // Roadmaps List Section
            Expanded(
              child: Obx(() {
                final allRoadmaps = controller.roadmapList;
                final filteredList = selectedCategory == 'All'
                    ? allRoadmaps
                    : allRoadmaps.where((item) {
                        return item.category.toLowerCase() ==
                                selectedCategory.toLowerCase() ||
                            (selectedCategory == 'Frontend' &&
                                (item.category == 'Web Development' ||
                                    item.language.contains('React') ||
                                    item.language.contains('Web'))) ||
                            (selectedCategory == 'Mobile' &&
                                (item.category == 'App Development' ||
                                    item.language.contains('Flutter')));
                      }).toList();

                if (filteredList.isEmpty) {
                  return _buildEmptyState(selectedCategory);
                }

                if (isTablet) {
                  return GridView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    itemCount: filteredList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 12,
                      childAspectRatio: 2.2,
                    ),
                    itemBuilder: (context, index) {
                      return _RoadmapListItem(item: filteredList[index]);
                    },
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemCount: filteredList.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return _RoadmapListItem(item: filteredList[index]);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(String category) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: AppColor.lightBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.alt_route_rounded,
                size: 44,
                color: AppColor.secondary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'No $category Roadmaps Yet',
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: AppColor.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Check back soon for updated learning paths.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: AppColor.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoadmapListItem extends StatelessWidget {
  final RoadmapModel item;

  const _RoadmapListItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                Text(
                  item.language,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.textPrimary,
                  ),
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
    );
  }
}


