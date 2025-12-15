import 'package:flutter/material.dart';

class AppTheme {
  // Private constructor to prevent instantiation.
  AppTheme._();

  // ===========================
  // 🎨 The Unique Seed Color
  // ===========================
  // Changed from Colors.teal to a custom Royal Slate Blue hex code.
  static const Color _seedColor = Color(0xFF2E5CB8);

  // ===========================
  // 🌗 Light Theme Getter
  // ===========================
  static ThemeData get lightTheme {
    // 1. Generate the color scheme first.
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.light,
    );

    // 2. Return the ThemeData using the generated scheme.
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme, // Register the scheme
      // AppBar styling
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        // Use scheme colors instead of hardcoded colors
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
      ),

      // Input field styling
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        // M3 standard color for filled inputs
        fillColor: scheme.surfaceContainerHighest,
        // Use primary color for icons and focus labels
        prefixIconColor: scheme.primary,
      ),

      // Elevated Button styling
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
        ),
      ),

      // Floating Action Button styling
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
      ),
    );
  }

  // ===========================
  // 🌑 Dark Theme Getter
  // ===========================
  static ThemeData get darkTheme {
    // 1. Generate dark color scheme.
    final ColorScheme scheme =
        ColorScheme.fromSeed(
          seedColor: _seedColor,
          brightness: Brightness.dark,
        ).copyWith(
          // Keeping your preference for a pure black surface
          surface: const Color(0xFF121212),
        );

    // 2. Return the ThemeData.
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,

      // AppBar styling (Dark)
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
      ),

      // Input field styling (Dark)
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: scheme.surfaceContainer,
        prefixIconColor: scheme.primary,
      ),

      // Card styling
      cardTheme: CardThemeData(
        color: scheme.surfaceContainerLow,
        elevation: 4,
        // Using the primary color with alpha for the shadow glow effect
        shadowColor: scheme.primary.withValues(alpha: 0.4),
      ),

      // Elevated Button styling (Dark)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
        ),
      ),

      // Floating Action Button styling (Dark)
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
      ),
    );
  }
}
