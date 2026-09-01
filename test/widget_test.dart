import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hotel_booking_app/app/app.dart';
import 'package:flutter_hotel_booking_app/core/widgets/custom_bottom_navigation_bar.dart';

void main() {
  testWidgets('App shell and bottom navigation render correctly', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: App()));

    // Verify that the initial route (Dashboard) renders
    expect(find.text('Dashboard Placeholder'), findsOneWidget);

    // Verify that the CustomBottomNavigationBar is rendered
    expect(find.byType(CustomBottomNavigationBar), findsOneWidget);

    // Tap on the second nav item (Hotels Resort tab), identified by its icon.
    // The nav bar renders two Icon widgets per tab (a hidden layout-reserving
    // copy plus the visible one), so take the first match.
    await tester.tap(
      find.byIcon(Icons.flight_takeoff_outlined).first,
      warnIfMissed: false,
    );
    await tester.pumpAndSettle();

    // Verify that the Hotel view is displayed
    expect(find.text('Hotel Placeholder'), findsOneWidget);
  });
}
