import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_hotel_booking_app/core/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter_hotel_booking_app/l10n/app_strings.dart';

void main() {
  testWidgets(
    'CustomBottomNavigationBar does not overflow with Curves.elasticInOut mid-animation',
    (tester) async {
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

      await tester.tap(
        find.bySemanticsLabel(AppStrings.current.navHotelsResort),
      );

      for (var i = 0; i < 30; i++) {
        await tester.pump(const Duration(milliseconds: 33));
        expect(tester.takeException(), isNull);
      }
    },
  );
}
