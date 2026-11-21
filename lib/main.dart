import 'package:dev_path/controller/auth_controller.dart';
import 'package:dev_path/screens/explore_screen.dart';
import 'package:dev_path/screens/home_screen.dart';
import 'package:dev_path/screens/main_screen.dart';
import 'package:dev_path/screens/roadmap_detail_screen.dart';
import 'package:dev_path/screens/splash_screen.dart';
import 'package:dev_path/screens/started_screen.dart';
import 'package:dev_path/app/theme/app_theme.dart';
import 'package:dev_path/controller/notification_controller.dart';
import 'package:dev_path/controller/theme_controller.dart';
import 'package:dev_path/services/notification_helper.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'firebase_options.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // App Check: Debug provider for local Android development
  // if (!kIsWeb) {
  //   await FirebaseAppCheck.instance.activate(
  //     providerAndroid: const AndroidDebugProvider(),
  //   );
  // }
  await FirebaseAppCheck.instance.activate(
    providerAndroid: AndroidDebugProvider(),
  );

  await GetStorage.init();

  await NotificationHelper.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ThemeController(), permanent: true);
    Get.put(AuthController(), permanent: true);
    Get.put(NotificationController(), permanent: true);

    return GetMaterialApp(
      title: 'Learning Path',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()),
        GetPage(name: '/started', page: () => StartedScreen()),
        GetPage(
          name: '/home',
          page: () => HomeScreen(onExploreTap: () {}),
        ),
        GetPage(name: '/explore', page: () => ExploreScreen()),
        GetPage(name: '/mainScreen', page: () => MainScreen()),
        GetPage(name: '/detailScreen', page: () => RoadmapDetailScreen()),
      ],
    );
  }
}
