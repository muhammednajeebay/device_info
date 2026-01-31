import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../utils/theme_constants.dart';
import '../../utils/text_styles.dart';
import '../widgets/splash_icon.dart';
import '../widgets/page_transitions.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 3500));
    if (!mounted) return;

    Navigator.of(
      context,
    ).pushReplacement(ModernPageRoute(page: const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.spaceBackgroundStart,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Subtle tech grid background
          Opacity(
            opacity: 0.1,
            child: Image.network(
              'https://www.transparenttextures.com/patterns/carbon-fibre.png',
              repeat: ImageRepeat.repeat,
              color: AppColors.primary,
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Animation
                const SplashIcon(size: 140)
                    .animate()
                    .fadeIn(duration: 800.ms)
                    .scale(
                      begin: const Offset(0.8, 0.8),
                      curve: Curves.easeOutBack,
                      duration: 800.ms,
                    )
                    .shimmer(
                      delay: 1200.ms,
                      duration: 1500.ms,
                      color: Colors.white.withOpacity(0.3),
                    ),

                const SizedBox(height: AppSpacing.xxl),

                // Typography Animation
                Text(
                      'DEVICE INFO',
                      style: AppTextStyles.headlineLarge.copyWith(
                        letterSpacing: 8.0,
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 400.ms, duration: 600.ms)
                    .blurXY(begin: 10, end: 0, delay: 400.ms, duration: 600.ms),

                const SizedBox(height: AppSpacing.sm),

                Text(
                      'SYSTEMS INTELLIGENCE',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primary.withOpacity(0.6),
                        letterSpacing: 4.0,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 800.ms, duration: 600.ms)
                    .slideY(
                      begin: 0.5,
                      end: 0,
                      delay: 800.ms,
                      duration: 600.ms,
                    ),
              ],
            ),
          ),

          // Bottom version tag
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'v1.0.0-PRO',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary.withOpacity(0.3),
                  letterSpacing: 2.0,
                ),
              ).animate().fadeIn(delay: 1500.ms),
            ),
          ),
        ],
      ),
    );
  }
}
