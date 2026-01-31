# Flutter Device Info App - Theme & Design Plan

## Table of Contents
1. [Design Philosophy](#design-philosophy)
2. [Color System](#color-system)
3. [Typography](#typography)
4. [Spacing & Layout](#spacing--layout)
5. [Component Design](#component-design)
6. [Animation System](#animation-system)
7. [Dark Mode](#dark-mode)
8. [Implementation](#implementation)

---

## 1. Design Philosophy

### Core Principles
- **Clarity**: Information should be easy to read and understand
- **Consistency**: Uniform design language throughout the app
- **Subtlety**: Gentle animations that enhance, not distract
- **Performance**: Smooth 60fps animations
- **Accessibility**: High contrast ratios and readable fonts

### Design Mood
- Modern and clean
- Technical but approachable
- Professional with personality
- Data-focused with visual appeal

---

## 2. Color System

### 2.1 Primary Color Palette

```dart
// Light Mode Colors
class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF2563EB);        // Blue 600
  static const Color primaryLight = Color(0xFF3B82F6);   // Blue 500
  static const Color primaryDark = Color(0xFF1E40AF);    // Blue 700
  static const Color primaryContainer = Color(0xFFDCECFE); // Blue 100
  
  // Secondary Colors
  static const Color secondary = Color(0xFF7C3AED);      // Violet 600
  static const Color secondaryLight = Color(0xFF8B5CF6); // Violet 500
  static const Color secondaryDark = Color(0xFF6D28D9);  // Violet 700
  static const Color secondaryContainer = Color(0xFFEDE9FE); // Violet 100
  
  // Accent Colors (for different categories)
  static const Color accentGreen = Color(0xFF10B981);    // Emerald 500
  static const Color accentOrange = Color(0xFFF59E0B);   // Amber 500
  static const Color accentPink = Color(0xFFEC4899);     // Pink 500
  static const Color accentTeal = Color(0xFF14B8A6);     // Teal 500
  static const Color accentIndigo = Color(0xFF6366F1);   // Indigo 500
  
  // Neutral Colors
  static const Color background = Color(0xFFFAFAFA);     // Gray 50
  static const Color surface = Color(0xFFFFFFFF);        // White
  static const Color surfaceVariant = Color(0xFFF3F4F6); // Gray 100
  
  // Text Colors
  static const Color textPrimary = Color(0xFF111827);    // Gray 900
  static const Color textSecondary = Color(0xFF6B7280);  // Gray 500
  static const Color textTertiary = Color(0xFF9CA3AF);   // Gray 400
  static const Color textOnPrimary = Color(0xFFFFFFFF);  // White
  
  // Border & Divider
  static const Color border = Color(0xFFE5E7EB);         // Gray 200
  static const Color divider = Color(0xFFF3F4F6);        // Gray 100
  
  // Status Colors
  static const Color success = Color(0xFF10B981);        // Emerald 500
  static const Color warning = Color(0xFFF59E0B);        // Amber 500
  static const Color error = Color(0xFFEF4444);          // Red 500
  static const Color info = Color(0xFF3B82F6);           // Blue 500
  
  // Shadow
  static const Color shadow = Color(0x0F000000);         // Black with 6% opacity
  static const Color shadowMedium = Color(0x1A000000);   // Black with 10% opacity
  static const Color shadowStrong = Color(0x29000000);   // Black with 16% opacity
}
```

### 2.2 Dark Mode Color Palette

```dart
class AppColorsDark {
  // Primary Colors
  static const Color primary = Color(0xFF60A5FA);        // Blue 400
  static const Color primaryLight = Color(0xFF93C5FD);   // Blue 300
  static const Color primaryDark = Color(0xFF3B82F6);    // Blue 500
  static const Color primaryContainer = Color(0xFF1E3A8A); // Blue 900
  
  // Secondary Colors
  static const Color secondary = Color(0xFFA78BFA);      // Violet 400
  static const Color secondaryLight = Color(0xFFC4B5FD); // Violet 300
  static const Color secondaryDark = Color(0xFF8B5CF6);  // Violet 500
  static const Color secondaryContainer = Color(0xFF4C1D95); // Violet 900
  
  // Accent Colors
  static const Color accentGreen = Color(0xFF34D399);    // Emerald 400
  static const Color accentOrange = Color(0xFFFBBF24);   // Amber 400
  static const Color accentPink = Color(0xFFF472B6);     // Pink 400
  static const Color accentTeal = Color(0xFF2DD4BF);     // Teal 400
  static const Color accentIndigo = Color(0xFF818CF8);   // Indigo 400
  
  // Neutral Colors
  static const Color background = Color(0xFF0F172A);     // Slate 900
  static const Color surface = Color(0xFF1E293B);        // Slate 800
  static const Color surfaceVariant = Color(0xFF334155); // Slate 700
  
  // Text Colors
  static const Color textPrimary = Color(0xFFF1F5F9);    // Slate 100
  static const Color textSecondary = Color(0xFF94A3B8);  // Slate 400
  static const Color textTertiary = Color(0xFF64748B);   // Slate 500
  static const Color textOnPrimary = Color(0xFF0F172A);  // Slate 900
  
  // Border & Divider
  static const Color border = Color(0xFF334155);         // Slate 700
  static const Color divider = Color(0xFF1E293B);        // Slate 800
  
  // Status Colors
  static const Color success = Color(0xFF34D399);        // Emerald 400
  static const Color warning = Color(0xFFFBBF24);        // Amber 400
  static const Color error = Color(0xFFF87171);          // Red 400
  static const Color info = Color(0xFF60A5FA);           // Blue 400
  
  // Shadow
  static const Color shadow = Color(0x3D000000);         // Black with 24% opacity
  static const Color shadowMedium = Color(0x52000000);   // Black with 32% opacity
  static const Color shadowStrong = Color(0x66000000);   // Black with 40% opacity
}
```

### 2.3 Category-Specific Colors

```dart
class CategoryColors {
  static const Color battery = Color(0xFF10B981);        // Green
  static const Color device = Color(0xFF3B82F6);         // Blue
  static const Color connectivity = Color(0xFF8B5CF6);   // Purple
  static const Color storage = Color(0xFFF59E0B);        // Orange
  static const Color sensors = Color(0xFFEC4899);        // Pink
  static const Color system = Color(0xFF14B8A6);         // Teal
  static const Color location = Color(0xFFEF4444);       // Red
  static const Color audio = Color(0xFF6366F1);          // Indigo
}
```

### 2.4 Gradient Definitions

```dart
class AppGradients {
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF2563EB),
      Color(0xFF7C3AED),
    ],
  );
  
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFFFFF),
      Color(0xFFF9FAFB),
    ],
  );
  
  static const LinearGradient batteryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF10B981),
      Color(0xFF34D399),
    ],
  );
  
  static const LinearGradient shimmerGradient = LinearGradient(
    begin: Alignment(-1.0, -0.5),
    end: Alignment(1.0, 0.5),
    colors: [
      Color(0xFFE5E7EB),
      Color(0xFFF3F4F6),
      Color(0xFFE5E7EB),
    ],
  );
}
```

---

## 3. Typography

### 3.1 Font Family

```dart
// Use Google Fonts - Inter for clean, modern look
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  static String fontFamily = 'Inter';
  
  // Alternative fonts for specific use cases
  static String fontFamilyMono = 'JetBrains Mono'; // For technical data
  static String fontFamilyDisplay = 'Poppins';     // For headers
}
```

### 3.2 Text Styles

```dart
class AppTextStyles {
  // Display Styles
  static TextStyle displayLarge = GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.5,
  );
  
  static TextStyle displayMedium = GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: -0.5,
  );
  
  static TextStyle displaySmall = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );
  
  // Headline Styles
  static TextStyle headlineLarge = GoogleFonts.inter(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );
  
  static TextStyle headlineMedium = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );
  
  static TextStyle headlineSmall = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );
  
  // Title Styles
  static TextStyle titleLarge = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );
  
  static TextStyle titleMedium = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );
  
  static TextStyle titleSmall = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.5,
    letterSpacing: 0.5,
  );
  
  // Body Styles
  static TextStyle bodyLarge = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.6,
  );
  
  static TextStyle bodyMedium = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.6,
  );
  
  static TextStyle bodySmall = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );
  
  // Label Styles
  static TextStyle labelLarge = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.1,
  );
  
  static TextStyle labelMedium = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.5,
  );
  
  static TextStyle labelSmall = GoogleFonts.inter(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.5,
  );
  
  // Monospace Styles (for technical data)
  static TextStyle monoLarge = GoogleFonts.jetBrainsMono(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );
  
  static TextStyle monoMedium = GoogleFonts.jetBrainsMono(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );
  
  static TextStyle monoSmall = GoogleFonts.jetBrainsMono(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );
}
```

---

## 4. Spacing & Layout

### 4.1 Spacing System

```dart
class AppSpacing {
  // Base spacing unit: 4px
  static const double xs = 4.0;      // Extra small
  static const double sm = 8.0;      // Small
  static const double md = 12.0;     // Medium
  static const double lg = 16.0;     // Large
  static const double xl = 20.0;     // Extra large
  static const double xxl = 24.0;    // 2X large
  static const double xxxl = 32.0;   // 3X large
  static const double huge = 40.0;   // Huge
  static const double massive = 48.0; // Massive
  
  // Semantic spacing
  static const double cardPadding = 16.0;
  static const double screenPadding = 16.0;
  static const double sectionSpacing = 24.0;
  static const double listItemSpacing = 12.0;
}
```

### 4.2 Border Radius

```dart
class AppRadius {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double full = 9999.0; // Circular
  
  // Semantic radius
  static const double card = 16.0;
  static const double button = 12.0;
  static const double input = 12.0;
  static const double chip = 20.0;
}
```

### 4.3 Elevation & Shadows

```dart
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
```

### 4.4 Icon Sizes

```dart
class AppIconSize {
  static const double xs = 16.0;
  static const double sm = 20.0;
  static const double md = 24.0;
  static const double lg = 32.0;
  static const double xl = 40.0;
  static const double xxl = 48.0;
  static const double huge = 64.0;
}
```

---

## 5. Component Design

### 5.1 Card Component

```dart
// lib/presentation/widgets/app_card.dart

import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final VoidCallback? onTap;
  final bool elevated;
  final BorderRadius? borderRadius;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.color,
    this.onTap,
    this.elevated = true,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.surface,
        borderRadius: borderRadius ?? BorderRadius.circular(AppRadius.card),
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 1,
        ),
        boxShadow: elevated ? AppElevation.small : null,
      ),
      padding: padding ?? const EdgeInsets.all(AppSpacing.cardPadding),
      child: child,
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius ?? BorderRadius.circular(AppRadius.card),
          child: card,
        ),
      );
    }

    return card;
  }
}
```

### 5.2 Info Tile Component

```dart
// lib/presentation/widgets/info_tile.dart

import 'package:flutter/material.dart';

class InfoTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;
  final Color? iconColor;
  final Widget? trailing;
  final VoidCallback? onTap;

  const InfoTile({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.iconColor,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          child: Row(
            children: [
              if (icon != null) ...[
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: (iconColor ?? Theme.of(context).primaryColor)
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Icon(
                    icon,
                    size: AppIconSize.sm,
                    color: iconColor ?? Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: AppTextStyles.labelMedium.copyWith(
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      value,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                  ],
                ),
              ),
              if (trailing != null) trailing!,
              if (onTap != null && trailing == null)
                Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### 5.3 Category Card Component

```dart
// lib/presentation/widgets/category_card.dart

import 'package:flutter/material.dart';

class CategoryCard extends StatefulWidget {
  final String title;
  final String value;
  final String? subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(
              color: Theme.of(context).dividerColor,
              width: 1,
            ),
            boxShadow: AppElevation.small,
          ),
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: widget.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: Icon(
                      widget.icon,
                      size: AppIconSize.lg,
                      color: widget.color,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: AppIconSize.xs,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                widget.title,
                style: AppTextStyles.labelMedium.copyWith(
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                widget.value,
                style: AppTextStyles.headlineMedium.copyWith(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              if (widget.subtitle != null) ...[
                const SizedBox(height: AppSpacing.xs),
                Text(
                  widget.subtitle!,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
```

### 5.4 Progress Indicator Component

```dart
// lib/presentation/widgets/progress_indicator_card.dart

import 'package:flutter/material.dart';

class ProgressIndicatorCard extends StatelessWidget {
  final String label;
  final double value; // 0.0 to 1.0
  final Color color;
  final String? displayValue;
  final IconData? icon;

  const ProgressIndicatorCard({
    super.key,
    required this.label,
    required this.value,
    required this.color,
    this.displayValue,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (icon != null) ...[
                    Icon(
                      icon,
                      size: AppIconSize.sm,
                      color: color,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                  ],
                  Text(
                    label,
                    style: AppTextStyles.labelMedium.copyWith(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),
                ],
              ),
              Text(
                displayValue ?? '${(value * 100).toStringAsFixed(0)}%',
                style: AppTextStyles.titleMedium.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutCubic,
            tween: Tween<double>(begin: 0, end: value),
            builder: (context, value, _) {
              return Stack(
                children: [
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppRadius.full),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: value,
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            color,
                            color.withOpacity(0.7),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(AppRadius.full),
                        boxShadow: [
                          BoxShadow(
                            color: color.withOpacity(0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
```

### 5.5 Stat Card Component

```dart
// lib/presentation/widgets/stat_card.dart

import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final String? unit;

  const StatCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withOpacity(0.1),
            color.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: AppIconSize.lg,
            color: color,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            label,
            style: AppTextStyles.labelMedium.copyWith(
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: AppTextStyles.headlineLarge.copyWith(
                  color: color,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (unit != null) ...[
                const SizedBox(width: AppSpacing.xs),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    unit!,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
```

### 5.6 Section Header Component

```dart
// lib/presentation/widgets/section_header.dart

import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;

  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPadding,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.headlineSmall.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    subtitle!,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
```

---

## 6. Animation System

### 6.1 Animation Constants

```dart
class AppAnimations {
  // Duration
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 250);
  static const Duration slow = Duration(milliseconds: 350);
  static const Duration slower = Duration(milliseconds: 500);
  static const Duration slowest = Duration(milliseconds: 800);
  
  // Curves
  static const Curve easeIn = Curves.easeIn;
  static const Curve easeOut = Curves.easeOut;
  static const Curve easeInOut = Curves.easeInOut;
  static const Curve bounceOut = Curves.bounceOut;
  static const Curve elasticOut = Curves.elasticOut;
  
  // Custom curves
  static const Curve smooth = Curves.easeOutCubic;
  static const Curve snappy = Curves.easeOutQuart;
}
```

### 6.2 Fade In Animation

```dart
// lib/presentation/widgets/animations/fade_in.dart

import 'package:flutter/material.dart';

class FadeIn extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Curve curve;

  const FadeIn({
    super.key,
    required this.child,
    this.duration = AppAnimations.normal,
    this.delay = Duration.zero,
    this.curve = AppAnimations.smooth,
  });

  @override
  State<FadeIn> createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}
```

### 6.3 Slide In Animation

```dart
// lib/presentation/widgets/animations/slide_in.dart

import 'package:flutter/material.dart';

class SlideIn extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Offset begin;
  final Curve curve;

  const SlideIn({
    super.key,
    required this.child,
    this.duration = AppAnimations.normal,
    this.delay = Duration.zero,
    this.begin = const Offset(0, 0.1),
    this.curve = AppAnimations.smooth,
  });

  @override
  State<SlideIn> createState() => _SlideInState();
}

class _SlideInState extends State<SlideIn>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: widget.begin,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: widget.child,
      ),
    );
  }
}
```

### 6.4 Scale In Animation

```dart
// lib/presentation/widgets/animations/scale_in.dart

import 'package:flutter/material.dart';

class ScaleIn extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final double begin;
  final Curve curve;

  const ScaleIn({
    super.key,
    required this.child,
    this.duration = AppAnimations.normal,
    this.delay = Duration.zero,
    this.begin = 0.8,
    this.curve = AppAnimations.smooth,
  });

  @override
  State<ScaleIn> createState() => _ScaleInState();
}

class _ScaleInState extends State<ScaleIn>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: widget.begin,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: widget.child,
      ),
    );
  }
}
```

### 6.5 Shimmer Loading Animation

```dart
// lib/presentation/widgets/animations/shimmer.dart

import 'package:flutter/material.dart';

class Shimmer extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Color baseColor;
  final Color highlightColor;

  const Shimmer({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1500),
    this.baseColor = const Color(0xFFE5E7EB),
    this.highlightColor = const Color(0xFFF3F4F6),
  });

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment(-1.0 - _controller.value * 2, 0),
              end: Alignment(1.0 - _controller.value * 2, 0),
              colors: [
                widget.baseColor,
                widget.highlightColor,
                widget.baseColor,
              ],
              stops: const [0.0, 0.5, 1.0],
            ).createShader(bounds);
          },
          child: child,
        );
      },
    );
  }
}
```

### 6.6 Pulse Animation

```dart
// lib/presentation/widgets/animations/pulse.dart

import 'package:flutter/material.dart';

class Pulse extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double minScale;
  final double maxScale;

  const Pulse({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.minScale = 0.95,
    this.maxScale = 1.05,
  });

  @override
  State<Pulse> createState() => _PulseState();
}

class _PulseState extends State<Pulse>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: widget.minScale,
      end: widget.maxScale,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }
}
```

### 6.7 Staggered List Animation

```dart
// lib/presentation/widgets/animations/staggered_list.dart

import 'package:flutter/material.dart';

class StaggeredList extends StatelessWidget {
  final List<Widget> children;
  final Duration delay;
  final Duration duration;
  final Axis direction;

  const StaggeredList({
    super.key,
    required this.children,
    this.delay = const Duration(milliseconds: 50),
    this.duration = AppAnimations.normal,
    this.direction = Axis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        children.length,
        (index) => SlideIn(
          delay: delay * index,
          duration: duration,
          begin: direction == Axis.vertical
              ? const Offset(0, 0.1)
              : const Offset(0.1, 0),
          child: children[index],
        ),
      ),
    );
  }
}
```

### 6.8 Page Transition

```dart
// lib/utils/page_transitions.dart

import 'package:flutter/material.dart';

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;

  SlideRightRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeOutCubic;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: AppAnimations.normal,
        );
}

