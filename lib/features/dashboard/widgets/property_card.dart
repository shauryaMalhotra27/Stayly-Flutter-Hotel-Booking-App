import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/widgets/shimmer.dart';
import '../../../data/models/hotel.dart';
import '../../../l10n/app_strings.dart';
import '../utils/dashboard_metrics.dart';

/// Shared property card for loaded and skeleton states.
class PropertyCard extends StatelessWidget {
  const PropertyCard({super.key, required this.hotel, this.onTap})
    : isSkeleton = false;

  const PropertyCard.skeleton({super.key})
    : hotel = null,
      onTap = null,
      isSkeleton = true;

  final Hotel? hotel;
  final VoidCallback? onTap;
  final bool isSkeleton;

  @override
  Widget build(BuildContext context) {
    final m = DashboardMetrics.of(context);

    final content = _PropertyCardLayout(
      metrics: m,
      image: isSkeleton
          ? ShimmerBox(
              width: double.infinity,
              height: m.imageHeight,
              radius: m.cardRadius,
            )
          : null,
      imageAsset: hotel?.imageAsset,
      title: isSkeleton
          ? ShimmerBox(width: 160 * m.scale, height: 18 * m.scale, radius: 6)
          : Text(hotel!.locationTitle, style: m.cardTitleStyle),
      meta: isSkeleton
          ? _SkeletonMeta(metrics: m)
          : _LoadedMeta(hotel: hotel!, metrics: m),
    );

    final card = isSkeleton ? Shimmer(child: content) : content;

    if (onTap == null) return card;
    return GestureDetector(onTap: onTap, child: card);
  }
}

/// Common chrome: image + overlapping meta panel (title + stats).
class _PropertyCardLayout extends StatelessWidget {
  const _PropertyCardLayout({
    required this.metrics,
    required this.title,
    required this.meta,
    this.image,
    this.imageAsset,
  });

  final DashboardMetrics metrics;
  final Widget title;
  final Widget meta;
  final Widget? image;
  final String? imageAsset;

  @override
  Widget build(BuildContext context) {
    final m = metrics;
    // Meta panel overlaps the lower part of the image (Figma).
    final overlap = m.metaPanelHeight * 0.45;
    final totalHeight = (m.imageHeight + m.metaPanelHeight - overlap).clamp(
      0.0,
      double.infinity,
    );
    if (totalHeight <= 0 || m.metaPanelHeight <= 0) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: totalHeight,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: m.imageHeight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(m.cardRadius),
              child:
                  image ??
                  Image.asset(
                    imageAsset!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: m.imageHeight,
                  ),
            ),
          ),
          if (imageAsset != null)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: m.imageHeight,
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(m.cardRadius),
                    border: Border.all(color: AppColors.cardStroke),
                  ),
                ),
              ),
            ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: m.metaPanelHeight,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceDark,
                borderRadius: BorderRadius.circular(m.cardRadius),
              ),
              padding: EdgeInsets.fromLTRB(
                28 * m.scale,
                24 * m.scale,
                28 * m.scale,
                20 * m.scale,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title,
                  SizedBox(height: 16 * m.scale),
                  meta,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadedMeta extends StatelessWidget {
  const _LoadedMeta({required this.hotel, required this.metrics});

  final Hotel hotel;
  final DashboardMetrics metrics;

  @override
  Widget build(BuildContext context) {
    final m = metrics;
    // Content-sized columns + spaceBetween so Available/Price aren't cramped.
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _MetaColumn(
          label: AppStrings.current.distance,
          value: hotel.distance,
          labelStyle: m.metaLabelStyle,
          valueStyle: m.metaValueStyle,
          gap: 8 * m.scale,
        ),
        _MetaColumn(
          label: AppStrings.current.available,
          value: hotel.availableDates,
          labelStyle: m.metaLabelStyle,
          valueStyle: m.metaValueStyle,
          gap: 8 * m.scale,
        ),
        _MetaColumn(
          label: AppStrings.current.price,
          value: hotel.price,
          labelStyle: m.metaLabelStyle,
          valueStyle: m.metaValueStyle,
          gap: 8 * m.scale,
        ),
      ],
    );
  }
}

class _SkeletonMeta extends StatelessWidget {
  const _SkeletonMeta({required this.metrics});

  final DashboardMetrics metrics;

  @override
  Widget build(BuildContext context) {
    final m = metrics;
    Widget col() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerBox(width: 54 * m.scale, height: 12 * m.scale, radius: 4),
        SizedBox(height: 8 * m.scale),
        ShimmerBox(width: 64 * m.scale, height: 14 * m.scale, radius: 4),
      ],
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [col(), col(), col()],
    );
  }
}

class _MetaColumn extends StatelessWidget {
  const _MetaColumn({
    required this.label,
    required this.value,
    required this.labelStyle,
    required this.valueStyle,
    required this.gap,
  });

  final String label;
  final String value;
  final TextStyle labelStyle;
  final TextStyle valueStyle;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: labelStyle),
        SizedBox(height: gap),
        Text(value, style: valueStyle),
      ],
    );
  }
}
