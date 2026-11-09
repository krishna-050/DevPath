import 'package:dev_path/app/theme/app_color.dart';
import 'package:dev_path/controller/home_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;
    final controller = Get.put(HomeController());
    final searchController = TextEditingController();

    // Responsive calculations
    final isTablet = screenWidth > 600;
    final horizontalPadding = screenWidth * 0.045;
    final gridCrossAxisCount = isTablet ? 3 : 2;

    List<Icon> categories =[
      Icon(Icons.layers_sharp),
      Icon(Icons.language),
      Icon(Icons.mobile_screen_share_sharp),
      Icon(Icons.cloud_queue_rounded),
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
                    controller: searchController,
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
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.secondary.withValues(alpha: 0.3),
                        blurRadius: 15,
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
                            width: screenWidth * 0.55,
                            child: const Text(
                              'Master Skills with Step-by-Step Roadmaps',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                height: 1.25,
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
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Explore Now',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        top: 0,
                        child: Icon(
                          Icons.alt_route_rounded,
                          size: screenWidth * 0.24,
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
                      onTap: () {},
                      borderRadius: BorderRadius.circular(8),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6, vertical: 4),
                        child: Text(
                          'View All',
                          style: TextStyle(
                            color: AppColor.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: screenHeight * 0.015),

                // Roadmaps Grid
                Obx(
                  () => GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.roadmapList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gridCrossAxisCount,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: isTablet ? 0.85 : 0.72,
                    ),
                    itemBuilder: (context, index) {
                      return Card(
                        borderOnForeground: true,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        child: Column(
                          spacing: 7,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(controller.roadmapList[index].imgUrl,height: 60,width: 60,),
                            Text(controller.roadmapList[index].language, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: AppColor.textPrimary)),
                            Text(controller.roadmapList[index].description,style: TextStyle(color: AppColor.secondary,fontSize: 13),),
                            Row(
                              spacing: 10,
                              children: [
                                Icon(Icons.watch_later_outlined,color: AppColor.primary,size:20,),
                                Text(controller.roadmapList[index].duration,style: TextStyle(color: Colors.black),),
                              ],
                            ),
                          ],
                        ),
                      ),
                      );
                    },
                  ),
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

                SizedBox(height: screenHeight * 0.012),

                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final isSelected = index == 0;
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
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
                          ),
                        ),
                        child: Icon(categories.elementAt(index).icon,)
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

