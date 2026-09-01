import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_hotel_booking_app/core/widgets/custom_bottom_navigation_bar.dart';

void main() {
  testWidgets(
    'icon glides to center instead of snapping when a tab goes active -> inactive',
    (tester) async {
      // Previously, the label was removed from the Row the instant its
      // opacity/width animation reached t == 0, which caused the Row to
      // suddenly re-center around the icon alone — visible as the icon
      // sitting at the far left of its circle for most of the shrink, then
      // snapping to center in a single frame right at the end. The label
      // must instead shrink its own footprint to exactly 0 in step with the
      // container, so the icon's position moves continuously throughout.
      int currentIndex = 1;
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

      await tester.tap(find.byIcon(Icons.home_outlined).first);

      final iconFinder = find.byIcon(Icons.flight_takeoff_outlined);
      double? previousRelativeX;
      var maxJump = 0.0;

      for (var i = 0; i < 40; i++) {
        await tester.pump(const Duration(milliseconds: 33));

        final iconBox = tester.renderObject(iconFinder.first) as RenderBox;
        final iconGlobal = iconBox.localToGlobal(Offset.zero);

        final buttonFinder = find.ancestor(
          of: iconFinder.first,
          matching: find.byType(InkWell),
        );
        final buttonBox = tester.renderObject(buttonFinder.first) as RenderBox;
        final buttonGlobal = buttonBox.localToGlobal(Offset.zero);

        final relativeX = iconGlobal.dx - buttonGlobal.dx;

        if (previousRelativeX != null) {
          final jump = (relativeX - previousRelativeX).abs();
          if (jump > maxJump) maxJump = jump;
        }
        previousRelativeX = relativeX;
      }

      // A smooth transition moves a fraction of a pixel per frame; the old
      // bug produced a single ~18px jump in one frame. 5px is a generous
      // threshold that still clearly fails on the old snap-to-center bug.
      expect(
        maxJump,
        lessThan(5.0),
        reason:
            'Icon position jumped by $maxJump px in a single frame — it should '
            'glide smoothly to center, not snap.',
      );
    },
  );
}
