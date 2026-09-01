import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_hotel_booking_app/core/widgets/custom_bottom_navigation_bar.dart';

void main() {
  testWidgets(
    'CustomBottomNavigationBar does not throw when screen width is 0',
    (tester) async {
      // Reproduces the real-device crash: MediaQuery briefly reports a
      // zero-width screen size during the very first build (before the
      // native view is fully attached), which previously made an internal
      // clamp(0.0, negativeNumber) throw ArgumentError.
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(0, 0)),
          child: MaterialApp(
            home: Scaffold(
              bottomNavigationBar: CustomBottomNavigationBar(
                currentIndex: 0,
                onTap: (_) {},
              ),
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
    },
  );
}
