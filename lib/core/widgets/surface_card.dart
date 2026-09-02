import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';

/// Shared surface chrome: dark fill + border + radius (cards, search, rows).
class SurfaceCard extends StatelessWidget {
  const SurfaceCard({
    super.key,
    required this.borderRadius,
    required this.child,
    this.padding,
    this.color = AppColors.surfaceDark,
    this.borderColor = AppColors.surfaceBorder,
    this.clipBehavior = Clip.none,
  });

  final BorderRadius borderRadius;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color color;
  final Color borderColor;
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      elevation: 0,
      clipBehavior: clipBehavior,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
        side: BorderSide(color: borderColor),
      ),
      child: padding == null ? child : Padding(padding: padding!, child: child),
    );
  }
}
