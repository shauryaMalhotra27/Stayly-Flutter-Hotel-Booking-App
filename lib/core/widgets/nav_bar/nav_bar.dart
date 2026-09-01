// Forked from google_nav_bar 5.0.7 (MIT License, Copyright (c) 2019 Soo Xiao Tong)
// https://pub.dev/packages/google_nav_bar
// Adds inactiveBackgroundColor, which the upstream package does not support.
import 'package:flutter/material.dart';

import 'nav_tab.dart';

class NavBarItem {
  const NavBarItem({required this.icon, required this.text});

  final IconData icon;
  final String text;
}

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    this.onTabChange,
    this.gap = 0,
    this.padding = const EdgeInsets.all(25),
    this.activeColor,
    this.color,
    this.rippleColor = Colors.transparent,
    this.hoverColor = Colors.transparent,
    this.tabBackgroundColor = Colors.transparent,
    this.tabInactiveBackgroundColor = Colors.transparent,
    this.tabBorderRadius = 100.0,
    this.iconSize,
    this.textStyle,
    this.curve = Curves.easeInCubic,
    this.duration = const Duration(milliseconds: 500),
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.labelMaxWidth,
    this.fixedLabelWidth,
    this.height,
    this.expandRow = false,
    this.inactiveWidth,
    this.activeWidth,
  });

  final List<NavBarItem> tabs;
  final int selectedIndex;
  final ValueChanged<int>? onTabChange;
  final double gap;
  final double tabBorderRadius;
  final double? iconSize;
  final Color? activeColor;
  final Color tabBackgroundColor;
  final Color tabInactiveBackgroundColor;
  final Color? color;
  final Color rippleColor;
  final Color hoverColor;
  final EdgeInsetsGeometry padding;
  final TextStyle? textStyle;
  final Duration duration;
  final Curve curve;
  final MainAxisAlignment mainAxisAlignment;

  /// Caps active label width to ellipsize instead of overflowing. See NavButton.labelMaxWidth.
  final double? labelMaxWidth;

  /// Fixed active label width so all pills match. See NavButton.fixedLabelWidth.
  final double? fixedLabelWidth;

  /// Explicit pill/circle height for every tab. See NavButton.height.
  final double? height;

  /// Fills parent width via mainAxisAlignment instead of shrink-wrapping with fixed gaps.
  final bool expandRow;

  /// Explicit width for the inactive (circle) state. See NavButton.inactiveWidth.
  final double? inactiveWidth;

  /// Explicit width for the active (pill) tab. See NavButton.activeWidth.
  final double? activeWidth;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    for (var index = 0; index < tabs.length; index++) {
      final tab = tabs[index];
      final isActive = selectedIndex == index;

      if (index > 0 && !expandRow) {
        // Fixed gap keeps tabs clustered; skipped when expandRow handles spacing.
        children.add(SizedBox(width: gap));
      }

      children.add(
        NavTab(
          key: ValueKey(index),
          borderRadius: BorderRadius.circular(tabBorderRadius),
          active: isActive,
          gap: gap,
          iconActiveColor: activeColor,
          iconColor: color,
          iconSize: iconSize,
          textColor: activeColor,
          rippleColor: rippleColor,
          hoverColor: hoverColor,
          padding: padding,
          textStyle: textStyle,
          text: tab.text,
          icon: tab.icon,
          curve: curve,
          backgroundColor: tabBackgroundColor,
          inactiveBackgroundColor: tabInactiveBackgroundColor,
          duration: duration,
          labelMaxWidth: labelMaxWidth,
          fixedLabelWidth: fixedLabelWidth,
          height: height,
          inactiveWidth: inactiveWidth,
          activeWidth: activeWidth,
          onPressed: () => onTabChange?.call(index),
        ),
      );
    }

    return Row(
      mainAxisSize: expandRow ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: mainAxisAlignment,
      children: children,
    );
  }
}
