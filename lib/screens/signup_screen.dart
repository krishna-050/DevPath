import 'package:dev_path/app/theme/app_color.dart';
import 'package:dev_path/screens/login_screen.dart';
import 'package:dev_path/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _rememberMe = true;
  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

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
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.055,
                ),
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
                                  color:
                                      AppColor.primary.withValues(alpha: 0.15),
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
                                'DevPath',
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
                            color:
                                AppColor.textPrimary.withValues(alpha: 0.08),
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
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
                                'Join DevPath Today',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColor.textSecondary,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 18),

                          // Full Name Field
                          TextField(
                            controller: _nameController,
                            keyboardType: TextInputType.name,
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
                          TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
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
                          TextField(
                            controller: _passwordController,
                            obscureText: _isPasswordObscured,
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
                                onPressed: () {
                                  setState(() {
                                    _isPasswordObscured = !_isPasswordObscured;
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
                          TextField(
                            controller: _confirmPasswordController,
                            obscureText: _isConfirmPasswordObscured,
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
                                onPressed: () {
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

                          // Remember Me Row
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
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      onChanged: (val) {
                                        setState(() {
                                          _rememberMe = val ?? false;
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
                                shadowColor:
                                    AppColor.primary.withValues(alpha: 0.4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              onPressed: () {
                                Get.offAll(() => const MainScreen());
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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

                          // Social Login Buttons
                          Row(
                            children: [
                              _buildSocialButton(
                                icon: Icons.g_mobiledata_rounded,
                                color: const Color(0xFFEA4335),
                                onTap: () {
                                  Get.offAll(() => const MainScreen());
                                },
                              ),
                              const SizedBox(width: 12),
                              _buildSocialButton(
                                icon: Icons.code_rounded,
                                color: AppColor.textPrimary,
                                onTap: () {
                                  Get.offAll(() => const MainScreen());
                                },
                              ),
                              const SizedBox(width: 12),
                              _buildSocialButton(
                                icon: Icons.window_rounded,
                                color: const Color(0xFF00A4EF),
                                onTap: () {
                                  Get.offAll(() => const MainScreen());
                                },
                              ),
                            ],
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
                                onTap: () {
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

  Widget _buildSocialButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          height: 44,
          decoration: BoxDecoration(
            color: AppColor.background,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColor.border,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
