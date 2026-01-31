import 'package:flutter/material.dart';
import '../../utils/theme_constants.dart';

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
    this.elevated = false, // Default to flat for iOS look
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final card = Container(
      decoration: BoxDecoration(
        color: color ?? (isDark ? const Color(0xFF1C1C1E) : Colors.white),
        borderRadius: borderRadius ?? BorderRadius.circular(AppRadius.card),
        boxShadow: elevated
            ? [
                BoxShadow(
                  color: Colors.black.withAlpha(isDark ? 50 : 20),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      padding: padding ?? const EdgeInsets.all(AppSpacing.cardPadding),
      clipBehavior: Clip.antiAlias,
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
