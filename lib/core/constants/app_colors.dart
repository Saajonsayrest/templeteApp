import 'package:flutter/material.dart';

class AppColors {
  /* ================= BRAND ================= */

  /// AppBar, primary buttons, active icons
  static const Color primary = Color(0xFF3F5F0B); // Dark olive green

  /// Lighter variant used in icons & subtle accents
  static const Color primaryLight = Color(0xFF6B8E23);

  /// Very light green (icon background, badges)
  static const Color primarySoft = Color(0xFFE6EEDC);

  /* ================= BACKGROUND ================= */

  /// Main scaffold background
  static const Color background = Color(0xFFF4F5F2);

  /// Cards, sheets
  static const Color surface = Color(0xFFFFFFFF);

  /* ================= TEXT ================= */

  /// Titles, primary labels
  static const Color textPrimary = Color(0xFF1F1F1F);

  /// Secondary text (dates, subtitles)
  static const Color textSecondary = Color(0xFF6E6E6E);

  /// Disabled / hint text
  static const Color textDisabled = Color(0xFF9E9E9E);

  /// Text on dark backgrounds
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  /* ================= BUTTONS ================= */

  /// Primary CTA buttons
  static const Color buttonPrimary = Color(0xFF3F5F0B);

  /// Secondary / outline buttons bg
  static const Color buttonSecondary = Color(0xFFE9EDE3);

  /// Button text
  static const Color buttonText = Color(0xFFFFFFFF);

  /* ================= BOTTOM NAV ================= */

  /// Bottom nav background
  static const Color navBackground = Color(0xFFFFFFFF);

  /// Active icon/text
  static const Color navActive = Color(0xFF3F5F0B);

  /// Inactive icon/text
  static const Color navInactive = Color(0xFF9AA09A);

  /* ================= STATUS ================= */

  /// Success (published, completed)
  static const Color success = Color(0xFF4CAF50);

  /// Warning (result pending, info card)
  static const Color warning = Color(0xFFF4C98A);

  /// Error (break, missed, alerts)
  static const Color error = Color(0xFFD32F2F);

  /* ================= BORDERS & DIVIDERS ================= */

  static const Color divider = Color(0xFFE1E3DD);
  static const Color border = Color(0xFFDADDD6);

  /* ================= UTILITY ================= */

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
}
