import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_icons.dart';
import '../../../core/widgets/circle_icon_button.dart';
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
  int _currentPage = 0;

  List<String> get _gallery => widget.hotel.imageAssets;

  @override
  void didUpdateWidget(covariant HotelDetailHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.hotel.id != widget.hotel.id) {
      _currentPage = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final m = widget.metrics;
    final hotel = widget.hotel;
    final gallery = _gallery;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Layout height stops where the panel begins; hero paints below via
        // Positioned so the panel can overlap without a negative margin.
        SizedBox(
          height: (m.heroHeight - m.panelOverlap).clamp(0.0, double.infinity),
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
                  child: GestureDetector(
                    onHorizontalDragEnd: (details) {
                      final v = details.primaryVelocity ?? 0;
                      if (v < -200 && _currentPage < gallery.length - 1) {
                        setState(() => _currentPage++);
                      } else if (v > 200 && _currentPage > 0) {
                        setState(() => _currentPage--);
                      }
                    },
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 420),
                      switchInCurve: Curves.easeInOut,
                      switchOutCurve: Curves.easeInOut,
                      // Stack old + new so both fade together (crossfade/dissolve).
                      layoutBuilder: (currentChild, previousChildren) {
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            ...previousChildren,
                            ?currentChild,
                          ],
                        );
                      },
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                      child: Image.asset(
                        gallery[_currentPage],
                        key: ValueKey(
                          '${hotel.id}_${gallery[_currentPage]}',
                        ),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
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
                  children: List.generate(gallery.length, (index) {
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleIconButton(
                    size: m.bellSize,
                    iconPath: AppIcons.bell,
                    iconScale: 1.0,
                    svgScale: 1.15,
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
