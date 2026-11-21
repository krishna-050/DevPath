import 'package:dev_path/app/theme/app_color.dart';
import 'package:flutter/material.dart';

/// A full-screen semi-transparent overlay with an animated loader.
/// Use this only when the entire screen must be blocked (e.g., initial
/// auth session check or a critical async operation before navigation).
///
/// Usage:
///   Stack(children: [
///     ...yourContent,
///     if (_isLoading) const AppFullScreenLoader(),
///   ])
class AppFullScreenLoader extends StatefulWidget {
  /// Optional label shown below the spinner.
  final String? label;

  const AppFullScreenLoader({super.key, this.label});

  @override
  State<AppFullScreenLoader> createState() => _AppFullScreenLoaderState();
}

class _AppFullScreenLoaderState extends State<AppFullScreenLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _pulseAnim = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: AbsorbPointer(
        // Block all taps on content below
        absorbing: true,
        child: Container(
          color: Colors.black.withValues(alpha: 0.38),
          child: Center(
            child: AnimatedBuilder(
              animation: _pulseAnim,
              builder: (_, child) =>
                  Transform.scale(scale: _pulseAnim.value, child: child),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 36,
                  vertical: 28,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.textPrimary.withValues(alpha: 0.12),
                      blurRadius: 32,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Spinner with two-tone ring effect
                    SizedBox(
                      width: 48,
                      height: 48,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Outer subtle track ring
                          CircularProgressIndicator(
                            value: 1.0,
                            strokeWidth: 4,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColor.primary.withValues(alpha: 0.12),
                            ),
                          ),
                          // Animated arc
                          const CircularProgressIndicator(
                            strokeWidth: 4,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColor.primary,
                            ),
                          ),
                          // Center dot
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: AppColor.primary.withValues(alpha: 0.25),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ),

                    if (widget.label != null) ...[
                      const SizedBox(height: 16),
                      Text(
                        widget.label!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColor.textSecondary,
                          letterSpacing: 0.1,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
