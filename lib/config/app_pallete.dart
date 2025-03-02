import 'package:flutter/material.dart';

/// Defines the application's color palette and other visual constants.
///
/// This class serves as a centralized place for all colors used in the app.
/// Colors are organized by their purpose:
/// - Primary colors for main UI elements
/// - Accent colors for highlights and secondary actions
/// - Neutral colors for backgrounds and borders
/// - Status colors for feedback and states
/// - Text colors for different types of text
/// - Gradient definitions for advanced styling
class Apppallete {
  /// Primary theme colors used for main UI elements
  static const Color primaryColor = Color(0xFF2196F3); // Main brand color
  static const Color primaryLightColor = Color(0xFFBBDEFB); // Light variant
  static const Color primaryDarkColor = Color(0xFF1976D2); // Darker variant
  static const Color primaryColoryellowish = Color.fromARGB(
    255,
    199,
    85,
    23,
  ); // Darker variant

  static const Color primaryColorLight = Color(0xFF2196F3);
  static const Color primaryColorDark = Color(0xFFBBDEFB);

  /// Dark theme specific colors for buttons
  static const Color darkThemeButtonColor = Color(0xFFFFC107); // Yellow
  static const Color darkThemeButtonLightColor = Color(
    0xFFFFD54F,
  ); // Light yellow
  static const Color darkThemeButtonDarkColor = Color(
    0xFFFFA000,
  ); // Dark yellow

  /// Accent colors used for highlights and secondary actions
  static const Color accentColor = Color(0xFFFFC107); // Secondary brand color
  static const Color secondaryColor = Color(0xFF4CAF50); // Alternative accent

  /// Neutral colors for general UI elements
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Color(0xFF9E9E9E); // Standard grey
  static const Color lightGrey = Color(0xFFE0E0E0);
  static const Color darkGrey = Color(0xFF424242);

  /// Status colors for user feedback
  static const Color success = Color(0xFF4CAF50); // Success messages and icons
  static const Color error = Color(0xFFF44336); // Error messages and validation
  static const Color warning = Color(0xFFFF9800); // Warning messages
  static const Color info = Color(0xFF2196F3); // Information messages

  /// Background colors for different surface levels
  static const Color backgroundColor = Color(0xFF121212); // Main background
  static const Color surfaceColor = Color(
    0xFF1E1E1E,
  ); // Card and surface background
  static const Color cardColor = Color(0xFF2C2C2C); // Elevated surface color
  static const Color dividerColor = Color(
    0xFF323232,
  ); // Divider and border color

  /// Text colors for different purposes
  static const Color textPrimary = Colors.black;
  static const Color textPrimaryLight = Colors.white;
  static const Color textPrimaryDark = Colors.white;
  static const Color textSecondary = Colors.grey;
  static const Color textSecondaryDark = Colors.grey;
  static const Color textHint = Color(0xFF666666); // Hint text
  static const Color textDisabled = Color(0xFF4D4D4D); // Disabled text

  /// Gradient definitions for advanced styling
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryColor, primaryColoryellowish, primaryLightColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Dark theme specific gradient
  static const LinearGradient darkThemeGradient = LinearGradient(
    colors: [darkThemeButtonColor, primaryColorDark, primaryColorLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Opacity values for different states
  static const double activeOpacity = 1.0; // Fully active elements
  static const double inactiveOpacity = 0.5; // Inactive elements
  static const double disabledOpacity = 0.38; // Disabled elements
}
