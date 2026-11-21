import 'package:dev_path/app/theme/app_color.dart';
import 'package:dev_path/controller/auth_controller.dart';
import 'package:dev_path/Widgets/app_button_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final AuthController _authController = Get.put(AuthController());

  final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  bool _isLoading = false;
  bool _emailSent = false;

  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeIn);
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
        );
    _animController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _animController.dispose();
    super.dispose();
  }

  Future<void> _sendResetEmail() async {
    if (_isLoading) return;
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final success = await _authController.resetPassword(
      _emailController.text.trim(),
    );

    if (mounted) {
      setState(() {
        _isLoading = false;
        if (success) _emailSent = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

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
                    AppColor.secondary.withValues(alpha: 0.07),
                    AppColor.background,
                    AppColor.primary.withValues(alpha: 0.05),
                  ],
                ),
              ),
            ),
          ),

          // ── Decorative top-right circle ──────────────────────────────
          Positioned(
            top: -70,
            right: -70,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.secondary.withValues(alpha: 0.07),
              ),
            ),
          ),

          // ── Decorative bottom-left circle ────────────────────────────
          Positioned(
            bottom: -80,
            left: -60,
            child: Container(
              width: 230,
              height: 230,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.primary.withValues(alpha: 0.06),
              ),
            ),
          ),

          // ── Main content ─────────────────────────────────────────────
          SafeArea(
            child: Column(
              children: [
                // Back button
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, top: 8),
                    child: IconButton(
                      onPressed: () => Get.back(),
                      icon: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColor.border,
                            width: 1.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.textPrimary.withValues(
                                alpha: 0.06,
                              ),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 16,
                          color: AppColor.textPrimary,
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.055,
                    ),
                    child: FadeTransition(
                      opacity: _fadeAnim,
                      child: SlideTransition(
                        position: _slideAnim,
                        child: Column(
                          children: [
                            SizedBox(height: screenHeight * 0.04),

                            // ── Icon ──────────────────────────────────
                            Container(
                              width: screenWidth * 0.24,
                              height: screenWidth * 0.24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColor.secondary.withValues(
                                      alpha: 0.18,
                                    ),
                                    blurRadius: 24,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.lock_reset_rounded,
                                size: screenWidth * 0.11,
                                color: AppColor.secondary,
                              ),
                            ),

                            SizedBox(height: screenHeight * 0.03),

                            // ── Title ─────────────────────────────────
                            const Text(
                              'Forgot Password?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: AppColor.textPrimary,
                                letterSpacing: -0.5,
                              ),
                            ),

                            const SizedBox(height: 10),

                            const Text(
                              'No worries! Enter your registered email\nand we\'ll send you a reset link.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColor.textSecondary,
                                height: 1.55,
                              ),
                            ),

                            SizedBox(height: screenHeight * 0.045),

                            // ── Card ──────────────────────────────────
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(22),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.92),
                                borderRadius: BorderRadius.circular(28),
                                border: Border.all(
                                  color: AppColor.border.withValues(alpha: 0.8),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColor.textPrimary.withValues(
                                      alpha: 0.07,
                                    ),
                                    blurRadius: 24,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: _emailSent
                                  ? _buildSuccessState(screenWidth)
                                  : _buildFormState(screenWidth),
                            ),

                            SizedBox(height: screenHeight * 0.035),

                            // ── Back to login ─────────────────────────
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: const Text.rich(
                                TextSpan(
                                  text: 'Remember your password? ',
                                  style: TextStyle(
                                    color: AppColor.textSecondary,
                                    fontSize: 13,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Back to Login',
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
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Form state (before sending) ──────────────────────────────────────
  Widget _buildFormState(double screenWidth) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Column(
              children: [
                Text(
                  'Reset Your Password',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColor.textPrimary,
                    letterSpacing: -0.3,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Enter the email linked to your account',
                  style: TextStyle(fontSize: 13, color: AppColor.textSecondary),
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),

          // Email field label
          const Text(
            'Email Address',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColor.textPrimary,
            ),
          ),

          const SizedBox(height: 8),

          // Email text field
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(fontSize: 14, color: AppColor.textPrimary),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your email address';
              }
              if (!emailRegex.hasMatch(value.trim())) {
                return 'Please enter a valid email address';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: 'your@email.com',
              hintStyle: const TextStyle(
                color: AppColor.textSecondary,
                fontSize: 14,
              ),
              prefixIcon: const Icon(
                Icons.mail_outline_rounded,
                color: AppColor.secondary,
                size: 20,
              ),
              filled: true,
              fillColor: AppColor.background,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 16,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: AppColor.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: AppColor.secondary,
                  width: 1.5,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: AppColor.error, width: 1.2),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: AppColor.error, width: 1.5),
              ),
            ),
          ),

          const SizedBox(height: 22),

          // Send button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primary,
                foregroundColor: Colors.white,
                elevation: 4,
                shadowColor: AppColor.primary.withValues(alpha: 0.35),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: _isLoading ? null : _sendResetEmail,
              child: _isLoading
                  ? const AppButtonLoader()
                  : const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.send_rounded, size: 18),
                        SizedBox(width: 10),
                        Text(
                          'Send Reset Link',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Success state (after email sent) ─────────────────────────────────
  Widget _buildSuccessState(double screenWidth) {
    return Column(
      children: [
        // Success icon
        Container(
          width: 68,
          height: 68,
          decoration: BoxDecoration(
            color: AppColor.success.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check_circle_outline_rounded,
            color: AppColor.success,
            size: 36,
          ),
        ),

        const SizedBox(height: 16),

        const Text(
          'Email Sent!',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColor.textPrimary,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          'A password reset link has been sent to',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13, color: AppColor.textSecondary),
        ),

        const SizedBox(height: 6),

        // Email chip
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
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
                size: 14,
                color: AppColor.secondary,
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  _emailController.text.trim(),
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

        const SizedBox(height: 20),

        // Info tip
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColor.lightBlue,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColor.secondary.withValues(alpha: 0.2),
            ),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: 16,
                color: AppColor.secondary,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Check your spam folder if you don\'t see the email in your inbox.',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColor.textSecondary,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Resend option
        GestureDetector(
          onTap: () async {
            setState(() {
              _emailSent = false;
            });

            await _sendResetEmail();
          },
          child: const Text.rich(
            TextSpan(
              text: 'Didn\'t receive it? ',
              style: TextStyle(color: AppColor.textSecondary, fontSize: 13),
              children: [
                TextSpan(
                  text: 'Resend Email',
                  style: TextStyle(
                    color: AppColor.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 4),
      ],
    );
  }
}
