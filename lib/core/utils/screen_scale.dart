import 'package:flutter/widgets.dart';

/// Width-based scale used the same way as bottom-nav metrics.
class ScreenScale {
  ScreenScale._();

  static const double baselineWidth = 390.0;
  static const double minScale = 0.85;
  static const double maxScale = 1.35;
  static const double scaleCapWidth = 500.0;

  /// Continuous scale from screen width (capped on large tablets).
  static double of(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final effectiveWidth = width < scaleCapWidth ? width : scaleCapWidth;
    return (effectiveWidth / baselineWidth).clamp(minScale, maxScale);
  }
}