class FadeRoute extends PageRouteBuilder {
  final Widget page;

  FadeRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: AppAnimations.fast,
        );
}

class ScaleRoute extends PageRouteBuilder {
  final Widget page;

  ScaleRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const curve = Curves.easeOutCubic;

            var scaleTween = Tween(begin: 0.9, end: 1.0).chain(
              CurveTween(curve: curve),
            );

            var fadeTween = Tween(begin: 0.0, end: 1.0).chain(
              CurveTween(curve: curve),
            );

            return ScaleTransition(
              scale: animation.drive(scaleTween),
              child: FadeTransition(
                opacity: animation.drive(fadeTween),
                child: child,
              ),
            );
          },
          transitionDuration: AppAnimations.normal,
        );
}
```

---

## 7. Dark Mode

### 7.1 Theme Data

```dart
// lib/utils/theme_data.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    
    // Color Scheme
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.textOnPrimary,
      primaryContainer: AppColors.primaryContainer,
      secondary: AppColors.secondary,
      onSecondary: AppColors.textOnPrimary,
      secondaryContainer: AppColors.secondaryContainer,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      background: AppColors.background,
      onBackground: AppColors.textPrimary,
      error: AppColors.error,
      onError: AppColors.textOnPrimary,
    ),
    
    // Scaffold
    scaffoldBackgroundColor: AppColors.background,
    
    // AppBar
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    ),
    
    // Card
    cardTheme: CardTheme(
      color: AppColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.card),
        side: const BorderSide(
          color: AppColors.border,
          width: 1,
        ),
      ),
    ),
    
    // Divider
    dividerColor: AppColors.divider,
    dividerTheme: const DividerThemeData(
      color: AppColors.divider,
      thickness: 1,
      space: 1,
    ),
    
    // Text Theme
    textTheme: TextTheme(
      displayLarge: AppTextStyles.displayLarge,
      displayMedium: AppTextStyles.displayMedium,
      displaySmall: AppTextStyles.displaySmall,
      headlineLarge: AppTextStyles.headlineLarge,
      headlineMedium: AppTextStyles.headlineMedium,
      headlineSmall: AppTextStyles.headlineSmall,
      titleLarge: AppTextStyles.titleLarge,
      titleMedium: AppTextStyles.titleMedium,
      titleSmall: AppTextStyles.titleSmall,
      bodyLarge: AppTextStyles.bodyLarge,
      bodyMedium: AppTextStyles.bodyMedium,
      bodySmall: AppTextStyles.bodySmall,
      labelLarge: AppTextStyles.labelLarge,
      labelMedium: AppTextStyles.labelMedium,
      labelSmall: AppTextStyles.labelSmall,
    ).apply(
      bodyColor: AppColors.textPrimary,
      displayColor: AppColors.textPrimary,
    ),
    
    // Icon Theme
    iconTheme: const IconThemeData(
      color: AppColors.textSecondary,
      size: AppIconSize.md,
    ),
    
    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.md,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.button),
        ),
        textStyle: AppTextStyles.labelLarge,
      ),
    ),
    
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary, width: 1.5),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.md,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.button),
        ),
        textStyle: AppTextStyles.labelLarge,
      ),
    ),
    
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        textStyle: AppTextStyles.labelLarge,
      ),
    ),
    
    // Input Decoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceVariant,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.input),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.input),
        borderSide: const BorderSide(color: AppColors.border, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.input),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.input),
        borderSide: const BorderSide(color: AppColors.error, width: 1),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      hintStyle: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.textTertiary,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    
    // Color Scheme
    colorScheme: const ColorScheme.dark(
      primary: AppColorsDark.primary,
      onPrimary: AppColorsDark.textOnPrimary,
      primaryContainer: AppColorsDark.primaryContainer,
      secondary: AppColorsDark.secondary,
      onSecondary: AppColorsDark.textOnPrimary,
      secondaryContainer: AppColorsDark.secondaryContainer,
      surface: AppColorsDark.surface,
      onSurface: AppColorsDark.textPrimary,
      background: AppColorsDark.background,
      onBackground: AppColorsDark.textPrimary,
      error: AppColorsDark.error,
      onError: AppColorsDark.textOnPrimary,
    ),
    
    // Scaffold
    scaffoldBackgroundColor: AppColorsDark.background,
    
    // AppBar
    appBarTheme: AppBarTheme(
      backgroundColor: AppColorsDark.surface,
      foregroundColor: AppColorsDark.textPrimary,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColorsDark.textPrimary,
      ),
    ),
    
    // Card
    cardTheme: CardTheme(
      color: AppColorsDark.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.card),
        side: const BorderSide(
          color: AppColorsDark.border,
          width: 1,
        ),
      ),
    ),
    
    // Divider
    dividerColor: AppColorsDark.divider,
    dividerTheme: const DividerThemeData(
      color: AppColorsDark.divider,
      thickness: 1,
      space: 1,
    ),
    
    // Text Theme
    textTheme: TextTheme(
      displayLarge: AppTextStyles.displayLarge,
      displayMedium: AppTextStyles.displayMedium,
      displaySmall: AppTextStyles.displaySmall,
      headlineLarge: AppTextStyles.headlineLarge,
      headlineMedium: AppTextStyles.headlineMedium,
      headlineSmall: AppTextStyles.headlineSmall,
      titleLarge: AppTextStyles.titleLarge,
      titleMedium: AppTextStyles.titleMedium,
      titleSmall: AppTextStyles.titleSmall,
      bodyLarge: AppTextStyles.bodyLarge,
      bodyMedium: AppTextStyles.bodyMedium,
      bodySmall: AppTextStyles.bodySmall,
      labelLarge: AppTextStyles.labelLarge,
      labelMedium: AppTextStyles.labelMedium,
      labelSmall: AppTextStyles.labelSmall,
    ).apply(
      bodyColor: AppColorsDark.textPrimary,
      displayColor: AppColorsDark.textPrimary,
    ),
    
    // Icon Theme
    iconTheme: const IconThemeData(
      color: AppColorsDark.textSecondary,
      size: AppIconSize.md,
    ),
    
    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColorsDark.primary,
        foregroundColor: AppColorsDark.textOnPrimary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.md,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.button),
        ),
        textStyle: AppTextStyles.labelLarge,
      ),
    ),
    
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColorsDark.primary,
        side: const BorderSide(color: AppColorsDark.primary, width: 1.5),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.md,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.button),
        ),
        textStyle: AppTextStyles.labelLarge,
      ),
    ),
    
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColorsDark.primary,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        textStyle: AppTextStyles.labelLarge,
      ),
    ),
    
    // Input Decoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColorsDark.surfaceVariant,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.input),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.input),
        borderSide: const BorderSide(color: AppColorsDark.border, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.input),
        borderSide: const BorderSide(color: AppColorsDark.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.input),
        borderSide: const BorderSide(color: AppColorsDark.error, width: 1),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      hintStyle: AppTextStyles.bodyMedium.copyWith(
        color: AppColorsDark.textTertiary,
      ),
    ),
  );
}
```

### 7.2 Theme Provider (BLoC)

```dart
// lib/blocs/theme/theme_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// Events
abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ToggleTheme extends ThemeEvent {}

