import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_icons.dart';
import '../../../app/theme/app_images.dart';
import '../../../l10n/app_strings.dart';
import '../utils/side_menu_metrics.dart';

class SideMenuHeader extends StatelessWidget {
  const SideMenuHeader({
    super.key,
    required this.metrics,
    required this.onClose,
  });

  final SideMenuMetrics metrics;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final m = metrics;
    final s = AppStrings.current;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipOval(
          child: Image.asset(
            AppImages.user,
            width: m.avatarSize,
            height: m.avatarSize,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 12 * m.scale),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4 * m.scale),
              Text(
                s.sideMenuProfileName,
                style: m.profileNameStyle.copyWith(
                  decoration: TextDecoration.none,
                  decorationColor: Colors.transparent,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4 * m.scale),
              Text(
                s.sideMenuProfileLocation,
                style: m.profileLocationStyle.copyWith(
                  decoration: TextDecoration.none,
                  decorationColor: Colors.transparent,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        SizedBox(width: 8 * m.scale),
        Material(
          color: Colors.transparent,
          child: InkResponse(
            onTap: onClose,
            radius: m.closeSize,
            child: Padding(
              padding: EdgeInsets.all(4 * m.scale),
              child: SvgPicture.asset(
                AppIcons.cross,
                width: m.closeSize,
                height: m.closeSize,
                colorFilter: const ColorFilter.mode(
                  AppColors.textPrimaryDark,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
