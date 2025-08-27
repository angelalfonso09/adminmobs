import 'package:flutter/material.dart';
import '../../../shared/components/app_theme.dart';

class AdminTheme {
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
      elevation: 2,
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 2,
      ),
    ),
  );
}

class AdminColors extends AppColors {
  static const Color adminPrimary = Color(0xFF517690);
  static const Color adminSecondary = Color(0xFF7BA8C4);
  static const Color adminSuccess = Color(0xFF4CAF50);
  static const Color adminWarning = Color(0xFFFF9800);
  static const Color adminError = Color(0xFFE53935);
}

class AdminTextStyles extends AppTextStyles {
  static const TextStyle adminHeading = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AdminColors.adminPrimary,
  );
  
  static const TextStyle adminSubheading = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle adminButtonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}
