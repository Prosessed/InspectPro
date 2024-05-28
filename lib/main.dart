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
  // Add listener for change
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

  box.listenKey('apikey', (value) {
    // Handle login status changes here
    print('apikey changed: $value');
  });

  box.listenKey('apisecret', (value) {
    // Handle login status changes here
    print('apisecret changed: $value');
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



// [Opening Screen]

// Narrator: Aiming to enhance  Export Quality Inspection and Reporting for the exporters. 
//Let's get started by logging in or signing up to access your inspection tasks and reports.

// [Login/Signup Screen]

// The person on the inspection site enters their credentials or signs up for a new account.
// Upon successful login/signup, they are directed to the Home Screen.
// [Home Screen]



// Home Screen displays the person's pending inspection tasks, if any, in a list format.
// Each task includes details like the product name, inspection type, and due date.
// The person can select a task to view more details or proceed with the inspection.
// [Create New Inspection Form]


// The person has the option to create a new inspection form by tapping on the "Create New Inspection" button.
// They are prompted to enter the product details and select an inspection template or create a custom template.
// For each question in the template, the person can enable location services to capture 
// the inspection location and upload images or videos as evidence.


// [View Past Inspections]

// The app also provides access to past completed inspections.
// The person can view detailed reports for each inspection, including photos, 
// annotations, and inspection notes.
// They can review past inspections to track trends, 
//identify recurring issues, and monitor quality improvement efforts.

// [Share Inspection Report]

// For completed inspections, the person has the option to share the inspection report with stakeholders.
// They can choose to share via email, messaging apps, or cloud storage platforms directly from the app.
// The sharing feature ensures seamless communication and collaboration between exporters, customers, and other relevant parties.
// [Closing Screen]

// Narrator: Our Export Quality Inspection and Reporting app empowers the person on the inspection

