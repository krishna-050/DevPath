import 'package:dev_path/app/theme/app_color.dart';
import 'package:dev_path/controller/auth_controller.dart';
import 'package:dev_path/screens/forgot_password_screen.dart';
import 'package:dev_path/screens/main_screen.dart';
import 'package:dev_path/screens/signup_screen.dart';
import 'package:dev_path/Widgets/app_button_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  bool _rememberMe = true;
  bool _isPasswordObscured = true;
  bool _isLoginLoading = false;
  bool _isGoogleLoading = false;
  final AuthController authController = Get.put(AuthController());

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_isLoginLoading || _isGoogleLoading) return;
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoginLoading = true);
    try {
      final success = await authController.login(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (success && mounted) {
        Get.offAll(() => const MainScreen());
      }
    } finally {
      if (mounted) setState(() => _isLoginLoading = false);
    }
  }

  Future<void> _handleGoogleSignIn() async {
    if (_isLoginLoading || _isGoogleLoading) return;

    setState(() => _isGoogleLoading = true);
    try {
      final success = await authController.signInWithGoogle();
      if (success && mounted) {
        Get.offAll(() => const MainScreen());
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

    final bool anyLoading = _isLoginLoading || _isGoogleLoading;

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
                'assets/project_Image/login_screen.png',
                fit: BoxFit.cover,
                alignment: Alignment.center,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  'assets/project_Image/login.png',
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
              physics: const BouncingScrollPhysics(),
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
                          Text(
                            'Learning Path',
                            style: TextStyle(
                              fontSize: screenWidth * 0.1,
                              fontWeight: FontWeight.bold,
                              color: AppColor.textPrimary,
                              letterSpacing: -0.6,
                            ),
                          ),

                          const SizedBox(height: 4),

                          // Tagline
                          const Text(
                            'Learn skills. Build projects.\nGrow your career.',
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

                    SizedBox(height: screenHeight * 0.14),

                    // Floating Login Card Container (Overlaid inside Stack)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.90),
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
                            const Center(
                              child: Column(
                                children: [
                                  Text(
                                    'Login to Your Account',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.textPrimary,
                                      letterSpacing: -0.3,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Welcome back! Please login to continue',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AppColor.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 18),

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
                                  return 'Please enter your password';
                                }
                                if (value.trim().length < 8) {
                                  return 'Password must be at least 8 characters';
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

                            const SizedBox(height: 10),

                            // Remember Me & Forgot Password
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: Checkbox(
                                        value: _rememberMe,
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
                                                  _rememberMe = val ?? false;
                                                });
                                              },
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'Remember me',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: AppColor.textSecondary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: anyLoading
                                      ? null
                                      : () {
                                          Get.to(
                                            () => const ForgotPasswordScreen(),
                                          );
                                        },
                                  child: const Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 18),

                            // Login CTA Button
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
                                onPressed: anyLoading ? null : _handleLogin,
                                child: _isLoginLoading
                                    ? const AppButtonLoader()
                                    : const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Login',
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
                                    'Or continue with',
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
                              label: 'Continue with Google',
                              isLoading: _isGoogleLoading,
                              onTap: anyLoading ? null : _handleGoogleSignIn,
                            ),

                            const SizedBox(height: 18),

                            // Sign Up Link
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have an account? ",
                                  style: TextStyle(
                                    color: AppColor.textSecondary,
                                    fontSize: 13,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: anyLoading
                                      ? null
                                      : () {
                                          Get.offAll(
                                            () => const SignupScreen(),
                                          );
                                        },
                                  child: const Text(
                                    'Sign Up',
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
