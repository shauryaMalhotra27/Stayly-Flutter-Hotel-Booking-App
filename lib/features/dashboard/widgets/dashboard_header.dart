import 'package:flutter/material.dart';

import '../../../core/widgets/circle_icon_button.dart';
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Text(greeting, style: m.greetingStyle)),
          SizedBox(width: 12 * m.scale),
          CircleIconButton(
            size: m.menuSize,
            onTap: onMenuTap,
            style: CircleIconButtonStyle.frosted,
            child: SizedBox(
              width: m.menuSize * 0.32,
              height: m.menuSize * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(height: 1.5, color: const Color(0xFFFFFFFF)),
                  Container(height: 1.5, color: const Color(0xFFFFFFFF)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
