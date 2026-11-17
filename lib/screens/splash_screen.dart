import 'dart:async';
import 'package:dev_path/app/theme/app_color.dart';
import 'package:dev_path/screens/main_screen.dart';
import 'package:dev_path/screens/started_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _pulseController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // 1. Logo Scale & Fade Animation Controller
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: Curves.easeOutBack,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    // 2. Pulse / Glow Loop Animation Controller
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    _logoController.forward();

    // 3. Auto Navigation after 2.8 seconds
    Timer(const Duration(milliseconds: 2800), _navigateToNextScreen);
  }

  void _navigateToNextScreen() {
    if (!mounted) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Get.offAll(
        () => const MainScreen(),
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 600),
      );
    } else {
      Get.offAll(
        () => const StartedScreen(),
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 600),
      );
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;

    final textPrimaryColor = isDark ? Colors.white : const Color(0xFF102B50);
    final textSecondaryColor =
        isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);

    return Scaffold(
      body: Stack(
        children: [
          // 1. Ambient Background Gradient & Shapes
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? [
                          const Color(0xFF070D18),
                          const Color(0xFF0B1426),
                          const Color(0xFF111E38),
                        ]
                      : [
                          const Color(0xFFF7FAFD),
                          const Color(0xFFEDF4FD),
                          const Color(0xFFE4F0FD),
                        ],
                ),
              ),
            ),
          ),

          // 2. Soft Ambient Radial Glow Behind Logo
          Positioned(
            top: MediaQuery.of(context).size.height * 0.28,
            left: (screenWidth - 280) / 2,
            child: AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                final pulseValue = _pulseController.value;
                return Container(
                  width: 280,
                  height: 280,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF0072FF).withValues(
                          alpha: isDark
                              ? 0.18 + (pulseValue * 0.1)
                              : 0.12 + (pulseValue * 0.08),
                        ),
                        const Color(0xFF00C6FF).withValues(
                          alpha: isDark
                              ? 0.08 + (pulseValue * 0.05)
                              : 0.04 + (pulseValue * 0.04),
                        ),
                        Colors.transparent,
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // 3. Main Center Content (Logo, Name, Tagline)
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 10),

                // Center Branding Block
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Animated Logo Container
                      ScaleTransition(
                        scale: _scaleAnimation,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: AnimatedBuilder(
                            animation: _pulseController,
                            builder: (context, child) {
                              final glowScale = _pulseController.value * 6;
                              return Container(
                                width: 96,
                                height: 96,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? const Color(0xFF1E293B)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(26),
                                  border: Border.all(
                                    color: isDark
                                        ? const Color(0xFF334155)
                                        : const Color(0xFFBFDBFE)
                                            .withValues(alpha: 0.6),
                                    width: 1.5,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF0072FF)
                                          .withValues(alpha: 0.25),
                                      blurRadius: 20 + glowScale,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: Image.asset(
                                  'assets/images/app_icon.png',
                                  fit: BoxFit.contain,
                                  errorBuilder:
                                      (context, error, stackTrace) =>
                                          const Icon(
                                    Icons.alt_route_rounded,
                                    size: 48,
                                    color: AppColor.secondary,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 22),

                      // App Name Text with Slide & Fade
                      SlideTransition(
                        position: _slideAnimation,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Column(
                            children: [
                              Text(
                                'Learning Path',
                                style: TextStyle(
                                  fontSize: 34,
                                  fontWeight: FontWeight.w900,
                                  color: textPrimaryColor,
                                  letterSpacing: -0.6,
                                ),
                              ),
                              const SizedBox(height: 8),

                              // Subtitle / Tagline
                              Text(
                                'Learn Skills • Build Projects • Master Tech',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: textSecondaryColor,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Bottom Loading Dots & Version Information
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Smooth Loading Dots Indicator
                      _buildBouncingDots(),
                      const SizedBox(height: 16),

                      // Version & Attribution Tag
                      Text(
                        'v1.0.0 • Empowering Developers Worldwide',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: textSecondaryColor.withValues(alpha: 0.7),
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBouncingDots() {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        final val = _pulseController.value;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _dot(const Color(0xFF00C6FF), (val).clamp(0.4, 1.0)),
            const SizedBox(width: 6),
            _dot(const Color(0xFF0072FF), (1.0 - val).clamp(0.4, 1.0)),
            const SizedBox(width: 6),
            _dot(const Color(0xFFF97316), (val).clamp(0.4, 1.0)),
          ],
        );
      },
    );
  }

  Widget _dot(Color color, double scale) {
    return Transform.scale(
      scale: scale,
      child: Container(
        width: 7,
        height: 7,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
