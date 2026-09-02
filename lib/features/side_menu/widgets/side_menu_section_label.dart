import 'package:flutter/material.dart';

import '../../../l10n/app_strings.dart';
import '../utils/side_menu_metrics.dart';

class SideMenuSectionLabel extends StatelessWidget {
  const SideMenuSectionLabel({super.key, required this.metrics});

  final SideMenuMetrics metrics;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: metrics.horizontalPadding,
        bottom: metrics.sectionLabelGap,
      ),
      child: Text(
        AppStrings.current.sideMenuSectionTitle,
        style: metrics.sectionLabelStyle.copyWith(
          decoration: TextDecoration.none,
          decorationColor: Colors.transparent,
        ),
      ),
    );
  }
}
