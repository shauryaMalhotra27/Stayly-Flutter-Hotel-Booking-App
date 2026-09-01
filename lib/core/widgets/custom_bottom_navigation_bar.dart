import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_sizes.dart';
import '../../app/theme/app_typography.dart';
import 'nav_bar/nav_bar.dart';

/// Precomputed, screen-size-aware layout numbers for [CustomBottomNavigationBar].
///
/// Keeping this math out of `build()` means the widget tree only ever reads
/// finished values (`m.iconSize`, `m.pillHeight`, ...) instead of interleaving
/// calculation with rendering.
class _NavBarMetrics {
  const _NavBarMetrics({
    required this.scale,
    required this.iconSize,
    required this.tabPadding,
    required this.gap,
    required this.textStyle,
    required this.barInnerPadding,
    required this.verticalPadding,
    required this.pillHeight,
    required this.barWidth,
    required this.fixedLabelWidth,
    required this.activeWidth,
  });

  final double scale;
  final double iconSize;
  final double tabPadding;
  final double gap;
  final TextStyle textStyle;
  final double barInnerPadding;
  final double verticalPadding;
  final double pillHeight;
  final double barWidth;
  final double fixedLabelWidth;
  final double activeWidth;

  /// Reference phone width AppSizes' medium-mobile tier is tuned for.
  static const double _baselineWidth = 390.0;
  static const double _minScale = 0.85;
  static const double _maxScale = 1.35;

  /// Scale stops growing past this width, so icon/padding sizes don't keep
  /// inflating indefinitely on very wide tablets.
  static const double _scaleCapWidth = 500.0;

  /// Fraction of screen width the bar spans.
  static const double _barWidthFraction = 0.90;

  /// Absolute ceiling on the bar's own width. Deliberately much higher than
  /// _scaleCapWidth: content (icon/padding) stops growing at _scaleCapWidth,
  /// but the bar itself must keep growing with the screen past that point or
  /// every device wider than ~556px gets an identical, too-small label
  /// budget regardless of how much extra screen width is actually available
  /// — which is what caused labels to truncate even on wide tablets.
  static const double _barWidthCap = 900.0;

  factory _NavBarMetrics.of(BuildContext context, List<NavBarItem> items) {
    final screenWidth = MediaQuery.of(context).size.width;
    final effectiveWidth = screenWidth < _scaleCapWidth
        ? screenWidth
        : _scaleCapWidth;
    final scale = (effectiveWidth / _baselineWidth).clamp(_minScale, _maxScale);

    final iconSize = AppSizes.iconMedium(context) * scale;
    final tabPadding = AppSizes.paddingCompact(context) * scale;
    final gap = AppSizes.spacingSmall(context) * scale;
    final textStyle = TextStyle(
      fontFamily: AppTypography.fontFamily,
      fontSize: AppSizes.textSmall(context) * scale,
      color: Colors.white,
      fontWeight: AppTypography.semiBold,
    );
    final barInnerPadding = 8.0 * scale;
    final verticalPadding = AppSizes.paddingSmall(context) * scale;
    final pillHeight = iconSize + 2 * verticalPadding;
    final barWidth = (screenWidth * _barWidthFraction).clamp(0.0, _barWidthCap);

    // Budget the label width against what the bar can fit: 3 inactive
    // circles + the active tab's icon/padding, so it falls back to ellipsis
    // instead of overflowing. Clamped to non-negative since MediaQuery can
    // briefly report width 0 on first build.
    final rowWidth = (barWidth - 2 * barInnerPadding).clamp(
      0.0,
      double.infinity,
    );
    final inactiveTabWidth = pillHeight; // must equal height for a true circle
    // NavButton insets the label by (gap) on the left and a fixed 8px on the
    // right (see labelLeftInset/labelRightInset), beyond fixedLabelWidth
    // itself — both must be counted here or the pill is sized short of what
    // it actually renders.
    const labelRightInset = 8.0;
    final activeIconAndPadding =
        iconSize + 2 * tabPadding + gap + labelRightInset;
    const safetyMargin = 20.0; // buffer against layout rounding
    final reserved = 3 * inactiveTabWidth + activeIconAndPadding + safetyMargin;
    final fixedLabelWidth = _longestLabelWidth(
      items,
      textStyle,
    ).clamp(0.0, (rowWidth - reserved).clamp(0.0, rowWidth));
    final activeWidth =
        iconSize + gap + fixedLabelWidth + labelRightInset + 2 * tabPadding;

    return _NavBarMetrics(
      scale: scale,
      iconSize: iconSize,
      tabPadding: tabPadding,
      gap: gap,
      textStyle: textStyle,
      barInnerPadding: barInnerPadding,
      verticalPadding: verticalPadding,
      pillHeight: pillHeight,
      barWidth: barWidth,
      fixedLabelWidth: fixedLabelWidth,
      activeWidth: activeWidth,
    );
  }

  /// Widest label's natural width, so every active pill can share one fixed width.
  static double _longestLabelWidth(List<NavBarItem> items, TextStyle style) {
    var maxWidth = 0.0;
    for (final item in items) {
      final painter = TextPainter(
        text: TextSpan(text: item.text, style: style),
        textDirection: TextDirection.ltr,
        maxLines: 1,
      )..layout();
      if (painter.width > maxWidth) {
        maxWidth = painter.width;
      }
    }
    // Small buffer so layout rounding doesn't tip ellipsis into truncating.
    return maxWidth + 4.0;
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const List<NavBarItem> _items = [
    NavBarItem(icon: Icons.home_outlined, text: 'Dashboard'),
    NavBarItem(icon: Icons.flight_takeoff_outlined, text: 'Hotels Resort'),
    NavBarItem(icon: Icons.calendar_today_outlined, text: 'Booking Hotel'),
    NavBarItem(icon: Icons.person_outline, text: 'Account'),
  ];

  @override
  Widget build(BuildContext context) {
    final m = _NavBarMetrics.of(context, _items);

    return SafeArea(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: m.barWidth,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            color: AppColors.backgroundDark,
            borderRadius: BorderRadius.circular(100.0),
            // Faint border since the bar's fill matches the page background.
            border: Border.all(color: Colors.white.withAlpha(20), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(50),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: m.barInnerPadding,
              vertical: m.barInnerPadding,
            ),
            child: CustomNavBar(
              tabs: _items,
              selectedIndex: currentIndex,
              onTabChange: onTap,
              gap: m.gap,
              activeColor: Colors.white,
              color: Colors.white70,
              iconSize: m.iconSize,
              textStyle: m.textStyle,
              padding: EdgeInsets.symmetric(
                horizontal: m.tabPadding,
                vertical: m.verticalPadding,
              ),
              duration: const Duration(milliseconds: 1000),
              tabBackgroundColor: AppColors.primary,
              tabInactiveBackgroundColor: Colors.white.withAlpha(15),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              expandRow: true,
              fixedLabelWidth: m.fixedLabelWidth,
              inactiveWidth: m.pillHeight,
              activeWidth: m.activeWidth,
              curve: Curves.elasticInOut,
              height: m.pillHeight,
            ),
          ),
        ),
      ),
    );
  }
}
