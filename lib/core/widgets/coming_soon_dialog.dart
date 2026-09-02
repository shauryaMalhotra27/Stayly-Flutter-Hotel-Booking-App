import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_sizes.dart';
import '../../app/theme/app_typography.dart';
import '../utils/screen_scale.dart';
import '../../l10n/app_strings.dart';

/// Reusable “work in progress” dialog for unfinished actions.
class ComingSoonDialog {
  ComingSoonDialog._();

  static Future<void> show(BuildContext context) {
    final s = AppStrings.current;
    return showDialog<void>(
      context: context,
      builder: (context) {
        final scale = ScreenScale.of(context);
        final titleSize = AppSizes.textSectionTitle(context) * scale;
        final bodySize = AppSizes.textDetailMeta(context) * scale;
        final actionSize = AppSizes.textMetaValue(context) * scale;

        return AlertDialog(
          backgroundColor: AppColors.surfaceDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: AppColors.surfaceBorder),
          ),
          title: Text(
            s.comingSoonTitle,
            style: TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontWeight: AppTypography.semiBold,
              fontSize: titleSize,
              color: AppColors.textPrimaryDark,
            ),
          ),
          content: Text(
            s.comingSoonBody,
            style: TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontWeight: AppTypography.regular,
              fontSize: bodySize,
              height: 1.4,
              color: AppColors.textSecondary,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                s.ok,
                style: TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontWeight: AppTypography.semiBold,
                  fontSize: actionSize,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
