import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_icons.dart';
import '../../../app/theme/app_images.dart';
import '../../../core/widgets/coming_soon_dialog.dart';
import '../../../data/models/hotel.dart';
import '../../../l10n/app_strings.dart';
import '../utils/hotel_detail_metrics.dart';

/// Hero carousel + overlapping info panel for the Hotels tab.
class HotelDetailHeader extends StatefulWidget {
  const HotelDetailHeader({
    super.key,
    required this.hotel,
    required this.metrics,
  });

  final Hotel hotel;
  final HotelDetailMetrics metrics;

  @override
  State<HotelDetailHeader> createState() => _HotelDetailHeaderState();
}

class _HotelDetailHeaderState extends State<HotelDetailHeader> {
  late final PageController _pageController;
  int _currentPage = 0;

  /// Same gallery assets for every property (Figma: 2-frame carousel).
  static const _gallery = [AppImages.propertyOne, AppImages.propertyTwo];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final m = widget.metrics;
    final hotel = widget.hotel;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Layout height stops where the panel begins; hero paints below via
        // Positioned so the panel can overlap without a negative margin.
        SizedBox(
          height: m.heroHeight - m.panelOverlap,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: m.heroHeight,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(m.cardRadius),
                  ),
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _gallery.length,
                    onPageChanged: (index) =>
                        setState(() => _currentPage = index),
                    itemBuilder: (context, index) {
                      return Image.asset(
                        _gallery[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: m.heroHeight,
                child: IgnorePointer(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(m.cardRadius),
                      ),
                      border: Border.all(color: AppColors.cardStroke),
                    ),
                  ),
                ),
              ),
              // Stack height ends at the card top — small bottom inset = above card.
              Positioned(
                bottom: 14 * m.scale,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_gallery.length, (index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.5 * m.scale),
                      child: _PageDash(
                        active: index == _currentPage,
                        scale: m.scale,
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceDark,
            borderRadius: BorderRadius.circular(m.cardRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: 24,
                offset: Offset(0, 8 * m.scale),
              ),
            ],
          ),
          padding: EdgeInsets.fromLTRB(
            m.horizontalPadding,
            24 * m.scale,
            m.horizontalPadding,
            24 * m.scale,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      hotel.hostImageAsset,
                      width: m.hostAvatarSize,
                      height: m.hostAvatarSize,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16 * m.scale),
                  Expanded(
                    child: Text(hotel.hotelName, style: m.hotelNameStyle),
                  ),
                ],
              ),
              SizedBox(height: 28 * m.scale),
              Row(
                children: [
                  SvgPicture.asset(
                    AppIcons.star,
                    width: m.starSize,
                    height: m.starSize,
                    colorFilter: const ColorFilter.mode(
                      AppColors.textPrimaryDark,
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: 6 * m.scale),
                  Text(hotel.rating.toStringAsFixed(1), style: m.ratingStyle),
                  _MetaDivider(scale: m.scale),
                  Flexible(
                    child: Text(
                      AppStrings.current.reviewsLabel(hotel.reviewCount),
                      style: m.detailMetaStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  _MetaDivider(scale: m.scale),
                  Text(hotel.availableDates, style: m.detailMetaStyle),
                ],
              ),
              SizedBox(height: 28 * m.scale),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _BellButton(
                    size: m.bellSize,
                    onTap: () => ComingSoonDialog.show(context),
                  ),
                  SizedBox(width: 12 * m.scale),
                  Expanded(
                    child: Text(hotel.fullAddress, style: m.addressStyle),
                  ),
                ],
              ),
              SizedBox(height: 20 * m.scale),
            ],
          ),
        ),
      ],
    );
  }
}

class _BellButton extends StatelessWidget {
  const _BellButton({required this.size, this.onTap});

  final double size;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
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
          child: Center(
            // SVG viewBox is padded — scale up so the glyph fills the disc.
            child: Transform.scale(
              scale: 1.15,
              child: SvgPicture.asset(
                AppIcons.bell,
                width: size,
                height: size,
                colorFilter: const ColorFilter.mode(
                  AppColors.textPrimaryDark,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Figma segmented dashes (Instagram-stories style), not round dots.
class _PageDash extends StatelessWidget {
  const _PageDash({required this.active, required this.scale});

  final bool active;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: 23 * scale,
      height: 6 * scale,
      decoration: BoxDecoration(
        color: active
            ? AppColors.pageDotActive
            : AppColors.textPrimaryDark.withValues(alpha: 0.49),
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }
}

class _MetaDivider extends StatelessWidget {
  const _MetaDivider({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Container(
        width: 1,
        height: 16 * scale,
        color: AppColors.textPrimaryDark.withValues(alpha: 0.2),
      ),
    );
  }
}
