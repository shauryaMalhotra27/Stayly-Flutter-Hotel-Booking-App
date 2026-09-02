import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:kf_drawer/kf_drawer.dart';

import '../../app/theme/app_colors.dart';
import '../../core/widgets/app_background.dart';
import '../../core/widgets/custom_bottom_navigation_bar.dart';
import '../../features/side_menu/widgets/side_menu_panel.dart';
import '../../l10n/app_strings.dart';

class ScaffoldWithNavBar extends StatefulWidget {
  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({super.key, required this.navigationShell});

  @override
  State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar> {
  static const _exitConfirmWindow = Duration(seconds: 2);

  DateTime? _lastBackAt;
  OverlayEntry? _exitHintEntry;

  @override
  void dispose() {
    _removeExitHint();
    super.dispose();
  }

  void _onTap(int index) {
    widget.navigationShell.goBranch(
      index,
      // Return to the branch's initial location when re-tapping the active tab.
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  void _removeExitHint() {
    _exitHintEntry?.remove();
    _exitHintEntry = null;
  }

  void _showExitHint(BuildContext context) {
    _removeExitHint();
    final top = MediaQuery.paddingOf(context).top + 12;
    final overlay = Overlay.of(context);

    _exitHintEntry = OverlayEntry(
      builder: (ctx) {
        return Positioned(
          left: 24,
          right: 24,
          top: top,
          child: Material(
            color: AppColors.surfaceDark,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: AppColors.surfaceBorder),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Text(
                AppStrings.current.pressBackAgainToExit,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.textPrimaryDark),
              ),
            ),
          ),
        );
      },
    );
    overlay.insert(_exitHintEntry!);
    Future<void>.delayed(_exitConfirmWindow, () {
      if (_exitHintEntry != null) _removeExitHint();
    });
  }

  void _handleBack(BuildContext drawerContext) {
    final drawer = KFDrawer.of(drawerContext);
    if (drawer != null && drawer.isOpen) {
      drawer.close();
      return;
    }

    final now = DateTime.now();
    final last = _lastBackAt;
    if (last == null || now.difference(last) > _exitConfirmWindow) {
      _lastBackAt = now;
      _showExitHint(drawerContext);
      return;
    }

    _removeExitHint();
    SystemNavigator.pop();
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
        content: Builder(
          builder: (drawerContext) {
            return PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, _) {
                if (didPop) return;
                _handleBack(drawerContext);
              },
              child: Scaffold(
                backgroundColor: AppColors.backgroundDark,
                body: widget.navigationShell,
                bottomNavigationBar: CustomBottomNavigationBar(
                  currentIndex: widget.navigationShell.currentIndex,
                  onTap: _onTap,
                ),
                extendBody: true,
              ),
            );
          },
        ),
      ),
    );
  }
}
