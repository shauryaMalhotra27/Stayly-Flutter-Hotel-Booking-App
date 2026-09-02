import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hotel_booking_app/app/app.dart';
import 'package:flutter_hotel_booking_app/core/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter_hotel_booking_app/features/hotel/views/hotel_view.dart';
import 'package:flutter_hotel_booking_app/l10n/app_strings.dart';

void main() {
  testWidgets('App shell and bottom navigation render correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: App()));
    await tester.pump();

    expect(
      find.textContaining(AppStrings.current.userDisplayName),
      findsWidgets,
    );
    expect(find.byType(CustomBottomNavigationBar), findsOneWidget);

    await tester.tap(find.bySemanticsLabel(AppStrings.current.navHotelsResort));
    await tester.pump();

    expect(find.byType(HotelView), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
  });
}
