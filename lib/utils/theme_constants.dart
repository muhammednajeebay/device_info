import 'package:flutter/material.dart';

// Light Mode Colors
class AppColors {
  // System Colors (iOS)
  // Deep Space Palette
  static const Color spaceBackgroundStart = Color(0xFF0A0E27);
  static const Color spaceBackgroundEnd = Color(0xFF1A1F3A);

  static const Color primary = Color(0xFF3B82F6); // Vibrant Blue
  static const Color accent = Color(0xFF7C3AED); // Vibrant Purple

  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xB3FFFFFF); // 70% White

  static const Color glassSurface = Color(0x33FFFFFF); // 20% White
  static const Color glassBorder = Color(0x1AFFFFFF); // 10% White

  static const Color error = Color(0xFFEF4444);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);

  // Shadow
  static const Color shadow = Color(0x1A000000);
  static const Color shadowMedium = Color(0x33000000);
  static const Color shadowStrong = Color(0x66000000); // Black with 40% opacity
}

// Dark Mode Colors
class AppColorsDark {
  // Primary Colors
  static const Color primary = Color(0xFF60A5FA); // Blue 400
  static const Color primaryLight = Color(0xFF93C5FD); // Blue 300
  static const Color primaryDark = Color(0xFF3B82F6); // Blue 500
  static const Color primaryContainer = Color(0xFF1E3A8A); // Blue 900

  // Secondary Colors
  static const Color secondary = Color(0xFFA78BFA); // Violet 400
  static const Color secondaryLight = Color(0xFFC4B5FD); // Violet 300
  static const Color secondaryDark = Color(0xFF8B5CF6); // Violet 500
  static const Color secondaryContainer = Color(0xFF4C1D95); // Violet 900

  // Accent Colors
  static const Color accentGreen = Color(0xFF34D399); // Emerald 400
  static const Color accentOrange = Color(0xFFFBBF24); // Amber 400
  static const Color accentPink = Color(0xFFF472B6); // Pink 400
  static const Color accentTeal = Color(0xFF2DD4BF); // Teal 400
  static const Color accentIndigo = Color(0xFF818CF8); // Indigo 400

  // Neutral Colors
  static const Color background = Color(0xFF0F172A); // Slate 900
  static const Color surface = Color(0xFF1E293B); // Slate 800
  static const Color surfaceVariant = Color(0xFF334155); // Slate 700

  // Text Colors
  static const Color textPrimary = Color(0xFFF1F5F9); // Slate 100
  static const Color textSecondary = Color(0xFF94A3B8); // Slate 400
  static const Color textTertiary = Color(0xFF64748B); // Slate 500
  static const Color textOnPrimary = Color(0xFF0F172A); // Slate 900

  // Border & Divider
  static const Color border = Color(0xFF334155); // Slate 700
  static const Color divider = Color(0xFF1E293B); // Slate 800

  // Status Colors
  static const Color success = Color(0xFF34D399); // Emerald 400
  static const Color warning = Color(0xFFFBBF24); // Amber 400
  static const Color error = Color(0xFFF87171); // Red 400
  static const Color info = Color(0xFF60A5FA); // Blue 400

  // Shadow
  static const Color shadow = Color(0x3D000000); // Black with 24% opacity
  static const Color shadowMedium = Color(0x52000000); // Black with 32% opacity
  static const Color shadowStrong = Color(0x66000000); // Black with 40% opacity
}

// Category-Specific Colors
class CategoryColors {
  static const Color battery = Color(0xFF10B981);
  static const Color device = Color(0xFF3B82F6);
  static const Color storage = Color(0xFFF59E0B);
  static const Color system = Color(0xFF7C3AED);
  static const Color connectivity = Color(0xFF3B82F6);
  static const Color sensors = Color(0xFFEC4899);
  static const Color location = Color(0xFFEF4444);

  // Gradients
  static const List<Color> batteryGradient = [
    Color(0xFF10B981),
    Color(0xFF14B8A6),
  ];
  static const List<Color> deviceGradient = [
    Color(0xFF1E3A8A),
    Color(0xFF3B82F6),
  ];
  static const List<Color> storageGradient = [
    Color(0xFFF59E0B),
    Color(0xFFFB923C),
  ];
  static const List<Color> systemGradient = [
    Color(0xFF7C3AED),
    Color(0xFFA78BFA),
  ];
  static const List<Color> connectivityGradient = [
    Color(0xFF3B82F6),
    Color(0xFF60A5FA),
  ];
  static const List<Color> sensorsGradient = [
    Color(0xFFEC4899),
    Color(0xFFF472B6),
  ];
  static const List<Color> locationGradient = [
    Color(0xFFEF4444),
    Color(0xFFF87171),
  ];
  static const List<Color> spaceGradient = [
    AppColors.spaceBackgroundStart,
    AppColors.spaceBackgroundEnd,
  ];
  static const Color audio = Color(0xFF5AC8FA); // Teal
}

// Gradients
class AppGradients {
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2563EB), Color(0xFF7C3AED)],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFFFFF), Color(0xFFF9FAFB)],
  );

  static const LinearGradient batteryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF10B981), Color(0xFF34D399)],
  );

  static const LinearGradient shimmerGradient = LinearGradient(
    begin: Alignment(-1.0, -0.5),
    end: Alignment(1.0, 0.5),
    colors: [Color(0xFFE5E7EB), Color(0xFFF3F4F6), Color(0xFFE5E7EB)],
  );
}

// Spacing System
class AppSpacing {
  // Base spacing unit: 4px
  static const double xs = 4.0; // Extra small
  static const double sm = 8.0; // Small
  static const double md = 12.0; // Medium
  static const double lg = 16.0; // Large
  static const double xl = 20.0; // Extra large
  static const double xxl = 24.0; // 2X large
  static const double xxxl = 32.0; // 3X large
  static const double huge = 40.0; // Huge
  static const double massive = 48.0; // Massive

  // Semantic spacing
  static const double cardPadding = 16.0;
  static const double screenPadding = 16.0;
  static const double sectionSpacing = 24.0;
  static const double listItemSpacing = 12.0;
}

// Border Radius
class AppRadius {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 10.0;
  static const double lg = 13.0;
  static const double xl = 15.0;
  static const double xxl = 20.0;
  static const double full = 9999.0;

  // Semantic radius
  static const double card = 12.0; // iOS Standard
  static const double button = 12.0;
  static const double input = 10.0;
  static const double chip = 9999.0;
}

// Elevation & Shadows
class AppElevation {
  static const double none = 0.0;
  static const double sm = 2.0;
  static const double md = 4.0;
  static const double lg = 8.0;
  static const double xl = 12.0;
  static const double xxl = 16.0;

  // Shadow definitions
  static List<BoxShadow> small = [
    BoxShadow(
      color: AppColors.shadow,
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> medium = [
    BoxShadow(
      color: AppColors.shadowMedium,
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> large = [
    BoxShadow(
      color: AppColors.shadowMedium,
      blurRadius: 16,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> extraLarge = [
    BoxShadow(
      color: AppColors.shadowStrong,
      blurRadius: 24,
      offset: const Offset(0, 12),
    ),
  ];
}

// Icon Sizes
class AppIconSize {
  static const double xs = 16.0;
  static const double sm = 20.0;
  static const double md = 24.0;
  static const double lg = 32.0;
  static const double xl = 40.0;
  static const double xxl = 48.0;
  static const double huge = 64.0;
}
