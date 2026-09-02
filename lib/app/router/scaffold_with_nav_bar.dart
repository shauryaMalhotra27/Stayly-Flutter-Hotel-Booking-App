import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kf_drawer/kf_drawer.dart';

import '../../app/theme/app_colors.dart';
import '../../core/widgets/app_background.dart';
import '../../core/widgets/custom_bottom_navigation_bar.dart';
import '../../features/side_menu/widgets/side_menu_panel.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({super.key, required this.navigationShell});

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      // Return to the branch's initial location when re-tapping the active tab.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: KFDrawer(
        drawerWidth: 0.76,
        minScale: kDrawerContentMinScale,
        borderRadius: 32,
        shadowOffset: 28,
        disableContentTap: true,
        animationDuration: const Duration(milliseconds: 280),
        slideCurve: Curves.easeInOutCubic,
        scaleCurve: Curves.easeInOutBack,
        decoration: const BoxDecoration(color: Colors.transparent),
        menuPadding: EdgeInsets.zero,
        shadowColor: Colors.transparent,
        // Pinned header; scrollable options below.
        centerScrollableItems: true,
        header: const SideMenuPinnedHeader(),
        items: const [SideMenuItemsDrawerItem()],
        content: Scaffold(
          backgroundColor: AppColors.backgroundDark,
          body: navigationShell,
          bottomNavigationBar: CustomBottomNavigationBar(
            currentIndex: navigationShell.currentIndex,
            onTap: _onTap,
          ),
          extendBody: true,
        ),
      ),
    );
  }
}
