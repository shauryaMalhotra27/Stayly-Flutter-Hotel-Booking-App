import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_hotel_booking_app/core/utils/responsive_utils.dart';

void main() {
  group('ResponsiveUtils', () {
    Widget buildTestWidget(double width, void Function(BuildContext) onBuild) {
      return MaterialApp(
        home: Builder(
          builder: (context) {
            return MediaQuery(
              data: MediaQueryData(size: Size(width, 800)),
              child: Builder(
                builder: (innerContext) {
                  onBuild(innerContext);
                  return const SizedBox();
                },
              ),
            );
          },
        ),
      );
    }

    testWidgets('identifies small mobile correctly', (tester) async {
      DeviceCategory? category;
      await tester.pumpWidget(buildTestWidget(359, (ctx) {
        category = ResponsiveUtils.getDeviceCategory(ctx);
      }));
      expect(category, equals(DeviceCategory.smallMobile));
    });

    testWidgets('identifies medium mobile correctly', (tester) async {
      DeviceCategory? category;
      await tester.pumpWidget(buildTestWidget(360, (ctx) {
        category = ResponsiveUtils.getDeviceCategory(ctx);
      }));
      expect(category, equals(DeviceCategory.mediumMobile));

      await tester.pumpWidget(buildTestWidget(479, (ctx) {
        category = ResponsiveUtils.getDeviceCategory(ctx);
      }));
      expect(category, equals(DeviceCategory.mediumMobile));
    });

    testWidgets('identifies large mobile correctly', (tester) async {
      DeviceCategory? category;
      await tester.pumpWidget(buildTestWidget(480, (ctx) {
        category = ResponsiveUtils.getDeviceCategory(ctx);
      }));
      expect(category, equals(DeviceCategory.largeMobile));

      await tester.pumpWidget(buildTestWidget(599, (ctx) {
        category = ResponsiveUtils.getDeviceCategory(ctx);
      }));
      expect(category, equals(DeviceCategory.largeMobile));
    });

    testWidgets('identifies tablet correctly', (tester) async {
      DeviceCategory? category;
      await tester.pumpWidget(buildTestWidget(600, (ctx) {
        category = ResponsiveUtils.getDeviceCategory(ctx);
      }));
      expect(category, equals(DeviceCategory.tablet));
    });

    testWidgets('valueByDevice falls back correctly', (tester) async {
      String? result;
      await tester.pumpWidget(buildTestWidget(600, (ctx) {
        // No tablet or largeMobile value provided, should fall back to mediumMobile
        result = ResponsiveUtils.valueByDevice<String>(
          context: ctx,
          smallMobile: 'small',
          mediumMobile: 'medium',
        );
      }));
      expect(result, equals('medium'));
    });
  });
}

