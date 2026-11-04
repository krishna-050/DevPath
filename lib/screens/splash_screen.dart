import 'package:dev_path/app/theme/app_color.dart';
import 'package:dev_path/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      backgroundColor: AppColor.background,
      body: Stack(
        children: [
          // Background Top Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/splash2.png',
              width: screenWidth,
              fit: BoxFit.cover,
            ),
          ),

          // Main Content
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.08,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                SizedBox(height: screenHeight * 0.05),

                                // App Icon Container
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColor.surface,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColor.textPrimary
                                            .withValues(alpha: 0.08),
                                        blurRadius: 20,
                                        offset: const Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  child: Image.asset(
                                    'assets/images/app_icon.png',
                                    height: (screenHeight * 0.12)
                                        .clamp(80.0, 120.0),
                                    width: (screenHeight * 0.12)
                                        .clamp(80.0, 120.0),
                                  ),
                                ),
                                const SizedBox(height: 20),

                                // App Title
                                Text(
                                  'DevPath',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: (screenWidth * 0.1)
                                        .clamp(32.0, 48.0),
                                    color: AppColor.textPrimary,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                                const SizedBox(height: 12),

                                // Subtitle & Taglines
                                Text(
                                  'Learn Skills, Build Projects',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: (screenWidth * 0.042)
                                        .clamp(14.0, 18.0),
                                    color: AppColor.secondary,
                                    fontWeight: FontWeight.w600,
                                    height: 1.3,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Grow your Career',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: (screenWidth * 0.04)
                                        .clamp(13.0, 16.0),
                                    color: AppColor.textSecondary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),

                            // Bottom Section (Get Started Button)
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: screenHeight * 0.04,
                                top: 20,
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.primary,
                                    foregroundColor: Colors.white,
                                    elevation: 4,
                                    shadowColor:
                                        AppColor.primary.withValues(alpha: 0.4),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.to(() => const HomeScreen());
                                  },
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Get Started',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Icon(
                                        Icons.arrow_forward_rounded,
                                        size: 22,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


