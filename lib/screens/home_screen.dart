import 'package:dev_path/app/theme/app_color.dart';
import 'package:dev_path/controller/home_controller.dart';
import 'package:dev_path/screens/roadmap_detail_screen.dart';
import 'package:dev_path/widgets/roadmap_progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onExploreTap;
  const HomeScreen({super.key, required this.onExploreTap});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;
    final controller = Get.isRegistered<HomeController>()
        ? Get.find<HomeController>()
        : Get.put(HomeController());

    final isTablet = screenWidth > 600;
    final horizontalPadding = screenWidth * 0.045;
    final gridCrossAxisCount = isTablet ? 3 : 2;

    final categoryItems = [
      {'name': 'All', 'icon': Icons.apps_rounded},
      {'name': 'Frontend', 'icon': Icons.code_rounded},
      {'name': 'Backend', 'icon': Icons.dns_rounded},
      {'name': 'Mobile', 'icon': Icons.phone_android_rounded},
      {'name': 'DevOps', 'icon': Icons.cloud_queue_rounded},
    ];

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.background,
        titleSpacing: 0,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            'assets/images/app_icon.png',
            fit: BoxFit.contain,
          ),
        ),
        title: const Text(
          'DevPath',
          style: TextStyle(
            color: AppColor.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: -0.5,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Stack(
              children: [
                const Icon(
                  Icons.notifications_none_rounded,
                  color: AppColor.textPrimary,
                  size: 26,
                ),
                Positioned(
                  right: 2,
                  top: 2,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColor.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 4.0),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: AppColor.lightBlue,
              child: const Icon(
                Icons.person_outline_rounded,
                color: AppColor.secondary,
                size: 22,
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
                SizedBox(height: screenHeight * 0.015),

                // Search Bar
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: TextField(
                    onChanged: controller.searchRoadmap,
                    style: const TextStyle(
                      color: AppColor.textPrimary,
                      fontSize: 15,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColor.surface,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 16,
                      ),
                      hintText: 'Search for a roadmap...',
                      hintStyle: const TextStyle(
                        color: AppColor.textSecondary,
                        fontSize: 14,
                      ),
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: AppColor.secondary,
                        size: 22,
                      ),
                      suffixIcon: Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColor.lightBlue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.tune_rounded,
                          color: AppColor.secondary,
                          size: 18,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: AppColor.border),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: AppColor.secondary,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.025),

                // Hero Featured Banner
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(screenWidth * 0.05),
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
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              '🚀 Start Learning Today',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: screenWidth * 0.58,
                            child: const Text(
                              'Your Dream Career Starts Here',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                height: 1.25,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          SizedBox(
                            width: screenWidth * 0.55,
                            child: const Text(
                              'Explore curated roadmaps & learn step-by-step.',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                                height: 1.3,
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
                              elevation: 2,
                              shadowColor:
                                  AppColor.primary.withValues(alpha: 0.4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              onExploreTap();
                            },
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Explore Roadmaps',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 6),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        right: -10,
                        bottom: -10,
                        top: 0,
                        child: Icon(
                          Icons.alt_route_rounded,
                          size: screenWidth * 0.28,
                          color: Colors.white.withValues(alpha: 0.15),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.025),

                // Popular Roadmaps Section Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Popular Roadmaps',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                        color: AppColor.textPrimary,
                        letterSpacing: -0.3,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        onExploreTap();
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6, vertical: 4),
                        child: Row(
                          children: [
                            Text(
                              'View All',
                              style: TextStyle(
                                color: AppColor.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 12,
                              color: AppColor.primary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: screenHeight * 0.015),

                // Roadmaps Grid
                Obx(() {
                    final filteredList = controller.filteredRoadmaps;
                    return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: filteredList.length > 6
                        ? 6
                        : filteredList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gridCrossAxisCount,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: isTablet ? 1.0 : 0.82,
                    ),
                    itemBuilder: (context, index) {
                      final item = filteredList[index];
                      return InkWell(
                        onTap: () async {
                          await Get.to(
                              () => RoadmapDetailScreen(roadmap: item));
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.surface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppColor.border.withValues(alpha: 0.7),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.textPrimary
                                    .withValues(alpha: 0.04),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                   width: 44,
                                    height: 44,
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: AppColor.lightBlue,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Image.asset(
                                      item.imgUrl,
                                      fit: BoxFit.contain,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(
                                        Icons.code_rounded,
                                        color: AppColor.secondary,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 7,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColor.lightOrange,
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
                              Text(
                                item.language,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: AppColor.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Expanded(
                                child: Text(
                                  item.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: AppColor.textSecondary,
                                    fontSize: 12,
                                    height: 1.3,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              // Row(
                              //   children: [
                              //     const Icon(
                              //       Icons.watch_later_outlined,
                              //       color: AppColor.primary,
                              //       size: 15,
                              //     ),
                              //     const SizedBox(width: 4),
                              //     Text(
                              //       item.duration,
                              //       style: const TextStyle(
                              //         color: AppColor.textPrimary,
                              //         fontSize: 11,
                              //         fontWeight: FontWeight.w600,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              const SizedBox(height: 4),

                              RoadmapProgressWidget(
                                roadmap: item,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                ),

                SizedBox(height: screenHeight * 0.03),

                // Categories Header & Filter List
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                    color: AppColor.textPrimary,
                    letterSpacing: -0.3,
                  ),
                ),

                SizedBox(height: screenHeight * 0.014),

                // Category Chips with Icon + Name
                SizedBox(
                  height: 44,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: categoryItems.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final item = categoryItems[index];
                      final isSelected = index == 0;
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColor.primary
                              : AppColor.surface,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: isSelected
                                ? AppColor.primary
                                : AppColor.border,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color:
                                        AppColor.primary.withValues(alpha: 0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ]
                              : null,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              item['icon'] as IconData,
                              size: 18,
                              color: isSelected
                                  ? Colors.white
                                  : AppColor.secondary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              item['name'] as String,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : AppColor.textPrimary,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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
}

