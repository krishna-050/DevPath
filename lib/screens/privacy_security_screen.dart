import 'package:dev_path/Widgets/app_button_loader.dart';
import 'package:dev_path/Widgets/app_snackbar.dart';
import 'package:dev_path/app/theme/app_color.dart';
import 'package:dev_path/controller/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacySecurityScreen extends StatefulWidget {
  const PrivacySecurityScreen({super.key});

  @override
  State<PrivacySecurityScreen> createState() => _PrivacySecurityScreenState();
}

class _PrivacySecurityScreenState extends State<PrivacySecurityScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isPasswordAuth = false;
  String _providerName = '';
  String _email = '';

  @override
  void initState() {
    super.initState();
    _checkAuthProvider();
  }

  void _checkAuthProvider() {
    final user = _auth.currentUser;
    _email = user?.email ?? '';

    final providers =
        user?.providerData.map((p) => p.providerId).toList() ?? [];

    if (providers.contains('password')) {
      _isPasswordAuth = true;
      _providerName = 'Email & Password';
    } else if (providers.contains('google.com')) {
      _isPasswordAuth = false;
      _providerName = 'Google Account';
    } else {
      _isPasswordAuth = false;
      _providerName = 'External Provider';
    }
  }

  // ── Change Password Modal Sheet ───────────────────────────────────────
  void _showChangePasswordSheet(BuildContext context, bool isDark) async {
    final surfaceColor = isDark ? const Color(0xFF172235) : AppColor.surface;
    final textPrimaryColor = isDark ? Colors.white : AppColor.textPrimary;
    final textSecondaryColor = isDark
        ? const Color(0xFF94A3B8)
        : AppColor.textSecondary;
    final borderColor = isDark ? const Color(0xFF334155) : AppColor.border;
    final inputBgColor = isDark ? const Color(0xFF0B1220) : AppColor.background;

    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    final formKey = GlobalKey<FormState>();
    final isSaving = ValueNotifier<bool>(false);

    bool obscureCurrent = true;
    bool obscureNew = true;
    bool obscureConfirm = true;

    try {
      await Get.bottomSheet(
        StatefulBuilder(
          builder: (context, setSheetState) {
            return Container(
              padding: EdgeInsets.fromLTRB(
                20,
                16,
                20,
                MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 20,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 44,
                          height: 4,
                          decoration: BoxDecoration(
                            color: borderColor,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Text(
                          'Change Password',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textPrimaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Center(
                        child: Text(
                          'Update your password for better account security',
                          style: TextStyle(
                            fontSize: 12,
                            color: textSecondaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Current Password
                      Text(
                        'Current Password',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: textPrimaryColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: currentPasswordController,
                        obscureText: obscureCurrent,
                        style: TextStyle(fontSize: 14, color: textPrimaryColor),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter current password';
                          }
                          if (value.trim().length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter current password',
                          hintStyle: TextStyle(
                            color: textSecondaryColor,
                            fontSize: 14,
                          ),
                          prefixIcon: const Icon(
                            Icons.lock_outline_rounded,
                            color: AppColor.secondary,
                            size: 20,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscureCurrent
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: textSecondaryColor,
                              size: 20,
                            ),
                            onPressed: () {
                              setSheetState(() {
                                obscureCurrent = !obscureCurrent;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: inputBgColor,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 16,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: borderColor),
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

                      // New Password
                      Text(
                        'New Password',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: textPrimaryColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: newPasswordController,
                        obscureText: obscureNew,
                        style: TextStyle(fontSize: 14, color: textPrimaryColor),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter new password';
                          }
                          if (value.trim().length < 8) {
                            return 'Password must be at least 8 characters';
                          }
                          if (value.trim() ==
                              currentPasswordController.text.trim()) {
                            return 'New password must differ from current';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'At least 8 characters',
                          hintStyle: TextStyle(
                            color: textSecondaryColor,
                            fontSize: 14,
                          ),
                          prefixIcon: const Icon(
                            Icons.lock_reset_rounded,
                            color: AppColor.secondary,
                            size: 20,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscureNew
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: textSecondaryColor,
                              size: 20,
                            ),
                            onPressed: () {
                              setSheetState(() {
                                obscureNew = !obscureNew;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: inputBgColor,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 16,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: borderColor),
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

                      // Confirm New Password
                      Text(
                        'Confirm New Password',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: textPrimaryColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: confirmPasswordController,
                        obscureText: obscureConfirm,
                        style: TextStyle(fontSize: 14, color: textPrimaryColor),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please confirm your new password';
                          }
                          if (value.trim() !=
                              newPasswordController.text.trim()) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Re-enter new password',
                          hintStyle: TextStyle(
                            color: textSecondaryColor,
                            fontSize: 14,
                          ),
                          prefixIcon: const Icon(
                            Icons.lock_outline_rounded,
                            color: AppColor.secondary,
                            size: 20,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscureConfirm
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: textSecondaryColor,
                              size: 20,
                            ),
                            onPressed: () {
                              setSheetState(() {
                                obscureConfirm = !obscureConfirm;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: inputBgColor,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 16,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: borderColor),
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

                      const SizedBox(height: 22),

                      ValueListenableBuilder<bool>(
                        valueListenable: isSaving,
                        builder: (context, saving, _) {
                          return SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.primary,
                                foregroundColor: Colors.white,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              onPressed: saving
                                  ? null
                                  : () async {
                                      if (!formKey.currentState!.validate()) {
                                        return;
                                      }

                                      isSaving.value = true;
                                      try {
                                        final user = _auth.currentUser;
                                        if (user == null ||
                                            user.email == null) {
                                          AppSnackBar.show(
                                            title: 'Error',
                                            message: 'User session not found. Please log in again.',
                                            type: SnackBarType.error,
                                          );
                                          return;
                                        }

                                        // Re-authenticate user before password change
                                        final cred =
                                            EmailAuthProvider.credential(
                                              email: user.email!,
                                              password:
                                                  currentPasswordController.text
                                                      .trim(),
                                            );
                                        await user.reauthenticateWithCredential(
                                          cred,
                                        );

                                        // Update to new password
                                        await user.updatePassword(
                                          newPasswordController.text.trim(),
                                        );

                                        Get.back();

                                        AppSnackBar.show(
                                          title: 'Password Updated',
                                          message: 'Your password has been changed successfully.',
                                          type: SnackBarType.success,
                                        );
                                      } on FirebaseAuthException catch (e) {
                                        String msg =
                                            'Unable to update password.';
                                        if (e.code == 'wrong-password' ||
                                            e.code == 'invalid-credential') {
                                          msg =
                                              'Current password is incorrect.';
                                        } else if (e.code == 'weak-password') {
                                          msg = 'New password is too weak.';
                                        } else if (e.code ==
                                            'requires-recent-login') {
                                          msg = 'Please re-login to change password.';
                                        }
                                        AppSnackBar.show(
                                          title: 'Change Failed',
                                          message: msg,
                                          type: SnackBarType.error,
                                        );
                                      } catch (_) {
                                        AppSnackBar.show(
                                          title: 'Error',
                                          message: 'Something went wrong. Please try again.',
                                          type: SnackBarType.error,
                                        );
                                      } finally {
                                        isSaving.value = false;
                                      }
                                    },
                              child: saving
                                  ? const AppButtonLoader(size: 20)
                                  : const Text(
                                      'Update Password',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        isScrollControlled: true,
      );
    } finally {
      currentPasswordController.dispose();
      newPasswordController.dispose();
      confirmPasswordController.dispose();
      isSaving.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = isDark ? const Color(0xFF172235) : AppColor.surface;
    final textPrimaryColor = isDark ? Colors.white : AppColor.textPrimary;
    final textSecondaryColor = isDark
        ? const Color(0xFF94A3B8)
        : AppColor.textSecondary;
    final borderColor = isDark ? const Color(0xFF334155) : AppColor.border;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0B1220) : AppColor.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: isDark ? const Color(0xFF0B1220) : AppColor.background,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: textPrimaryColor),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Privacy & Security',
          style: TextStyle(
            color: textPrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Security Status Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF172235) : AppColor.lightBlue,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: isDark
                        ? const Color(0xFF334155)
                        : AppColor.secondary.withValues(alpha: 0.25),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF16A34A).withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.verified_user_rounded,
                        color: Color(0xFF16A34A),
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Account Protected',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: textPrimaryColor,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Signed in via $_providerName',
                            style: TextStyle(
                              fontSize: 12,
                              color: textSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Section 1: Security Controls
              Text(
                'Security Credentials',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isDark ? const Color(0xFF60A5FA) : AppColor.secondary,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 10),

              if (_isPasswordAuth) ...[
                _buildActionTile(
                  isDark: isDark,
                  icon: Icons.key_rounded,
                  iconColor: AppColor.primary,
                  title: 'Change Password',
                  subtitle: 'Update your current account password',
                  onTap: () => _showChangePasswordSheet(context, isDark),
                ),
                const SizedBox(height: 10),
                _buildActionTile(
                  isDark: isDark,
                  icon: Icons.mark_email_read_outlined,
                  iconColor: AppColor.secondary,
                  title: 'Password Reset Email',
                  subtitle: 'Send password reset link to your email',
                  onTap: () async {
                    if (_email.isEmpty) return;
                    final authController = Get.find<AuthController>();
                    await authController.resetPassword(_email);
                  },
                ),
              ] else ...[
                // Google authenticated notice tile
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: borderColor),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColor.secondary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.g_mobiledata_rounded,
                          color: AppColor.secondary,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Google Managed Security',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: textPrimaryColor,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Password and 2FA are managed directly via your Google Account.',
                              style: TextStyle(
                                fontSize: 12,
                                color: textSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 24),

              // Section 2: Privacy Policies
              Text(
                'Data & Privacy Information',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isDark ? const Color(0xFF60A5FA) : AppColor.secondary,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 10),

              _buildInfoCard(
                isDark: isDark,
                title: 'Data Storage & Privacy',
                description: 'Learning Path stores your learning progress, saved roadmaps, and personal notes locally and securely on your device. Account profile info is managed through Firebase Authentication.',
              ),
              const SizedBox(height: 10),

              _buildInfoCard(
                isDark: isDark,
                title: 'No Third-Party Tracking',
                description: 'Your notes, study activities, and bookmarks are never sold or shared with any third-party advertisers.',
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionTile({
    required bool isDark,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final surfaceColor = isDark ? const Color(0xFF172235) : AppColor.surface;
    final textPrimaryColor = isDark ? Colors.white : AppColor.textPrimary;
    final textSecondaryColor = isDark
        ? const Color(0xFF94A3B8)
        : AppColor.textSecondary;
    final borderColor = isDark ? const Color(0xFF334155) : AppColor.border;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: textPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: textSecondaryColor),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: textSecondaryColor,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required bool isDark,
    required String title,
    required String description,
  }) {
    final surfaceColor = isDark ? const Color(0xFF172235) : AppColor.surface;
    final textPrimaryColor = isDark ? Colors.white : AppColor.textPrimary;
    final textSecondaryColor = isDark
        ? const Color(0xFF94A3B8)
        : AppColor.textSecondary;
    final borderColor = isDark ? const Color(0xFF334155) : AppColor.border;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: textPrimaryColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: textSecondaryColor,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
