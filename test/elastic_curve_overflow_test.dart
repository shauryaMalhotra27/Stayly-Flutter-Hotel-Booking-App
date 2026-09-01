import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_hotel_booking_app/core/widgets/custom_bottom_navigation_bar.dart';

void main() {
  testWidgets(
    'CustomBottomNavigationBar does not overflow with Curves.elasticInOut mid-animation',
    (tester) async {
      // Curves.elasticInOut overshoots past [0,1] during its spring bounce,
      // which previously pushed the pill's interpolated width past its
      // fixed activeWidth/inactiveWidth bound and overflowed the Row inside
      // it by a fraction of a pixel during the bounce (not at rest).
      int currentIndex = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) => Scaffold(
              bottomNavigationBar: CustomBottomNavigationBar(
                currentIndex: currentIndex,
                onTap: (i) => setState(() => currentIndex = i),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.flight_takeoff_outlined).first);

      // Step through the animation in small increments so we actually catch
      // the overshoot frames, instead of jumping straight to the settled end
      // state with pumpAndSettle.
      for (var i = 0; i < 30; i++) {
        await tester.pump(const Duration(milliseconds: 33));
        expect(tester.takeException(), isNull);
      }
    },
  );
}
