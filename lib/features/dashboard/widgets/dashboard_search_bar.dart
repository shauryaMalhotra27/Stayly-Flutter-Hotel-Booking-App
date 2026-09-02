import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_icons.dart';
import '../../../l10n/app_strings.dart';
import '../utils/dashboard_metrics.dart';

/// Search location bar matching Figma chrome.
class DashboardSearchBar extends StatelessWidget {
  const DashboardSearchBar({
    super.key,
    required this.metrics,
    required this.controller,
    this.hint,
    this.onChanged,
    this.onClear,
    this.onMicTap,
  });

  final DashboardMetrics metrics;
  final String? hint;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final VoidCallback? onMicTap;

  @override
  Widget build(BuildContext context) {
    final m = metrics;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: m.horizontalPadding),
      child: Container(
        height: m.searchHeight,
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(m.searchRadius),
          border: Border.all(color: AppColors.surfaceBorder),
        ),
        padding: EdgeInsets.symmetric(horizontal: 22 * m.scale),
        child: Row(
          children: [
            SvgPicture.asset(
              AppIcons.search,
              width: m.iconSize,
              height: m.iconSize,
              colorFilter: const ColorFilter.mode(
                AppColors.textPrimaryDark,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 16 * m.scale),
            Expanded(
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                style: m.searchHintStyle.copyWith(
                  color: AppColors.textPrimaryDark,
                ),
                cursorColor: AppColors.primary,
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: hint ?? AppStrings.current.searchLocationHint,
                  hintStyle: m.searchHintStyle,
                ),
              ),
            ),
            // Clear X sits left of mic when there is text.
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: controller,
              builder: (context, value, _) {
                if (value.text.isEmpty) {
                  return SizedBox(width: 12 * m.scale);
                }
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 8 * m.scale),
                    GestureDetector(
                      onTap: onClear,
                      // Cross SVG fills its box more than mic — slightly
                      // smaller so visual weight matches the mic icon.
                      child: SizedBox(
                        width: m.iconSize,
                        height: m.iconSize,
                        child: Center(
                          child: SvgPicture.asset(
                            AppIcons.cross,
                            width: m.iconSize * 0.72,
                            height: m.iconSize * 0.72,
                            colorFilter: const ColorFilter.mode(
                              AppColors.textPrimaryDark,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12 * m.scale),
                  ],
                );
              },
            ),
            GestureDetector(
              onTap: onMicTap,
              child: SvgPicture.asset(
                AppIcons.mic,
                width: m.iconSize,
                height: m.iconSize,
                colorFilter: const ColorFilter.mode(
                  AppColors.textPrimaryDark,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
