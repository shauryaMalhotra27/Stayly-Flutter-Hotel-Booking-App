import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_hotel_booking_app/core/utils/app_logger.dart';

void main() {
  test('AppLogger methods execute without errors', () {
    // We cannot easily intercept dart:developer logs in standard widget tests,
    // but we can ensure they do not throw errors when called.
    expect(() => AppLogger.debug('Debug message'), returnsNormally);
    expect(() => AppLogger.info('Info message'), returnsNormally);
    expect(() => AppLogger.warning('Warning message'), returnsNormally);
    expect(() => AppLogger.error('Error message'), returnsNormally);
  });
}