class SetLightTheme extends ThemeEvent {}

class SetDarkTheme extends ThemeEvent {}

// States
class ThemeState extends Equatable {
  final ThemeMode themeMode;

  const ThemeState({required this.themeMode});

  @override
  List<Object> get props => [themeMode];
}

// BLoC
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState(themeMode: ThemeMode.system)) {
    on<ToggleTheme>(_onToggleTheme);
    on<SetLightTheme>(_onSetLightTheme);
    on<SetDarkTheme>(_onSetDarkTheme);
  }

  void _onToggleTheme(ToggleTheme event, Emitter<ThemeState> emit) {
    final newMode = state.themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    emit(ThemeState(themeMode: newMode));
  }

  void _onSetLightTheme(SetLightTheme event, Emitter<ThemeState> emit) {
    emit(const ThemeState(themeMode: ThemeMode.light));
  }

  void _onSetDarkTheme(SetDarkTheme event, Emitter<ThemeState> emit) {
    emit(const ThemeState(themeMode: ThemeMode.dark));
  }
}
```

---

## 8. Implementation

### 8.1 Main App with Theme

```dart
// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/theme/theme_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Device Info',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeMode,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
```

### 8.2 Example Home Screen with Animations

```dart
// lib/presentation/screens/home_screen.dart

