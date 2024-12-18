import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:search_app/home_screen/binding/home_screen_binding.dart';
import 'package:search_app/home_screen/home_screen.dart';
import 'package:search_app/splash_screen/splash_screen/binding/splash_screen_binding.dart';
import 'package:search_app/splash_screen/splash_screen/splash_screen.dart';
import 'package:search_app/utils/colors_constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Search App',
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(cursorColor: primaryColor),
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor, 
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
          )
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      initialBinding: SplashScreenBinding(),
      getPages: [
        GetPage(
          name: '/',
          page: () => SplashScreen(),
          binding: SplashScreenBinding(),
        ),
        GetPage(
          name: '/home',
          page: () => HomeScreen(),
          binding: HomeScreenBinding(),
        ),
      ],
    );
  }
}
