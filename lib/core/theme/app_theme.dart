import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  AppTheme._();

  // ===========================
  // 🎨 Premium Color Palette
  // ===========================

  // Primary Colors
  static const Color primaryCyan = Color(0xFF06B6D4);
  static const Color primaryCyanDark = Color(0xFF0891B2);
  static const Color accentViolet = Color(0xFF8B5CF6);
  static const Color accentPurple = Color(0xFF7C3AED);

  // Slate Palette (Dark Mode)
  static const Color slate950 = Color(0xFF020617);
  static const Color slate900 = Color(0xFF0F172A);
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate750 = Color(0xFF283548);
  static const Color slate700 = Color(0xFF334155);
  static const Color slate600 = Color(0xFF475569);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate850 = Color(0xFF172033);

  // Semantic Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // ===========================
  // 🌑 Premium Dark Theme
  // ===========================
  static ThemeData get darkTheme {
    const ColorScheme colorScheme = ColorScheme(
      brightness: Brightness.dark,

      // Primary colors
      primary: primaryCyan,
      onPrimary: Color(0xFF003544),
      primaryContainer: primaryCyanDark,
      onPrimaryContainer: Color(0xFFB8F5FF),

      // Secondary colors
      secondary: accentViolet,
      onSecondary: Color(0xFF381E72),
      secondaryContainer: accentPurple,
      onSecondaryContainer: Color(0xFFEADDFF),

      // Tertiary
      tertiary: Color(0xFFF97316),
      onTertiary: Color(0xFF5A1A00),
      tertiaryContainer: Color(0xFFEA580C),
      onTertiaryContainer: Color(0xFFFFEDDB),

      // Error
      error: error,
      onError: Color(0xFF690005),
      errorContainer: Color(0xFF93000A),
      onErrorContainer: Color(0xFFFFDAD6),

      // Surfaces
      surface: slate900,
      onSurface: slate100,
      surfaceContainerHighest: slate700,
      surfaceContainerHigh: slate750,
      surfaceContainer: slate800,
      surfaceContainerLow: slate850,
      surfaceContainerLowest: slate900,
      onSurfaceVariant: slate400,

      // Outlines
      outline: slate600,
      outlineVariant: slate700,

      // Shadows & overlays
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: slate100,
      onInverseSurface: slate900,
      inversePrimary: primaryCyanDark,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: Brightness.dark,

      // ===========================
      // 📱 System UI Overlay
      // ===========================
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: slate900.withValues(alpha: 0.95),
        surfaceTintColor: Colors.transparent,
        foregroundColor: slate100,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: slate100,
          letterSpacing: -0.3,
        ),
        iconTheme: const IconThemeData(color: slate100, size: 24),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
        ),
      ),

      // ===========================
      // 🃏 Card Styling (Glassmorphic)
      // ===========================
      cardTheme: CardThemeData(
        color: slate800.withValues(alpha: 0.6),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shadowColor: primaryCyan.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: slate700.withValues(alpha: 0.5), width: 1),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),

      // ===========================
      // 🔘 Button Themes
      // ===========================
      elevatedButtonTheme: ElevatedButtonThemeData(
        style:
            ElevatedButton.styleFrom(
              backgroundColor: primaryCyan,
              foregroundColor: slate950,
              elevation: 0,
              shadowColor: primaryCyan.withValues(alpha: 0.3),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ).copyWith(
              elevation: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.pressed)) return 0;
                if (states.contains(WidgetState.hovered)) return 8;
                return 4;
              }),
            ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primaryCyan,
          foregroundColor: slate950,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryCyan,
          side: const BorderSide(color: primaryCyan, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryCyan,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),

      // ===========================
      // 🎯 Floating Action Button
      // ===========================
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryCyan,
        foregroundColor: slate950,
        elevation: 8,
        highlightElevation: 12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        iconSize: 28,
      ),

      // ===========================
      // 📝 Input Field Styling
      // ===========================
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: slate800.withValues(alpha: 0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: slate700, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: slate700, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primaryCyan, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        hintStyle: TextStyle(color: slate500, fontSize: 14),
        labelStyle: TextStyle(color: slate400, fontSize: 14),
        prefixIconColor: primaryCyan,
        suffixIconColor: slate400,
      ),

      // ===========================
      // 📊 List Tile
      // ===========================
      listTileTheme: ListTileThemeData(
        tileColor: slate800.withValues(alpha: 0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        iconColor: primaryCyan,
        textColor: slate100,
      ),

      // ===========================
      // 🎨 Chip Theme
      // ===========================
      chipTheme: ChipThemeData(
        backgroundColor: slate800,
        deleteIconColor: slate400,
        disabledColor: slate700,
        selectedColor: primaryCyan.withValues(alpha: 0.2),
        secondarySelectedColor: accentViolet.withValues(alpha: 0.2),
        labelPadding: const EdgeInsets.symmetric(horizontal: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: slate700),
        ),
        labelStyle: const TextStyle(
          color: slate100,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        secondaryLabelStyle: const TextStyle(color: slate100),
        brightness: Brightness.dark,
      ),

      // ===========================
      // 🔲 Divider
      // ===========================
      dividerTheme: DividerThemeData(
        color: slate700.withValues(alpha: 0.5),
        thickness: 1,
        space: 1,
      ),

      // ===========================
      // 📱 Bottom Navigation
      // ===========================
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: slate900,
        selectedItemColor: primaryCyan,
        unselectedItemColor: slate500,
        selectedIconTheme: const IconThemeData(size: 28, color: primaryCyan),
        unselectedIconTheme: IconThemeData(size: 24, color: slate500),
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // ===========================
      // 📄 Dialog Theme
      // ===========================
      dialogTheme: DialogThemeData(
        backgroundColor: slate800,
        surfaceTintColor: Colors.transparent,
        elevation: 24,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        titleTextStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: slate100,
        ),
        contentTextStyle: TextStyle(fontSize: 14, color: slate300, height: 1.5),
      ),

      // ===========================
      // 📲 Bottom Sheet Theme
      // ===========================
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: slate900,
        surfaceTintColor: Colors.transparent,
        modalBackgroundColor: slate900,
        elevation: 16,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        modalElevation: 16,
      ),

      // ===========================
      // 🎭 Other Themes
      // ===========================
      scaffoldBackgroundColor: slate900,
      canvasColor: slate900,
      shadowColor: Colors.black.withValues(alpha: 0.3),

      // Icon theme
      iconTheme: const IconThemeData(color: slate100, size: 24),

      // Typography
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.w700,
          color: slate100,
          letterSpacing: -1.5,
        ),
        displayMedium: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.w700,
          color: slate100,
          letterSpacing: -1.0,
        ),
        displaySmall: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w600,
          color: slate100,
          letterSpacing: -0.5,
        ),
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: slate100,
          letterSpacing: -0.5,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: slate100,
          letterSpacing: -0.3,
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: slate100,
          letterSpacing: 0,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: slate100,
          letterSpacing: 0,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: slate100,
          letterSpacing: 0.15,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: slate100,
          letterSpacing: 0.1,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: slate100,
          letterSpacing: 0.15,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: slate200,
          letterSpacing: 0.25,
          height: 1.5,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: slate300,
          letterSpacing: 0.4,
          height: 1.4,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: slate100,
          letterSpacing: 0.1,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: slate200,
          letterSpacing: 0.5,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: slate300,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  // ===========================
  // 🌞 Premium Light Theme
  // ===========================
  static ThemeData get lightTheme {
    const ColorScheme colorScheme = ColorScheme(
      brightness: Brightness.light,

      primary: primaryCyanDark,
      onPrimary: Colors.white,
      primaryContainer: Color(0xFFE0F7FA),
      onPrimaryContainer: Color(0xFF003544),

      secondary: accentViolet,
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFFF3E5F5),
      onSecondaryContainer: Color(0xFF381E72),

      tertiary: Color(0xFFF97316),
      onTertiary: Colors.white,
      tertiaryContainer: Color(0xFFFFE8D6),
      onTertiaryContainer: Color(0xFF5A1A00),

      error: error,
      onError: Colors.white,
      errorContainer: Color(0xFFFFEBEE),
      onErrorContainer: Color(0xFF690005),

      surface: Colors.white,
      onSurface: slate900,
      surfaceContainerHighest: slate100,
      surfaceContainerHigh: slate50,
      surfaceContainer: Colors.white,
      surfaceContainerLow: Colors.white,
      surfaceContainerLowest: Colors.white,
      onSurfaceVariant: slate600,

      outline: slate300,
      outlineVariant: slate200,

      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: slate900,
      onInverseSurface: slate100,
      inversePrimary: primaryCyan,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: Brightness.light,

      // ===========================
      // 📱 App Bar
      // ===========================
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 2,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        foregroundColor: slate900,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: slate900,
          letterSpacing: -0.3,
        ),
        iconTheme: const IconThemeData(color: slate700, size: 24),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
      ),

      // ===========================
      // 🃏 Card Styling
      // ===========================
      cardTheme: CardThemeData(
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 2,
        shadowColor: slate900.withValues(alpha: 0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: slate200, width: 1),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),

      // ===========================
      // 🔘 Buttons
      // ===========================
      elevatedButtonTheme: ElevatedButtonThemeData(
        style:
            ElevatedButton.styleFrom(
              backgroundColor: primaryCyanDark,
              foregroundColor: Colors.white,
              elevation: 2,
              shadowColor: primaryCyanDark.withValues(alpha: 0.3),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ).copyWith(
              elevation: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.pressed)) return 1;
                if (states.contains(WidgetState.hovered)) return 4;
                return 2;
              }),
            ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primaryCyanDark,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryCyanDark,
          side: const BorderSide(color: primaryCyanDark, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryCyanDark,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),

      // ===========================
      // 🎯 FAB
      // ===========================
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryCyanDark,
        foregroundColor: Colors.white,
        elevation: 4,
        highlightElevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        iconSize: 28,
      ),

      // ===========================
      // 📝 Input Fields
      // ===========================
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: slate50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: slate300, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: slate300, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primaryCyanDark, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        hintStyle: TextStyle(color: slate500, fontSize: 14),
        labelStyle: TextStyle(color: slate600, fontSize: 14),
        prefixIconColor: primaryCyanDark,
        suffixIconColor: slate500,
      ),

      // ===========================
      // 📊 List Tile
      // ===========================
      listTileTheme: ListTileThemeData(
        tileColor: slate50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        iconColor: primaryCyanDark,
        textColor: slate900,
      ),

      // ===========================
      // 🎨 Chips
      // ===========================
      chipTheme: ChipThemeData(
        backgroundColor: slate100,
        deleteIconColor: slate600,
        disabledColor: slate200,
        selectedColor: primaryCyanDark.withValues(alpha: 0.15),
        secondarySelectedColor: accentViolet.withValues(alpha: 0.15),
        labelPadding: const EdgeInsets.symmetric(horizontal: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: slate300),
        ),
        labelStyle: const TextStyle(
          color: slate900,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        secondaryLabelStyle: const TextStyle(color: slate900),
        brightness: Brightness.light,
      ),

      // ===========================
      // 🔲 Divider
      // ===========================
      dividerTheme: DividerThemeData(color: slate200, thickness: 1, space: 1),

      // ===========================
      // 📱 Bottom Nav
      // ===========================
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: primaryCyanDark,
        unselectedItemColor: slate500,
        selectedIconTheme: const IconThemeData(
          size: 28,
          color: primaryCyanDark,
        ),
        unselectedIconTheme: IconThemeData(size: 24, color: slate500),
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // ===========================
      // 📄 Dialog
      // ===========================
      dialogTheme: DialogThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 24,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        titleTextStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: slate900,
        ),
        contentTextStyle: TextStyle(fontSize: 14, color: slate700, height: 1.5),
      ),

      // ===========================
      // 📲 Bottom Sheet
      // ===========================
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        modalBackgroundColor: Colors.white,
        elevation: 16,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        modalElevation: 16,
      ),

      // ===========================
      // 🎭 General
      // ===========================
      scaffoldBackgroundColor: slate50,
      canvasColor: Colors.white,
      shadowColor: Colors.black.withValues(alpha: 0.1),

      iconTheme: const IconThemeData(color: slate700, size: 24),

      // Typography
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.w700,
          color: slate900,
          letterSpacing: -1.5,
        ),
        displayMedium: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.w700,
          color: slate900,
          letterSpacing: -1.0,
        ),
        displaySmall: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w600,
          color: slate900,
          letterSpacing: -0.5,
        ),
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: slate900,
          letterSpacing: -0.5,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: slate900,
          letterSpacing: -0.3,
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: slate900,
          letterSpacing: 0,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: slate900,
          letterSpacing: 0,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: slate900,
          letterSpacing: 0.15,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: slate900,
          letterSpacing: 0.1,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: slate900,
          letterSpacing: 0.15,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: slate700,
          letterSpacing: 0.25,
          height: 1.5,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: slate600,
          letterSpacing: 0.4,
          height: 1.4,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: slate900,
          letterSpacing: 0.1,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: slate700,
          letterSpacing: 0.5,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: slate600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
