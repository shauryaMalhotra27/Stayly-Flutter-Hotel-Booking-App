import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_hotel_booking_app/main.dart';

void main() {
  testWidgets('displays the Hotel Booking App', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Hotel Booking App'), findsOneWidget);
  });
}
