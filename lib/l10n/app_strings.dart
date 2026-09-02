import 'en_strings.dart';

/// UI copy API. Swap [current] to another locale file later (e.g. HiStrings).
abstract class AppStrings {
  static AppStrings current = EnStrings();

  // App
  String get appTitle;
  String get userDisplayName;

  // Time-based greeting prefixes (name appended by [greetingForNow]).
  String get goodMorning;
  String get goodAfternoon;
  String get goodEvening;

  // Nav
  String get navDashboard;
  String get navHotelsResort;
  String get navBookingHotel;
  String get navAccount;

  // Dashboard
  String get searchLocationHint;
  String get noResultsFound;
  String get noResultsHint;
  String get returnToList;
  String get couldNotLoadHotels;

  // Property card labels
  String get distance;
  String get available;
  String get price;

  // Coming soon dialog
  String get comingSoonTitle;
  String get comingSoonBody;
  String get ok;

  // Hotel detail
  String get description;
  String get couldNotLoadHotel;
  String get noHotelSelected;
  String get reviewsSuffix;

  // Placeholders
  String get accountPlaceholder;
  String get bookingPlaceholder;

  // Booking
  String get cancelDate;
  String get selectDatesHint;
  String nightStay(int nights);

  /// "Good Morning Prabhat" based on local time.
  String greetingForNow({DateTime? now, String? name}) {
    final time = now ?? DateTime.now();
    final displayName = name ?? userDisplayName;
    final String period;
    if (time.hour < 12) {
      period = goodMorning;
    } else if (time.hour < 17) {
      period = goodAfternoon;
    } else {
      period = goodEvening;
    }
    return '$period $displayName';
  }

  /// e.g. "1,648 reviews"
  String reviewsLabel(int count) {
    final formatted = count.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
    return '$formatted $reviewsSuffix';
  }
}
