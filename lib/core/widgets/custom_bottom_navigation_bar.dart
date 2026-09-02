import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_icons.dart';
import '../../app/theme/app_images.dart';
import '../../app/theme/app_sizes.dart';
import '../../app/theme/app_typography.dart';
import '../../l10n/app_strings.dart';
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
    required this.avatarActiveWidth,
    required this.avatarLabelWidth,
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
  /// Wider pill for the account tab so the avatar can stay large.
  final double avatarActiveWidth;
  /// Account's own (shorter) label slot — not the longest nav label.
  final double avatarLabelWidth;

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

    final iconSize = AppSizes.navIcon(context) * scale;
    final tabPadding = AppSizes.paddingCompact(context) * scale;
    final gap = AppSizes.spacingSmall(context) * scale;
    final textStyle = TextStyle(
      fontFamily: AppTypography.fontFamily,
      fontSize: AppSizes.textSmall(context) * scale,
      color: Colors.white,
      fontWeight: AppTypography.semiBold,
    );
    final barInnerPadding = 4.0 * scale;
    final verticalPadding = AppSizes.paddingSmall(context) * scale;
    final pillHeight = iconSize + 2.8 * verticalPadding;
    final barWidth = (screenWidth * _barWidthFraction).clamp(0.0, _barWidthCap);

    final rowWidth = (barWidth - 2 * barInnerPadding).clamp(
      0.0,
      double.infinity,
    );
    final inactiveTabWidth = pillHeight; // must equal height for a true circle
    const labelRightInset = 8.0;
    const safetyMargin = 20.0;

    // SVG tabs: budget labels against iconSize so long titles stay full.
    final activeIconAndPadding =
        iconSize + 2 * tabPadding + gap + labelRightInset;
    final reserved = 3 * inactiveTabWidth + activeIconAndPadding + safetyMargin;
    final fixedLabelWidth = _longestLabelWidth(
      items,
      textStyle,
    ).clamp(0.0, (rowWidth - reserved).clamp(0.0, rowWidth));
    final activeWidth =
        iconSize + gap + fixedLabelWidth + labelRightInset + 2 * tabPadding + 1.0;

    // Account tab: its own wider pill (large avatar + short "Account" label)
    // so SVG tabs keep full text while the photo can stay big.
    NavBarItem? avatarItem;
    for (final item in items) {
      if (item.fillsInactiveCircle) {
        avatarItem = item;
        break;
      }
    }
    final avatarScale = avatarItem?.activeIconScale ?? 1.0;
    final avatarLeading =
        (iconSize * avatarScale).clamp(iconSize, pillHeight).toDouble();
    final avatarLabelWidth = avatarItem == null
        ? fixedLabelWidth
        : _labelWidth(avatarItem.text, textStyle).clamp(0.0, fixedLabelWidth);
    final maxAvatarPill =
        (rowWidth - 3 * inactiveTabWidth - safetyMargin).clamp(0.0, rowWidth);
    final avatarActiveWidth =
        (avatarLeading +
                gap +
                avatarLabelWidth +
                labelRightInset +
                2 * tabPadding +
                1.0)
            .clamp(0.0, maxAvatarPill);

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
      avatarActiveWidth: avatarActiveWidth,
      avatarLabelWidth: avatarLabelWidth,
    );
  }

  static double _labelWidth(String text, TextStyle style) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout();
    return painter.width + 4.0;
  }

  /// Widest label's natural width, so every active pill can share one fixed width.
  static double _longestLabelWidth(List<NavBarItem> items, TextStyle style) {
    var maxWidth = 0.0;
    for (final item in items) {
      final width = _labelWidth(item.text, style);
      if (width > maxWidth) maxWidth = width;
    }
    return maxWidth;
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

  static List<NavBarItem> _navItems() {
    final s = AppStrings.current;
    return [
      NavBarItem(
        text: s.navDashboard,
        iconBuilder: (color, size) => _NavSvg(AppIcons.home, color, size),
      ),
      NavBarItem(
        text: s.navHotelsResort,
        iconBuilder: (color, size) => _NavSvg(AppIcons.flight, color, size),
      ),
      NavBarItem(
        text: s.navBookingHotel,
        iconBuilder: (color, size) => _NavSvg(AppIcons.calendar, color, size),
      ),
      NavBarItem(
        text: s.navAccount,
        fillsInactiveCircle: true,
        // Raise this to enlarge the photo in the active pill (1.0 = SVG size).
        activeIconScale: 2,
        iconBuilder: (color, size) => SizedBox(
          width: size,
          height: size,
          child: ClipOval(
            child: Image.asset(
              AppImages.user,
              fit: BoxFit.cover,
              width: size,
              height: size,
              gaplessPlayback: true,
            ),
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final items = _navItems();
    final m = _NavBarMetrics.of(context, items);

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
              tabs: items,
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
              duration: const Duration(milliseconds: 700),
              tabBackgroundColor: AppColors.primary,
              tabInactiveBackgroundColor: AppColors.navInactive,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              expandRow: true,
              fixedLabelWidth: m.fixedLabelWidth,
              avatarLabelWidth: m.avatarLabelWidth,
              inactiveWidth: m.pillHeight,
              activeWidth: m.activeWidth,
              avatarActiveWidth: m.avatarActiveWidth,
              curve: Curves.elasticInOut,
              height: m.pillHeight,
            ),
          ),
        ),
      ),
    );
  }
}

/// Tinted SVG for the first three nav tabs (Figma 24×24 baseline).
class _NavSvg extends StatelessWidget {
  const _NavSvg(this.asset, this.color, this.size);

  final String asset;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
