import 'dart:ui';

import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

/// Shared screen background: dark fill with two blurred glow circles, per Figma.
class AppBackground extends StatelessWidget {
  const AppBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // Circles sit mostly off-canvas so only a blurred edge bleeds into view.
    final diameter = size.width * 0.8;

    return Container(
      color: AppColors.backgroundDark,
      child: ClipRect(
        child: Stack(
          children: [
            Positioned(
              top: -diameter * 0.4,
              right: -diameter * 0.35,
              child: _GlowCircle(diameter: diameter),
            ),
            Positioned(
              bottom: -diameter * 0.4,
              left: -diameter * 0.35,
              child: _GlowCircle(diameter: diameter),
            ),
            child,
          ],
        ),
      ),
    );
  }
}

class _GlowCircle extends StatelessWidget {
  const _GlowCircle({required this.diameter});

  final double diameter;

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
      child: Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryVariant.withAlpha(90),
        ),
      ),
    );
  }
}