import 'package:flutter/material.dart';
import '../widgets/animations/fade_in.dart';
import '../widgets/animations/slide_in.dart';
import '../widgets/category_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Info'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              context.read<ThemeBloc>().add(ToggleTheme());
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Refresh logic
        },
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          children: [
            FadeIn(
              child: Text(
                'Overview',
                style: AppTextStyles.displayMedium,
              ),
            ),
            const SizedBox(height: AppSpacing.sectionSpacing),
            
            // Staggered category cards
            SlideIn(
              delay: const Duration(milliseconds: 100),
              child: CategoryCard(
                title: 'Battery',
                value: '75%',
                subtitle: 'Charging',
                icon: Icons.battery_charging_full,
                color: CategoryColors.battery,
                onTap: () {},
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            
            SlideIn(
              delay: const Duration(milliseconds: 200),
              child: CategoryCard(
                title: 'Device',
                value: 'Pixel 7',
                subtitle: 'Google',
                icon: Icons.phone_android,
                color: CategoryColors.device,
                onTap: () {},
              ),
            ),
            
            // Add more cards...
          ],
        ),
      ),
    );
  }
}
```

### 8.3 Complete File Structure

```
lib/
├── utils/
│   ├── constants.dart
│   ├── theme_data.dart
│   ├── page_transitions.dart
│   └── colors.dart
│
├── presentation/
│   ├── widgets/
│   │   ├── app_card.dart
│   │   ├── category_card.dart
│   │   ├── info_tile.dart
│   │   ├── progress_indicator_card.dart
│   │   ├── stat_card.dart
│   │   ├── section_header.dart
│   │   └── animations/
│   │       ├── fade_in.dart
│   │       ├── slide_in.dart
│   │       ├── scale_in.dart
│   │       ├── shimmer.dart
│   │       ├── pulse.dart
│   │       └── staggered_list.dart
│   │
│   └── screens/
│       └── home_screen.dart
│
└── blocs/
    └── theme/
        └── theme_bloc.dart
```

---

## Summary

This design system provides:

✅ **Centralized Color System** - Light & dark mode with semantic colors
✅ **Typography System** - Consistent text styles using Google Fonts
✅ **Spacing System** - 8px base grid for consistent layouts
✅ **Component Library** - Reusable, themed components
✅ **Animation System** - Subtle, performance-optimized animations
✅ **Dark Mode Support** - Complete theme switching capability
✅ **Accessibility** - High contrast ratios and readable fonts
✅ **Scalability** - Easy to extend and maintain

The design is modern, clean, and professional while maintaining excellent performance with smooth 60fps animations.