import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_hotel_booking_app/core/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter_hotel_booking_app/l10n/app_strings.dart';

void main() {
  testWidgets(
    'icon glides to center instead of snapping when a tab goes active -> inactive',
    (tester) async {
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

      await tester.tap(find.bySemanticsLabel(AppStrings.current.navDashboard));

      // Hotels tab is ValueKey(1); track its SVG while the pill shrinks.
      final iconFinder = find.descendant(
        of: find.byKey(const ValueKey(1)),
        matching: find.byType(SvgPicture),
      );
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
