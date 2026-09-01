import 'package:flutter/widgets.dart';

enum DeviceCategory { smallMobile, mediumMobile, largeMobile, tablet }

/// Centralized responsive layout utility for the application.
class ResponsiveUtils {
  ResponsiveUtils._();

  /// Determines the device category based on screen width.
  static DeviceCategory getDeviceCategory(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 360) {
      return DeviceCategory.smallMobile;
    } else if (width < 480) {
      return DeviceCategory.mediumMobile;
    } else if (width < 600) {
      return DeviceCategory.largeMobile;
    } else {
      return DeviceCategory.tablet;
    }
  }

  /// Returns true if the device is categorized as small mobile.
  static bool isSmallMobile(BuildContext context) =>
      getDeviceCategory(context) == DeviceCategory.smallMobile;

  /// Returns true if the device is categorized as medium mobile.
  static bool isMediumMobile(BuildContext context) =>
      getDeviceCategory(context) == DeviceCategory.mediumMobile;

  /// Returns true if the device is categorized as large mobile.
  static bool isLargeMobile(BuildContext context) =>
      getDeviceCategory(context) == DeviceCategory.largeMobile;

  /// Returns true if the device is categorized as tablet.
  static bool isTablet(BuildContext context) =>
      getDeviceCategory(context) == DeviceCategory.tablet;

  /// Returns a responsive value based on the current device category.
  static T valueByDevice<T>({
    required BuildContext context,
    required T smallMobile,
    T? mediumMobile,
    T? largeMobile,
    T? tablet,
  }) {
    final category = getDeviceCategory(context);
    switch (category) {
      case DeviceCategory.smallMobile:
        return smallMobile;
      case DeviceCategory.mediumMobile:
        return mediumMobile ?? smallMobile;
      case DeviceCategory.largeMobile:
        return largeMobile ?? mediumMobile ?? smallMobile;
      case DeviceCategory.tablet:
        return tablet ?? largeMobile ?? mediumMobile ?? smallMobile;
    }
  }
}
