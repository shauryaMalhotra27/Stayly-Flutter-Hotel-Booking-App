import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_icons.dart';
import '../../../core/widgets/surface_card.dart';
import '../../../l10n/app_strings.dart';
import '../utils/account_metrics.dart';

class AccountMenuItem extends StatelessWidget {
  const AccountMenuItem({
    super.key,
    required this.metrics,
    required this.iconPath,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.showComingSoonBadge = false,
  });

  final AccountMetrics metrics;
  final String iconPath;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final bool showComingSoonBadge;

  @override
  Widget build(BuildContext context) {
    final m = metrics;
    final borderRadius = BorderRadius.circular(m.rowRadius);

    return SizedBox(
      height: m.rowHeight,
      child: SurfaceCard(
        borderRadius: borderRadius,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius,
          child: Padding(
            padding: EdgeInsets.only(
              left: m.rowHorizontalPadding,
              right: m.rowTrailingPadding,
            ),
            child: Row(
              children: [
                _IconCircle(metrics: m, iconPath: iconPath),
                SizedBox(width: m.iconTextGap),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: m.titleStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: m.titleSubtitleGap),
                      Text(
                        subtitle,
                        style: m.subtitleStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                if (showComingSoonBadge)
                  _ComingSoonBadge(metrics: m)
                else
                  SvgPicture.asset(
                    AppIcons.rightArrow,
                    width: m.chevronSize,
                    height: m.chevronSize,
                    colorFilter: const ColorFilter.mode(
                      AppColors.textPrimaryDark,
                      BlendMode.srcIn,
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

class _IconCircle extends StatelessWidget {
  const _IconCircle({required this.metrics, required this.iconPath});

  final AccountMetrics metrics;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    final m = metrics;
    return Container(
      width: m.iconCircleSize,
      height: m.iconCircleSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.accountIconBorder),
      ),
      alignment: Alignment.center,
      child: SvgPicture.asset(
        iconPath,
        width: m.iconSize,
        height: m.iconSize,
        colorFilter: const ColorFilter.mode(
          AppColors.textPrimaryDark,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}

class _ComingSoonBadge extends StatelessWidget {
  const _ComingSoonBadge({required this.metrics});

  final AccountMetrics metrics;

  @override
  Widget build(BuildContext context) {
    final m = metrics;
    return Container(
      height: m.badgeHeight,
      padding: EdgeInsets.symmetric(horizontal: m.badgeHorizontalPadding),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.comingSoonBadgeFill,
        borderRadius: BorderRadius.circular(m.badgeHeight),
      ),
      child: Text(
        AppStrings.current.comingSoonBadge,
        style: m.badgeStyle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
