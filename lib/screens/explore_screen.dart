import 'package:dev_path/Widgets/roadmap_list_widget.dart';
import 'package:dev_path/app/theme/app_color.dart';
import 'package:dev_path/controller/home_controller.dart';
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
  bool isSearching = false;

  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final isTablet = screenWidth > 600;

    final controller = Get.isRegistered<HomeController>()
        ? Get.find<HomeController>()
        : Get.put(HomeController());

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
        centerTitle: false,
        titleSpacing: 16,
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: textPrimaryColor,
                ),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        title: isSearching
            ? TextField(
                controller: searchController,
                autofocus: true,
                onChanged: controller.searchRoadmap,
                style: TextStyle(color: textPrimaryColor),
                decoration: InputDecoration(
                  hintText: 'Search roadmaps...',
                  hintStyle: TextStyle(color: textSecondaryColor),
                  border: InputBorder.none,
                ),
              )
            : Text(
                'All Roadmaps',
                style: TextStyle(
                  color: textPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearching = !isSearching;

                if (!isSearching) {
                  searchController.clear();
                  controller.searchRoadmap('');
                }
              });
            },
            icon: Icon(
              isSearching ? Icons.close_rounded : Icons.search_rounded,
              color: textPrimaryColor,
            ),
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
                                    : surfaceColor,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColor.primary
                                      : borderColor,
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  category,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : textPrimaryColor,
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
                      color: surfaceColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: borderColor),
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.tune_rounded,
                        color: textPrimaryColor,
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
                final allRoadmaps = controller.filteredRoadmaps;
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
                  return _buildEmptyState(selectedCategory, isDark);
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
                      return RoadmapListWidget(item: filteredList[index]);
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
                    return RoadmapListWidget(item: filteredList[index]);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(String category, bool isDark) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E293B) : AppColor.lightBlue,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.alt_route_rounded,
                size: 44,
                color: isDark ? const Color(0xFF60A5FA) : AppColor.secondary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'No $category Roadmaps Yet',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : AppColor.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Check back soon for updated learning paths.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: isDark
                    ? const Color(0xFF94A3B8)
                    : AppColor.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
