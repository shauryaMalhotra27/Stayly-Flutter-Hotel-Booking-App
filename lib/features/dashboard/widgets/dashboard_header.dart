import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../l10n/app_strings.dart';
import '../utils/dashboard_metrics.dart';

/// Greeting + circular menu button (Figma dashboard header).
class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key, required this.metrics, this.onMenuTap});

  final DashboardMetrics metrics;
  final VoidCallback? onMenuTap;

  @override
  Widget build(BuildContext context) {
    final m = metrics;
    final greeting = AppStrings.current.greetingForNow();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: m.horizontalPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text(greeting, style: m.greetingStyle)),
          SizedBox(width: 12 * m.scale),
          _MenuButton(size: m.menuSize, onTap: onMenuTap),
        ],
      ),
    );
  }
}

/// Frosted circle — white-transparent fill + off-white stroke.
class _MenuButton extends StatelessWidget {
  const _MenuButton({required this.size, this.onTap});

  final double size;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // Stroke outside ClipOval so the off-white border stays visible.
        border: Border.all(color: AppColors.menuButtonBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0F434343),
            blurRadius: 16.7,
            offset: Offset(0, 3.7 * (size / 69)),
          ),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: ClipOval(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: ColoredBox(
                color: AppColors.menuButton,
                child: Center(
                  child: SizedBox(
                    width: size * 0.32,
                    height: size * 0.2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(height: 2, color: AppColors.textPrimaryDark),
                        Container(height: 2, color: AppColors.textPrimaryDark),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
