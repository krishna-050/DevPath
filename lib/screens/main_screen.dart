
import 'package:dev_path/app/theme/app_color.dart';
import 'package:dev_path/controller/progress_controller.dart';
import 'package:dev_path/controller/saved_controller.dart';
import 'package:dev_path/data/roadmap_data.dart';
import 'package:dev_path/screens/home_screen.dart';
import 'package:dev_path/screens/explore_screen.dart';
import 'package:dev_path/screens/profile_screen.dart';
import 'package:dev_path/screens/saved_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();

}

class _MainScreenState extends State<MainScreen> {

  @override
  void initState() {
    super.initState();
    final savedController = Get.isRegistered<SavedController>()
        ? Get.find<SavedController>()
        : Get.put(SavedController(), permanent: true);

    // Restore saved roadmaps from local storage
    savedController.loadSavedRoadmaps(RoadmapData.roadmaps);
    Get.put(ProgressController(), permanent: true);
  }
  int _currentIndex = 0;

  late final List<Widget> _screens =  [
    HomeScreen(onExploreTap: _goToExplore),
    ExploreScreen(),
    SavedScreen(),
    ProfileScreen(),
  ];
  void _goToExplore() {
    setState(() {
      _currentIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColor.surface,
          boxShadow: [
            BoxShadow(
              color: AppColor.textPrimary.withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColor.surface,
          selectedItemColor: AppColor.primary,
          unselectedItemColor: AppColor.textSecondary,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            height: 1.5,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              activeIcon: Icon(Icons.explore_rounded),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_outline_rounded),
              activeIcon: Icon(Icons.bookmark_rounded),
              label: 'Saved',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              activeIcon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

