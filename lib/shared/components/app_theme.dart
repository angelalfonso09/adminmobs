import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Colors.blue;
  static const Color approved = Color(0xFF517690);
  static const Color pending = Colors.orange;
  static const Color rejected = Colors.red;
  static const Color textPrimary = Colors.black;
  static const Color textSecondary = Colors.grey;
  static const Color cardBorder = Color(0xFFE0E0E0);
  static const Color background = Color(0xFFF5F5F5);
  static const Color cardBackground = Colors.white;
  static const Color divider = Color(0xFFE0E0E0);
}

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle cardTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle cardSubtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static const TextStyle cardBody = TextStyle(
    fontSize: 14,
    color: AppColors.textPrimary,
  );

  static const TextStyle cardMeta = TextStyle(
    fontSize: 12,
    color: Color(0xFF757575),
  );

  static const TextStyle statusBadge = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );

  static const TextStyle statusBadgeWhite = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );

  static const TextStyle buttonText = TextStyle(
    color: AppColors.primary,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
}

class AppTheme {
  static ThemeData get theme => ThemeData(
    primarySwatch: Colors.blue,
    useMaterial3: false,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
    ),
  );
}
