import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:processed/bindings/app_bindings.dart';
import 'package:processed/features/authentication/views/splash_screen.dart';
import 'package:processed/utils/theme/theme.dart';

void main() async {
  await GetStorage.init();

  final box = GetStorage();
  // Add listener for changes
  box.listenKey('full_name', (value) {
    // Handle user name changes here
    print('full_name changed: $value');
  });

  box.listenKey('user_email', (value) {
    // Handle email changes here
    print('user_email changed: $value');
  });

  box.listenKey('isLoggedIn', (value) {
    // Handle login status changes here
    print('isLoggedIn changed: $value');
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, a) {
        // Use GetMaterial App instead of Material App when using GetX
        return GetMaterialApp(
          themeMode: ThemeMode.system,
          theme: TAppTheme.lightTheme,
          darkTheme: TAppTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          initialBinding: AppBinding(),
          home: const SplashScreen(),
          // initialBinding: AppBinding(),
        );
      },
    );
  }
}

// remove inspection type 