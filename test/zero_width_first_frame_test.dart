import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_hotel_booking_app/app/theme/app_images.dart';
import 'package:flutter_hotel_booking_app/data/models/hotel.dart';
import 'package:flutter_hotel_booking_app/features/dashboard/utils/dashboard_metrics.dart';
import 'package:flutter_hotel_booking_app/features/dashboard/widgets/property_card.dart';
import 'package:flutter_hotel_booking_app/features/hotel/utils/hotel_detail_metrics.dart';
import 'package:flutter_hotel_booking_app/features/hotel/widgets/hotel_detail_header.dart';

/// Android can report MediaQuery size 0×0 on the first frame before the
/// Flutter surface is attached. Layout math that subtracts padding from that
/// width previously produced a negative SizedBox height and crashed.
void main() {
  const zeroSize = MediaQueryData(size: Size.zero);

  Widget wrap(Widget child) {
    return MediaQuery(
      data: zeroSize,
      child: MaterialApp(home: Scaffold(body: child)),
    );
  }

  testWidgets('PropertyCard.skeleton does not throw when screen width is 0', (
    tester,
  ) async {
    await tester.pumpWidget(wrap(const PropertyCard.skeleton()));
    await tester.pump();

    expect(tester.takeException(), isNull);
  });

  testWidgets('DashboardMetrics stays non-negative when screen width is 0', (
    tester,
  ) async {
    late DashboardMetrics metrics;
    await tester.pumpWidget(
      wrap(
        Builder(
          builder: (context) {
            metrics = DashboardMetrics.of(context);
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(metrics.imageHeight, greaterThanOrEqualTo(0));
    expect(metrics.metaPanelHeight, greaterThanOrEqualTo(0));
  });

  testWidgets('HotelDetailHeader does not throw when screen width is 0', (
    tester,
  ) async {
    late HotelDetailMetrics metrics;
    const hotel = Hotel(
      id: 'test',
      locationTitle: 'Test',
      distance: '1 km',
      availableDates: '1–3 Oct',
      price: '\$100',
      imageAssets: AppImages.toronto,
      hostImageAsset: AppImages.user,
      hotelName: 'Test Hotel',
      rating: 4.5,
      reviewCount: 10,
      fullAddress: 'Test address',
      description: 'Test description',
    );

    await tester.pumpWidget(
      wrap(
        Builder(
          builder: (context) {
            metrics = HotelDetailMetrics.of(context);
            return HotelDetailHeader(hotel: hotel, metrics: metrics);
          },
        ),
      ),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(metrics.heroHeight, greaterThanOrEqualTo(0));
    expect(metrics.panelOverlap, lessThanOrEqualTo(metrics.heroHeight));
  });
}
