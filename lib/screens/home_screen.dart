import 'package:dev_path/app/theme/app_color.dart';
import 'package:dev_path/controller/home_controller.dart';
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
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DevPath',
          style: TextStyle(
            color: AppColor.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Image.asset('assets/images/app_icon.png'),
        actions: [
          Icon(Icons.notifications_outlined),
          CircleAvatar(child: Icon(Icons.person)),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 20),
                SizedBox(
                  width: 350,
                  height: 50,
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppColor.border),
                      ),
                      filled: true,

                      hintStyle: const TextStyle(color: AppColor.textSecondary),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelStyle: TextStyle(color: AppColor.secondary),
                      labelText: 'Search for a roadmap...',
                      hintText: 'java, python, c++',
                      prefixIcon: Icon(Icons.search, color: AppColor.secondary),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Placeholder(fallbackHeight: 250, fallbackWidth: 200),
                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Popular Roadmaps',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: AppColor.textPrimary,
                      ),
                    ),
                    Text(
                      'View All',
                      style: TextStyle(color: AppColor.primary, fontSize: 16),
                    ),
                  ],
                ),
                Obx(
                  () => GridView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.roadmapList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      return Card(
                      child: Column(
                        children: [
                          Image.asset(controller.roadmapList[index].imgUrl),
                          Text(controller.roadmapList[index].language, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                          Text(controller.roadmapList[index].description),
                          Text(controller.roadmapList[index].duration),
                          Text(controller.roadmapList[index].category),
                        ],
                      ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
