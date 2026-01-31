import 'package:flutter/material.dart';
import '../../utils/theme_constants.dart';
import '../../utils/text_styles.dart';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          child: Row(
            children: [
              if (icon != null) ...[
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: iconColor ?? AppColors.primary,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Icon(icon, size: 20, color: Colors.white),
                ),
                const SizedBox(width: AppSpacing.lg),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              if (value.isNotEmpty)
                Text(
                  value,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: isDark
                        ? const Color(0xFFEBEBF5).withAlpha(153)
                        : const Color(0xFF3C3C43).withAlpha(153),
                  ),
                ),
              if (trailing != null) ...[
                const SizedBox(width: AppSpacing.sm),
                trailing!,
              ],
              if (onTap != null && trailing == null) ...[
                const SizedBox(width: AppSpacing.sm),
                Icon(
                  Icons.chevron_right,
                  size: 20,
                  color: isDark
                      ? const Color(0xFFEBEBF5).withAlpha(76)
                      : const Color(0xFF3C3C43).withAlpha(76),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
