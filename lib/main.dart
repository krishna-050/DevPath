import 'package:dev_path/screens/explore_screen.dart';
import 'package:dev_path/screens/home_screen.dart';
import 'package:dev_path/screens/main_screen.dart';
import 'package:dev_path/screens/roadmap_detail_screen.dart';
import 'package:dev_path/screens/splash_screen.dart';
import 'package:dev_path/app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'DevPath',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: ()=>SplashScreen()),
        GetPage(name: '/home', page: ()=>HomeScreen(onExploreTap: (){})),
        GetPage(name: '/explore', page: ()=>ExploreScreen()),
        GetPage(name: '/mainScreen', page: ()=>MainScreen()),
        GetPage(name: '/detailScreen', page: ()=>RoadmapDetailScreen())
      ],
    );
  }
}
