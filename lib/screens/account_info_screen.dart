import 'package:dev_path/Widgets/app_button_loader.dart';
import 'package:dev_path/Widgets/app_snackbar.dart';
import 'package:dev_path/app/theme/app_color.dart';
import 'package:dev_path/controller/auth_controller.dart';
import 'package:dev_path/data/avatar_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AccountInfoScreen extends StatefulWidget {
  const AccountInfoScreen({super.key});

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GetStorage _storage = GetStorage();

  String _displayName = 'Learner';
  String _email = 'No email available';
  String? _avatarPath;
  String _providerName = 'Email & Password';
  bool _isEmailVerified = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final user = _auth.currentUser;
    final name = user?.displayName?.trim();

    _displayName = (name != null && name.isNotEmpty) ? name : 'Learner';
    _email = user?.email ?? 'No email available';
    _isEmailVerified = user?.emailVerified ?? false;

    _avatarPath = user != null
        ? _storage.read('profileAvatar_${user.uid}')
        : null;

    final providerId = user?.providerData.isNotEmpty == true
        ? user!.providerData.first.providerId
        : '';

    if (providerId.contains('google')) {
      _providerName = 'Google Account';
    } else if (providerId.contains('password')) {
      _providerName = 'Email & Password';
    } else {
      _providerName = 'Firebase Account';
    }
  }

  // ── Show Edit Profile Sheet ──────────────────────────────────────────
  void _showEditProfileSheet(BuildContext context, bool isDark) async {
    final surfaceColor = isDark ? const Color(0xFF172235) : AppColor.surface;
    final textPrimaryColor = isDark ? Colors.white : AppColor.textPrimary;
    final textSecondaryColor = isDark
        ? const Color(0xFF94A3B8)
        : AppColor.textSecondary;
    final borderColor = isDark ? const Color(0xFF334155) : AppColor.border;
    final inputBgColor = isDark ? const Color(0xFF0B1220) : AppColor.background;

    final nameController = TextEditingController(text: _displayName);
    final formKey = GlobalKey<FormState>();
    final isSaving = ValueNotifier<bool>(false);

    try {
      await Get.bottomSheet(
        Container(
          padding: EdgeInsets.fromLTRB(
            20,
            16,
            20,
            MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
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
                      'Edit Profile',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textPrimaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Full Name',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: textPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: nameController,
                    style: TextStyle(fontSize: 14, color: textPrimaryColor),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Name cannot be empty';
                      }
                      if (value.trim().length < 3) {
                        return 'Name must be at least 3 characters';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter your name',
                      hintStyle: TextStyle(
                        color: textSecondaryColor,
                        fontSize: 14,
                      ),
                      prefixIcon: const Icon(
                        Icons.person_outline_rounded,
                        color: AppColor.secondary,
                        size: 20,
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
                  const SizedBox(height: 16),
                  Text(
                    'Email Address',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: textPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    initialValue: _email,
                    enabled: false,
                    style: TextStyle(fontSize: 14, color: textSecondaryColor),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.mail_outline_rounded,
                        color: AppColor.textSecondary,
                        size: 20,
                      ),
                      suffixIcon: const Icon(
                        Icons.lock_outline_rounded,
                        color: AppColor.textSecondary,
                        size: 18,
                      ),
                      filled: true,
                      fillColor: inputBgColor.withValues(alpha: 0.6),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 16,
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: borderColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
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
                                  if (!formKey.currentState!.validate()) return;

                                  isSaving.value = true;
                                  try {
                                    final newName = nameController.text.trim();
                                    final authController =
                                        Get.find<AuthController>();

                                    final success = await authController
                                        .updateProfileName(newName);

                                    if (success && mounted) {
                                      setState(() {
                                        _displayName = newName;
                                      });

                                      Get.back();

                                      AppSnackBar.show(
                                        title: 'Profile Updated',
                                        message: 'Your name has been updated successfully!',
                                        type: SnackBarType.success,
                                        duration: const Duration(seconds: 2),
                                      );
                                    }
                                  } finally {
                                    isSaving.value = false;
                                  }
                                },
                          child: saving
                              ? const AppButtonLoader(size: 20)
                              : const Text(
                                  'Save Changes',
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
        ),
        isScrollControlled: true,
      );
    } finally {
      nameController.dispose();
      isSaving.dispose();
    }
  }

  // ── Show Avatar Picker Sheet ─────────────────────────────────────────
  void _showAvatarPicker(BuildContext context, bool isDark) {
    final surfaceColor = isDark ? const Color(0xFF172235) : AppColor.surface;
    final textPrimaryColor = isDark ? Colors.white : AppColor.textPrimary;
    final textSecondaryColor = isDark
        ? const Color(0xFF94A3B8)
        : AppColor.textSecondary;
    final borderColor = isDark ? const Color(0xFF334155) : AppColor.border;

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: borderColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Choose Avatar',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textPrimaryColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Select an avatar for your profile',
              style: TextStyle(fontSize: 13, color: textSecondaryColor),
            ),
            const SizedBox(height: 20),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.42,
              ),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: AvatarData.avatars.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                ),
                itemBuilder: (context, index) {
                  final avatar = AvatarData.avatars[index];
                  final isSelected = _avatarPath == avatar;

                  return GestureDetector(
                    onTap: () async {
                      setState(() {
                        _avatarPath = avatar;
                      });
                      final authController = Get.find<AuthController>();
                      await authController.updateAvatar(avatar);
                      Get.back();
                      AppSnackBar.show(
                        title: 'Avatar Updated',
                        message: 'Your new avatar has been set!',
                        type: SnackBarType.success,
                        duration: const Duration(seconds: 2),
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? AppColor.primary
                                  : borderColor,
                              width: isSelected ? 3 : 1.5,
                            ),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              avatar,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                    Icons.person_rounded,
                                    color: AppColor.secondary,
                                  ),
                            ),
                          ),
                        ),
                        if (isSelected)
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: const BoxDecoration(
                                color: AppColor.primary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check_rounded,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
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
          'Account Information',
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
              // Avatar & Basic Info Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: borderColor),
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 88,
                          height: 88,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isDark
                                ? const Color(0xFF1E293B)
                                : AppColor.lightBlue,
                            border: Border.all(
                              color: isDark
                                  ? const Color(0xFF334155)
                                  : Colors.white,
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.secondary.withValues(
                                  alpha: 0.15,
                                ),
                                blurRadius: 16,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 42,
                            backgroundColor: isDark
                                ? const Color(0xFF1E293B)
                                : AppColor.lightBlue,
                            child: ClipOval(
                              child: _avatarPath != null
                                  ? Image.asset(
                                      _avatarPath!,
                                      width: 84,
                                      height: 84,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) => Icon(
                                            Icons.person_rounded,
                                            size: 48,
                                            color: isDark
                                                ? const Color(0xFF60A5FA)
                                                : AppColor.secondary,
                                          ),
                                    )
                                  : Icon(
                                      Icons.person_rounded,
                                      size: 48,
                                      color: isDark
                                          ? const Color(0xFF60A5FA)
                                          : AppColor.secondary,
                                    ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: InkWell(
                            onTap: () => _showAvatarPicker(context, isDark),
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: AppColor.secondary,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isDark
                                      ? const Color(0xFF0B1220)
                                      : Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.camera_alt_rounded,
                                size: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      _displayName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textPrimaryColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _email,
                      style: TextStyle(fontSize: 13, color: textSecondaryColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 14),
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColor.secondary,
                        side: BorderSide(
                          color: AppColor.secondary.withValues(alpha: 0.5),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                      onPressed: () => _showEditProfileSheet(context, isDark),
                      icon: const Icon(Icons.edit_rounded, size: 16),
                      label: const Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'Account Details',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isDark ? const Color(0xFF60A5FA) : AppColor.secondary,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 10),

              _buildInfoTile(
                isDark: isDark,
                icon: Icons.badge_outlined,
                iconColor: AppColor.secondary,
                label: 'Display Name',
                value: _displayName,
              ),
              const SizedBox(height: 10),

              _buildInfoTile(
                isDark: isDark,
                icon: Icons.mail_outline_rounded,
                iconColor: const Color(0xFF16A34A),
                label: 'Email Address',
                value: _email,
              ),
              const SizedBox(height: 10),

              _buildInfoTile(
                isDark: isDark,
                icon: Icons.verified_user_outlined,
                iconColor: _isEmailVerified
                    ? const Color(0xFF16A34A)
                    : const Color(0xFFEAB308),
                label: 'Email Status',
                value: _isEmailVerified ? 'Verified' : 'Not Verified',
              ),
              const SizedBox(height: 10),

              _buildInfoTile(
                isDark: isDark,
                icon: Icons.lock_outline_rounded,
                iconColor: AppColor.primary,
                label: 'Sign-in Method',
                value: _providerName,
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required bool isDark,
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    final surfaceColor = isDark ? const Color(0xFF172235) : AppColor.surface;
    final textPrimaryColor = isDark ? Colors.white : AppColor.textPrimary;
    final textSecondaryColor = isDark
        ? const Color(0xFF94A3B8)
        : AppColor.textSecondary;
    final borderColor = isDark ? const Color(0xFF334155) : AppColor.border;

    return Container(
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
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 12, color: textSecondaryColor),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: textPrimaryColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
