// Forked from google_nav_bar 5.0.7 (MIT License, Copyright (c) 2019 Soo Xiao Tong)
// https://pub.dev/packages/google_nav_bar
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show HapticFeedback;

import 'nav_button.dart';

class NavTab extends StatelessWidget {
  const NavTab({
    super.key,
    this.active,
    this.haptic = true,
    this.backgroundColor,
    this.inactiveBackgroundColor,
    required this.icon,
    this.iconColor,
    this.rippleColor,
    this.hoverColor,
    this.iconActiveColor,
    this.textColor,
    this.text = '',
    this.padding,
    this.margin,
    this.duration,
    this.gap,
    this.curve,
    this.textStyle,
    this.iconSize,
    this.onPressed,
    this.borderRadius,
    this.labelMaxWidth,
    this.fixedLabelWidth,
    this.height,
    this.inactiveWidth,
    this.activeWidth,
  });

  final bool? active;
  final bool haptic;
  final double? gap;
  final Color? iconColor;
  final Color? rippleColor;
  final Color? hoverColor;
  final Color? iconActiveColor;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final TextStyle? textStyle;
  final double? iconSize;
  final VoidCallback? onPressed;
  final String text;
  final IconData icon;
  final Color? backgroundColor;
  final Color? inactiveBackgroundColor;
  final Duration? duration;
  final Curve? curve;
  final BorderRadius? borderRadius;

  /// Caps the active tab's label width so it truncates with an ellipsis
  /// instead of forcing the whole bar to overflow when the label is long
  /// or the bar is narrow.
  final double? labelMaxWidth;

  /// Fixed width for the active label slot so every pill is the same width
  /// regardless of label length. Takes precedence over labelMaxWidth.
  final double? fixedLabelWidth;

  /// Explicit pill/circle height. See NavButton.height.
  final double? height;

  /// Explicit width for the inactive (circle) state. See
  /// NavButton.inactiveWidth.
  final double? inactiveWidth;

  /// Explicit width for the active (pill) state. See NavButton.activeWidth.
  final double? activeWidth;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: text,
      child: NavButton(
        borderRadius: borderRadius,
        duration: duration,
        iconSize: iconSize,
        active: active,
        onPressed: () {
          if (haptic) HapticFeedback.selectionClick();
          onPressed?.call();
        },
        padding: padding,
        margin: margin,
        gap: gap,
        color: backgroundColor,
        inactiveColor: inactiveBackgroundColor,
        rippleColor: rippleColor,
        hoverColor: hoverColor,
        curve: curve,
        iconActiveColor: iconActiveColor,
        iconColor: iconColor,
        icon: icon,
        labelMaxWidth: labelMaxWidth,
        fixedLabelWidth: fixedLabelWidth,
        height: height,
        inactiveWidth: inactiveWidth,
        activeWidth: activeWidth,
        text: Text(
          text,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style:
              textStyle ??
              TextStyle(fontWeight: FontWeight.w600, color: textColor),
        ),
      ),
    );
  }
}
