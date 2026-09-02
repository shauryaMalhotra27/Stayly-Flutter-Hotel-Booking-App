import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app/theme/app_colors.dart';

enum CircleIconButtonStyle { filled, frosted }

/// Circular tappable control — filled primary disc or frosted glass menu style.
class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.size,
    this.onTap,
    this.iconPath,
    this.child,
    this.style = CircleIconButtonStyle.filled,
    this.iconScale = 0.45,
    this.svgScale = 1.0,
  }) : assert(iconPath != null || child != null);

  final double size;
  final VoidCallback? onTap;
  final String? iconPath;
  final Widget? child;
  final CircleIconButtonStyle style;
  final double iconScale;
  final double svgScale;

  @override
  Widget build(BuildContext context) {
    if (style == CircleIconButtonStyle.frosted) {
      return _FrostedCircle(
        size: size,
        onTap: onTap,
        child: child!,
      );
    }

    final icon = child ??
        Transform.scale(
          scale: svgScale,
          child: SvgPicture.asset(
            iconPath!,
            width: size * iconScale,
            height: size * iconScale,
            colorFilter: const ColorFilter.mode(
              AppColors.textPrimaryDark,
              BlendMode.srcIn,
            ),
          ),
        );

    return Material(
      color: AppColors.primary,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: size,
          height: size,
          child: Center(child: icon),
        ),
      ),
    );
  }
}

class _FrostedCircle extends StatelessWidget {
  const _FrostedCircle({
    required this.size,
    required this.child,
    this.onTap,
  });

  final double size;
  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.menuButtonBorder, width: 0.5),
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
                child: Center(child: child),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
