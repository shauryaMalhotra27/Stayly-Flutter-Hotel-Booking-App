import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_icons.dart';
import '../utils/side_menu_metrics.dart';

class SideMenuItem extends StatelessWidget {
  const SideMenuItem({
    super.key,
    required this.metrics,
    required this.iconPath,
    required this.label,
    required this.onTap,
    this.selected = false,
    this.showChevron = true,
    this.badgeText,
  });

  final SideMenuMetrics metrics;
  final String iconPath;
  final String label;
  final VoidCallback onTap;
  final bool selected;
  final bool showChevron;
  final String? badgeText;

  @override
  Widget build(BuildContext context) {
    final m = metrics;
    final labelStyle = selected
        ? m.itemLabelStyle.copyWith(color: AppColors.textPrimaryDark)
        : m.itemLabelStyle;

    return Material(
      color: selected ? AppColors.primary : Colors.transparent,
      borderRadius: BorderRadius.horizontal(
        right: Radius.circular(m.itemBorderRadius),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(m.itemBorderRadius),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: m.itemHorizontalPadding,
            vertical: m.itemVerticalPadding,
          ),
          child: Row(
            children: [
              _ItemIcon(metrics: m, iconPath: iconPath, selected: selected),
              SizedBox(width: 16 * m.scale),
              Expanded(
                child: Text(
                  label,
                  style: labelStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (badgeText != null) ...[
                SizedBox(width: 8 * m.scale),
                _Badge(metrics: m, text: badgeText!),
              ],
              if (showChevron) ...[
                SizedBox(width: 8 * m.scale),
                SvgPicture.asset(
                  AppIcons.rightArrow,
                  width: m.chevronSize,
                  height: m.chevronSize,
                  colorFilter: ColorFilter.mode(
                    selected
                        ? AppColors.textPrimaryDark
                        : AppColors.textSecondary,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ItemIcon extends StatelessWidget {
  const _ItemIcon({
    required this.metrics,
    required this.iconPath,
    required this.selected,
  });

  final SideMenuMetrics metrics;
  final String iconPath;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final m = metrics;
    // Unselected: soft white disc; selected: solid white + primary icon.
    final discColor = selected
        ? AppColors.textPrimaryDark
        : AppColors.sideMenuIconDisc;
    final iconColor = selected ? AppColors.primary : AppColors.greyText;

    return Container(
      width: m.iconCircleSize,
      height: m.iconCircleSize,
      decoration: BoxDecoration(shape: BoxShape.circle, color: discColor),
      alignment: Alignment.center,
      child: Transform.scale(
        // Compensate padded SVG viewBox.
        scale: 1.45,
        child: SvgPicture.asset(
          iconPath,
          width: m.iconSize,
          height: m.iconSize,
          colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.metrics, required this.text});

  final SideMenuMetrics metrics;
  final String text;

  @override
  Widget build(BuildContext context) {
    final m = metrics;
    return Container(
      height: m.badgeHeight,
      constraints: BoxConstraints(minWidth: m.badgeMinWidth),
      padding: EdgeInsets.symmetric(horizontal: m.badgeHorizontalPadding),
      decoration: BoxDecoration(
        color: AppColors.accentOrange,
        borderRadius: BorderRadius.circular(m.badgeHeight),
      ),
      alignment: Alignment.center,
      child: Text(text, style: m.badgeStyle, textAlign: TextAlign.center),
    );
  }
}
