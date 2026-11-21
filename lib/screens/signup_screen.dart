import 'package:dev_path/Widgets/app_snackbar.dart';
import 'package:dev_path/app/theme/app_color.dart';
import 'package:dev_path/controller/auth_controller.dart';
import 'package:dev_path/screens/login_screen.dart';
import 'package:dev_path/screens/main_screen.dart';
import 'package:dev_path/screens/verify_email_screen.dart';
import 'package:dev_path/Widgets/app_button_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final AuthController authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  bool _isTermsAccepted = false;
  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;
  bool _isSignupLoading = false;
  bool _isGoogleLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    if (_isSignupLoading || _isGoogleLoading) return;

    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    if (!_isTermsAccepted) {
      AppSnackBar.show(
        title: 'Terms Required',
        message: 'Please accept Terms & Conditions',
        type: SnackBarType.warning,
      );
      return;
    }

    setState(() => _isSignupLoading = true);
    try {
      final success = await authController.signUp(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (success && mounted) {
        Get.to(() => VerifyEmailScreen());
      }
    } finally {
      if (mounted) setState(() => _isSignupLoading = false);
    }
  }

  Future<void> _handleGoogleSignIn() async {
    if (_isSignupLoading || _isGoogleLoading) return;

    setState(() => _isGoogleLoading = true);
    try {
      final success = await authController.signInWithGoogle();
      if (success && mounted) {
        Get.offAll(() => const MainScreen());
      }
    } on GoogleSignInException catch (e) {
      if (e.code != GoogleSignInExceptionCode.canceled) {
        debugPrint('GOOGLE SIGN-IN ERROR: ${e.code}');
        AppSnackBar.show(
          title: 'Google Sign-In Failed',
          message: 'Unable to sign in with Google.',
          type: SnackBarType.error,
        );
      }
    } finally {
      if (mounted) setState(() => _isGoogleLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    final bool anyLoading = _isSignupLoading || _isGoogleLoading;

    return Scaffold(
      backgroundColor: AppColor.background,
      body: Stack(
        children: [
          // 1. Fixed Full-Screen Background Image inside Stack
          Positioned(
            child: SizedBox(
              height: screenHeight,
              width: screenWidth,
              child: Image.asset(
                'assets/project_Image/signup_screen.png',
                fit: BoxFit.cover,
                alignment: Alignment.center,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  'assets/project_Image/signup_screen.png',
                  fit: BoxFit.cover,
                  width: screenWidth,
                  height: screenHeight,
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),

          // 2. Overlaid UI Content inside Stack
          SafeArea(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.055),
                child: Column(
                  children: [
                    SizedBox(height: screenHeight * 0.015),

                    // Top Branding Header (Logo + Title + Tagline)
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // App Logo Container
                          Container(
                            width: screenWidth * 0.21,
                            height: screenWidth * 0.21,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColor.border.withValues(alpha: 0.8),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.primary.withValues(
                                    alpha: 0.15,
                                  ),
                                  blurRadius: 18,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Image.asset(
                              'assets/images/app_icon.png',
                              fit: BoxFit.contain,
                            ),
                          ),

                          SizedBox(height: screenHeight * 0.012),

                          // App Title
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Learning Path',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.1,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.textPrimary,
                                  letterSpacing: -0.6,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 4),

                          // Tagline
                          const Text(
                            'Create your account and\nstart your learning journey',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColor.textSecondary,
                              height: 1.3,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.02),

                    // Floating Card Container (Overlaid inside Stack)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: AppColor.border.withValues(alpha: 0.8),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.textPrimary.withValues(alpha: 0.08),
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Card Title & Subtitle
                            const Column(
                              children: [
                                Text(
                                  'Create Account',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.textPrimary,
                                    letterSpacing: -0.3,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Join Learning Path Today',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: AppColor.textSecondary,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 18),

                            // Full Name Field
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Enter your full name';
                                }
                                if (value.trim().length < 3) {
                                  return 'Name must be at least 3 characters';
                                }
                                return null;
                              },
                              controller: _nameController,
                              keyboardType: TextInputType.name,
                              enabled: !anyLoading,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColor.textPrimary,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Full Name',
                                hintStyle: const TextStyle(
                                  color: AppColor.textSecondary,
                                  fontSize: 14,
                                ),
                                prefixIcon: const Icon(
                                  Icons.person_outline_rounded,
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
                                  borderSide: const BorderSide(
                                    color: AppColor.border,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                    color: AppColor.secondary,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 14),

                            // Email Field
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter your email address';
                                }
                                if (!emailRegex.hasMatch(value.trim())) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              enabled: !anyLoading,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColor.textPrimary,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Email Address',
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
                                  borderSide: const BorderSide(
                                    color: AppColor.border,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                    color: AppColor.secondary,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 14),

                            // Password Field
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'please enter your password';
                                }
                                if (value.trim().length < 8) {
                                  return 'password must be at least 8 characters';
                                }
                                return null;
                              },
                              controller: _passwordController,
                              obscureText: _isPasswordObscured,
                              enabled: !anyLoading,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColor.textPrimary,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: const TextStyle(
                                  color: AppColor.textSecondary,
                                  fontSize: 14,
                                ),
                                prefixIcon: const Icon(
                                  Icons.lock_outline_rounded,
                                  color: AppColor.secondary,
                                  size: 20,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordObscured
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: AppColor.textSecondary,
                                    size: 20,
                                  ),
                                  onPressed: anyLoading
                                      ? null
                                      : () {
                                          setState(() {
                                            _isPasswordObscured =
                                                !_isPasswordObscured;
                                          });
                                        },
                                ),
                                filled: true,
                                fillColor: AppColor.background,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 16,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                    color: AppColor.border,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                    color: AppColor.secondary,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 14),

                            // Confirm Password Field
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please confirm your password';
                                }
                                if (value.trim() !=
                                    _passwordController.text.trim()) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                              controller: _confirmPasswordController,
                              obscureText: _isConfirmPasswordObscured,
                              enabled: !anyLoading,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColor.textPrimary,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Confirm Password',
                                hintStyle: const TextStyle(
                                  color: AppColor.textSecondary,
                                  fontSize: 14,
                                ),
                                prefixIcon: const Icon(
                                  Icons.lock_outline_rounded,
                                  color: AppColor.secondary,
                                  size: 20,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isConfirmPasswordObscured
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: AppColor.textSecondary,
                                    size: 20,
                                  ),
                                  onPressed: anyLoading
                                      ? null
                                      : () {
                                          setState(() {
                                            _isConfirmPasswordObscured =
                                                !_isConfirmPasswordObscured;
                                          });
                                        },
                                ),
                                filled: true,
                                fillColor: AppColor.background,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 16,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                    color: AppColor.border,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                    color: AppColor.secondary,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),

                            // Terms & Conditions Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: Checkbox(
                                        value: _isTermsAccepted,
                                        activeColor: AppColor.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        onChanged: anyLoading
                                            ? null
                                            : (val) {
                                                setState(() {
                                                  _isTermsAccepted =
                                                      val ?? false;
                                                });
                                              },
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'I agree to Terms & Conditions',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: AppColor.textSecondary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(height: 18),

                            // Sign Up CTA Button
                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.primary,
                                  foregroundColor: Colors.white,
                                  elevation: 4,
                                  shadowColor: AppColor.primary.withValues(
                                    alpha: 0.4,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                onPressed: anyLoading ? null : _handleSignup,
                                child: _isSignupLoading
                                    ? const AppButtonLoader()
                                    : const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Sign Up',
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.3,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Icon(
                                            Icons.arrow_forward_rounded,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                              ),
                            ),

                            const SizedBox(height: 18),

                            // Or Continue With Divider
                            const Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: AppColor.border,
                                    thickness: 1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Text(
                                    'Or Sign up with',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColor.textSecondary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: AppColor.border,
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 14),

                            // Google Sign-In Button
                            _buildGoogleButton(
                              label: 'Sign up with Google',
                              isLoading: _isGoogleLoading,
                              onTap: anyLoading ? null : _handleGoogleSignIn,
                            ),

                            const SizedBox(height: 18),

                            // Already have an account? Login Link
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Already have an account? ',
                                  style: TextStyle(
                                    color: AppColor.textSecondary,
                                    fontSize: 13,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: anyLoading
                                      ? null
                                      : () {
                                          Get.offAll(() => const LoginScreen());
                                        },
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                      color: AppColor.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.03),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoogleButton({
    required String label,
    required bool isLoading,
    required VoidCallback? onTap,
  }) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.border, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: AppColor.textPrimary.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Center(
            child: isLoading
                ? const AppButtonLoader(
                    size: 20,
                    color: AppColor.secondary,
                    strokeWidth: 2.2,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/google.webp',
                        width: 22,
                        height: 22,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                              Icons.g_mobiledata_rounded,
                              size: 24,
                              color: AppColor.secondary,
                            ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        label,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColor.textPrimary,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
