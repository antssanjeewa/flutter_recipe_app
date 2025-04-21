import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../app/app_pages.dart';
import '../utils/constants.dart';

class AppHomeScreen extends StatelessWidget {
  final Widget child;

  const AppHomeScreen({super.key, required this.child});

  static const tabs = [Pages.home, Pages.favorites, Pages.plan, Pages.settings];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    int selectedIndex = tabs.indexWhere(
      (page) => location.startsWith(page.toPath()),
    );
    selectedIndex = selectedIndex < 0 ? 0 : selectedIndex;

    return Scaffold(
      backgroundColor: AppColors.kBackground,
      body: SafeArea(child: child),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        iconSize: 28,
        elevation: 0,
        selectedItemColor: AppColors.kPrimary,
        selectedLabelStyle: const TextStyle(
          color: AppColors.kPrimary,
          fontWeight: FontWeight.w600,
        ),
        unselectedItemColor: AppColors.kDisable,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index != selectedIndex) {
            tabs[index].go(context);
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(selectedIndex == 0 ? Iconsax.home5 : Iconsax.home_1),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(selectedIndex == 1 ? Iconsax.heart5 : Iconsax.heart4),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 2 ? Iconsax.calendar5 : Iconsax.calendar_1,
            ),
            label: "My Plan",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 3 ? Iconsax.setting_21 : Iconsax.setting_2,
            ),
            label: "Setting",
          ),
        ],
      ),
    );
  }
}
