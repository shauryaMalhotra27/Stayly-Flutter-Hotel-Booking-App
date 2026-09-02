import 'app_strings.dart';

/// English UI strings. Add `hi_strings.dart` (etc.) later for other locales.
class EnStrings extends AppStrings {
  @override
  String get appTitle => 'Hotel Booking App';

  @override
  String get userDisplayName => 'Prabhat';

  @override
  String get goodMorning => 'Good Morning';

  @override
  String get goodAfternoon => 'Good Afternoon';

  @override
  String get goodEvening => 'Good Evening';

  @override
  String get navDashboard => 'Dashboard';

  @override
  String get navHotelsResort => 'Hotels Resort';

  @override
  String get navBookingHotel => 'Booking Hotel';

  @override
  String get navAccount => 'Account';

  @override
  String get searchLocationHint => 'Search Location';

  @override
  String get noResultsFound => 'No results found';

  @override
  String get noResultsHint =>
      'Try a different location, distance, date, or price.';

  @override
  String get returnToList => 'Return to list';

  @override
  String get couldNotLoadHotels => 'Could not load hotels.';

  @override
  String get distance => 'Distance';

  @override
  String get available => 'Available';

  @override
  String get price => 'Price';

  @override
  String get comingSoonTitle => 'Coming soon';

  @override
  String get comingSoonBody =>
      'Work in progress. This will be available in a future update.';

  @override
  String get ok => 'OK';

  @override
  String get description => 'Description';

  @override
  String get couldNotLoadHotel => 'Could not load hotel.';

  @override
  String get noHotelSelected => 'No hotel selected.';

  @override
  String get reviewsSuffix => 'reviews';

  @override
  String get accountPlaceholder => 'Account Placeholder';

  @override
  String get bookingPlaceholder => 'Booking Placeholder';

  @override
  String get cancelDate => 'Cancel Date';

  @override
  String get selectDatesHint => 'Select dates';

  @override
  String nightStay(int nights) =>
      nights == 1 ? '1-night stay' : '$nights-night stay';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get editProfileSubtitle => 'Manage your professional profile';

  @override
  String get accountSettings => 'Account';

  @override
  String get accountSettingsSubtitle => 'Manage account and login settings';

  @override
  String get notification => 'Notification';

  @override
  String get notificationSubtitle => 'Manage your notification preferences';

  @override
  String get appearance => 'Appearance';

  @override
  String get appearanceSubtitle => 'Customize your app experience';

  @override
  String get helpAndFeedback => 'Help & Feedback';

  @override
  String get helpAndFeedbackSubtitle => 'Get help or share feedback';

  @override
  String get inviteFriend => 'Invite a friend';

  @override
  String get inviteFriendSubtitle => 'Invite friends to NextRole.app';

  @override
  String get privacySecurity => 'Privacy & Security';

  @override
  String get privacySecuritySubtitle => 'Manage privacy and data settings';

  @override
  String get subscription => 'Subscription';

  @override
  String get subscriptionSubtitle => 'Manage your plan and billing';

  @override
  String get comingSoonBadge => 'Coming Soon';
}
