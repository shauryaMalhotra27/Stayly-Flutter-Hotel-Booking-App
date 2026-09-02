import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_icons.dart';
import '../../../core/widgets/surface_card.dart';
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
    final radius = BorderRadius.circular(m.searchRadius);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: m.horizontalPadding),
      child: SurfaceCard(
        borderRadius: radius,
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: m.searchHeight,
          child: Padding(
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
                        InkResponse(
                          onTap: onClear,
                          radius: m.iconSize,
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
                InkResponse(
                  onTap: onMicTap,
                  radius: m.iconSize,
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
        ),
      ),
    );
  }
}
