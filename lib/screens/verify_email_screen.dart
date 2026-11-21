import 'dart:async';

import 'package:dev_path/Widgets/app_snackbar.dart';
import 'package:dev_path/app/theme/app_color.dart';
import 'package:dev_path/controller/auth_controller.dart';
import 'package:dev_path/screens/login_screen.dart';
import 'package:dev_path/screens/main_screen.dart';
import 'package:dev_path/Widgets/app_button_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dev_path/screens/signup_screen.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen>
    with SingleTickerProviderStateMixin {
  final AuthController _authController = Get.put(AuthController());
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Timer? _checkTimer;
  Timer? _resendCooldownTimer;

  bool _isResendLoading = false;
  bool _isCheckingVerification = false;
  int _resendCooldown = 0;

  late AnimationController _animController;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();

    // Setup animations
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _scaleAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.elasticOut,
    );

    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeIn);

    _animController.forward();

    // Auto-check email verification every 4 seconds
    _checkTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      _checkEmailVerified();
    });
  }

  @override
  void dispose() {
    _checkTimer?.cancel();
    _resendCooldownTimer?.cancel();
    _animController.dispose();
    super.dispose();
  }

  Future<void> _checkEmailVerified() async {
    if (_isCheckingVerification) return;

    setState(() => _isCheckingVerification = true);

    try {
      final currentUser = _auth.currentUser;

      if (currentUser == null) {
        AppSnackBar.show(
          title: 'Session Expired',
          message: 'Please sign up again.',
          type: SnackBarType.warning,
        );
        Get.offAll(() => const LoginScreen());
        return;
      }

      await currentUser.reload();

      final user = _auth.currentUser;

      if (user != null && user.emailVerified) {
        _checkTimer?.cancel();

        AppSnackBar.show(
          title: '🎉 Email Verified!',
          message: 'Welcome to Learning Path. Happy learning!',
          type: SnackBarType.success,
        );

        await Future.delayed(const Duration(milliseconds: 400));

        if (!mounted) return;

        Get.offAll(() => const MainScreen());
      }
    } catch (e) {
      debugPrint('Verification check error: $e');
    } finally {
      if (mounted) {
        setState(() => _isCheckingVerification = false);
      }
    }
  }

  Future<void> _resendVerificationEmail() async {
    if (_resendCooldown > 0 || _isResendLoading) return;

    setState(() => _isResendLoading = true);

    try {
      await _auth.currentUser?.sendEmailVerification();

      AppSnackBar.show(
        title: 'Email Sent ✉️',
        message: 'Verification email sent. Please check your inbox.',
        type: SnackBarType.success,
      );

      // Start 60s cooldown
      setState(() => _resendCooldown = 60);
      _resendCooldownTimer = Timer.periodic(const Duration(seconds: 1), (
        timer,
      ) {
        if (!mounted) {
          timer.cancel();
          return;
        }
        setState(() {
          if (_resendCooldown > 0) {
            _resendCooldown--;
          } else {
            timer.cancel();
          }
        });
      });
    } on FirebaseAuthException catch (e) {
      String message = 'Could not resend email. Please try again.';
      if (e.code == 'too-many-requests') {
        message = 'Too many requests. Please wait a while.';
      }
      AppSnackBar.show(
        title: 'Resend Failed',
        message: message,
        type: SnackBarType.error,
      );
    } finally {
      if (mounted) setState(() => _isResendLoading = false);
    }
  }

  Future<void> _logout() async {
    _checkTimer?.cancel();

    final deleted = await _authController.deleteUnverifiedAccount();

    if (deleted) {
      Get.offAll(() => const SignupScreen());
    } else {
      // Account delete nahi hua, verification checking resume karo.
      _checkTimer = Timer.periodic(
        const Duration(seconds: 4),
        (_) => _checkEmailVerified(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;
    final userEmail = _auth.currentUser?.email ?? 'your email';

    return Scaffold(
      backgroundColor: AppColor.background,
      body: Stack(
        children: [
          // ── Background gradient ──────────────────────────────────────
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColor.secondary.withValues(alpha: 0.08),
                    AppColor.background,
                    AppColor.primary.withValues(alpha: 0.06),
                  ],
                ),
              ),
            ),
          ),

          // ── Decorative top-right circle ──────────────────────────────
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.secondary.withValues(alpha: 0.08),
              ),
            ),
          ),

          // ── Decorative bottom-left circle ────────────────────────────
          Positioned(
            bottom: -80,
            left: -60,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.primary.withValues(alpha: 0.07),
              ),
            ),
          ),

          // ── Main content ─────────────────────────────────────────────
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.06),

                  // ── Animated email icon ────────────────────────────
                  ScaleTransition(
                    scale: _scaleAnim,
                    child: FadeTransition(
                      opacity: _fadeAnim,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Outer glow ring
                          Container(
                            width: screenWidth * 0.38,
                            height: screenWidth * 0.38,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.secondary.withValues(alpha: 0.1),
                            ),
                          ),
                          // Inner icon container
                          Container(
                            width: screenWidth * 0.28,
                            height: screenWidth * 0.28,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.secondary.withValues(
                                    alpha: 0.2,
                                  ),
                                  blurRadius: 24,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.mark_email_unread_rounded,
                              size: screenWidth * 0.13,
                              color: AppColor.secondary,
                            ),
                          ),

                          // Top-right badge dot
                          Positioned(
                            top: screenWidth * 0.02,
                            right: screenWidth * 0.04,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: AppColor.primary,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.5,
                                ),
                              ),
                              child: const Icon(
                                Icons.priority_high_rounded,
                                size: 10,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  // ── Title ──────────────────────────────────────────
                  FadeTransition(
                    opacity: _fadeAnim,
                    child: const Text(
                      'Verify Your Email',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: AppColor.textPrimary,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // ── Subtitle ───────────────────────────────────────
                  FadeTransition(
                    opacity: _fadeAnim,
                    child: const Text(
                      'We\'ve sent a verification link to',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColor.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 6),

                  // ── Email chip ─────────────────────────────────────
                  FadeTransition(
                    opacity: _fadeAnim,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.secondary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: AppColor.secondary.withValues(alpha: 0.25),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.email_outlined,
                            size: 15,
                            color: AppColor.secondary,
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              userEmail,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppColor.secondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  // ── Info card ──────────────────────────────────────
                  FadeTransition(
                    opacity: _fadeAnim,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.92),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: AppColor.border.withValues(alpha: 0.8),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.textPrimary.withValues(alpha: 0.07),
                            blurRadius: 20,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildStep(
                            icon: Icons.inbox_rounded,
                            title: 'Check your inbox',
                            subtitle: 'Open the email we just sent you',
                            color: AppColor.secondary,
                          ),
                          _buildDivider(),
                          _buildStep(
                            icon: Icons.touch_app_rounded,
                            title: 'Click the link',
                            subtitle: 'Tap "Verify Email" in the message',
                            color: AppColor.primary,
                          ),
                          _buildDivider(),
                          _buildStep(
                            icon: Icons.check_circle_outline_rounded,
                            title: 'You\'re all set!',
                            subtitle:
                                'App will unlock automatically once verified',
                            color: AppColor.success,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.03),

                  // ── Auto-check status indicator ────────────────────
                  FadeTransition(
                    opacity: _fadeAnim,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.success.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: AppColor.success.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _isCheckingVerification
                              ? SizedBox(
                                  width: 14,
                                  height: 14,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColor.success,
                                  ),
                                )
                              : const Icon(
                                  Icons.sync_rounded,
                                  size: 15,
                                  color: AppColor.success,
                                ),
                          const SizedBox(width: 8),
                          const Text(
                            'Auto-checking for verification…',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColor.success,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.03),

                  // ── Resend button ──────────────────────────────────
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.secondary,
                        foregroundColor: Colors.white,
                        elevation: 4,
                        shadowColor: AppColor.secondary.withValues(alpha: 0.35),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: _resendCooldown > 0 || _isResendLoading
                          ? null
                          : _resendVerificationEmail,
                      child: _isResendLoading
                          ? const AppButtonLoader(color: Colors.white)
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.send_rounded, size: 18),
                                const SizedBox(width: 10),
                                Text(
                                  _resendCooldown > 0
                                      ? 'Resend in ${_resendCooldown}s'
                                      : 'Resend Verification Email',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // ── Manual check button ────────────────────────────
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColor.textPrimary,
                        side: const BorderSide(
                          color: AppColor.border,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: _isCheckingVerification
                          ? null
                          : _checkEmailVerified,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.verified_user_outlined, size: 18),
                          SizedBox(width: 10),
                          Text(
                            'I\'ve Verified, Continue',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.03),

                  // ── Back to login link ─────────────────────────────
                  GestureDetector(
                    onTap: _logout,
                    child: const Text.rich(
                      TextSpan(
                        text: 'Wrong email? ',
                        style: TextStyle(
                          color: AppColor.textSecondary,
                          fontSize: 13,
                        ),
                        children: [
                          TextSpan(
                            text: 'Back to Sign Up',
                            style: TextStyle(
                              color: AppColor.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.04),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Helpers ──────────────────────────────────────────────────────────

  Widget _buildStep({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 20, color: color),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColor.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColor.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(color: AppColor.border, thickness: 1, height: 1);
  }
}
