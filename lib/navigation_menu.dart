import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:processed/features/completed/views/completed_inspections.dart';
import 'package:processed/features/dashboard/views/home.dart';
import 'package:processed/features/drafts/views/draft_screen.dart';
import 'package:processed/utils/constants/colors.dart';
import 'package:processed/utils/helpers/helper_functions.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final NavigationController navigationController =
        Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.drafts),
              label: 'Drafts',
            ),
            NavigationDestination(
              icon: Icon(Icons.done),
              label: 'Completed',
            ),
          ],
          backgroundColor: isDark ? Colors.black : Colors.white,
          indicatorColor: isDark
              ? TColors.white.withOpacity(0.1)
              : TColors.black.withOpacity(0.1),
          height: 80,
          elevation: 0,
          selectedIndex: navigationController.selectedIndex.value,
          onDestinationSelected: navigationController.updateIndex,
        ),
      ),
      body: Obx(() => navigationController
          .screens[navigationController.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final selectedIndex = 0.obs;

  void updateIndex(int index) {
    selectedIndex.value = index;
  }

  final screens = [
    const Home(),
    const DraftScreen(),
    const CompletedInspectionsScreen(),
  ];
}
