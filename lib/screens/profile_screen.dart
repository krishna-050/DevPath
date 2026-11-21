import 'package:dev_path/Widgets/app_button_loader.dart';
import 'package:dev_path/Widgets/app_snackbar.dart';
import 'package:dev_path/app/theme/app_color.dart';
import 'package:dev_path/controller/auth_controller.dart';
import 'package:dev_path/controller/progress_controller.dart';
import 'package:dev_path/data/avatar_data.dart';
import 'package:dev_path/data/roadmap_data.dart';
import 'package:dev_path/data/roadmap_step_data.dart';
import 'package:dev_path/screens/achievements_screen.dart';
import 'package:dev_path/screens/learning_statistics_screen.dart';
import 'package:dev_path/screens/login_screen.dart';
import 'package:dev_path/screens/my_notes_screen.dart';
import 'package:dev_path/screens/setting_screen.dart';
import 'package:dev_path/screens/step_detail_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final GetStorage _storage = GetStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _displayName = 'Learner';
  String _email = 'No email available';
  String? _avatarPath;
  bool _isAvatarUpdating = false;

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

    _avatarPath = user != null
        ? _storage.read('profileAvatar_${user.uid}')
        : null;
  }

  Map<String, int> calculateStats(ProgressController controller) {
    int completedRoadmaps = 0;
    int completedTopics = 0;

    for (final roadmap in RoadmapData.roadmaps) {
      final steps = RoadmapStepData.getStepsForLanguage(roadmap.language);
      final total = controller.getTotalTopicCount(steps);
      final completed = controller.getCompletedTopicCount(
        roadmap.language,
        steps,
      );

      completedTopics += completed;
      if (total > 0 && completed == total) {
        completedRoadmaps++;
      }
    }

    return {'roadmaps': completedRoadmaps, 'topics': completedTopics};
  }

  void continueLearning(ProgressController controller) {
    final roadmapTitle = controller.getLastRoadmap();
    final stepId = controller.getLastStepId();

    if (roadmapTitle == null || stepId == null) {
      AppSnackBar.show(
        title: 'No Learning History',
        message: 'Start a roadmap to continue your learning.',
        type: SnackBarType.warning,
      );
      return;
    }

    final roadmaps = RoadmapData.roadmaps
        .where((roadmap) => roadmap.language == roadmapTitle)
        .toList();

    if (roadmaps.isEmpty) {
      AppSnackBar.show(
        title: 'Not Found',
        message: 'Roadmap could not be found.',
        type: SnackBarType.error,
      );
      return;
    }

    final steps = RoadmapStepData.getStepsForLanguage(roadmapTitle);
    final matchingSteps = steps.where((step) => step.id == stepId).toList();

    if (matchingSteps.isEmpty) {
      AppSnackBar.show(
        title: 'Not Found',
        message: 'Learning step could not be found.',
        type: SnackBarType.error,
      );
      return;
    }

    Get.to(
      () => StepDetailScreen(
        step: matchingSteps.first,
        roadmapTitle: roadmapTitle,
      ),
    );
  }

  // ── 1. Avatar Picker Sheet ───────────────────────────────────────────
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
                    onTap: _isAvatarUpdating
                        ? null
                        : () async {
                            setState(() {
                              _isAvatarUpdating = true;
                            });

                            try {
                              final authController = Get.find<AuthController>();
                              final success = await authController.updateAvatar(
                                avatar,
                              );

                              if (success && mounted) {
                                setState(() {
                                  _avatarPath = avatar;
                                });

                                Get.back();

                                AppSnackBar.show(
                                  title: 'Avatar Updated',
                                  message: 'Your new avatar has been set!',
                                  type: SnackBarType.success,
                                );
                              }
                            } finally {
                              if (mounted) {
                                setState(() {
                                  _isAvatarUpdating = false;
                                });
                              }
                            }
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

  // ── 2. Edit Profile Sheet ───────────────────────────────────────────

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

  Future<void> refreshProfile() async {
    await _auth.currentUser?.reload();

    if (!mounted) return;

    setState(() {
      _loadUserData();
    });
  }

  // ── 3. Logout Confirmation Dialog ───────────────────────────────────
  void _showLogoutDialog(BuildContext context, bool isDark) {
    final surfaceColor = isDark ? const Color(0xFF172235) : AppColor.surface;
    final textPrimaryColor = isDark ? Colors.white : AppColor.textPrimary;
    final textSecondaryColor = isDark
        ? const Color(0xFF94A3B8)
        : AppColor.textSecondary;
    final isLogoutLoading = ValueNotifier<bool>(false);

    Get.dialog(
      ValueListenableBuilder<bool>(
        valueListenable: isLogoutLoading,
        builder: (context, loading, _) {
          return AlertDialog(
            backgroundColor: surfaceColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              'Logout',
              style: TextStyle(
                color: textPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              'Are you sure you want to logout from DevPath?',
              style: TextStyle(color: textSecondaryColor),
            ),
            actions: [
              TextButton(
                onPressed: loading ? null : () => Get.back(),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: textSecondaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(88, 38),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: loading
                    ? null
                    : () async {
                        isLogoutLoading.value = true;
                        try {
                          final authController = Get.find<AuthController>();
                          final success = await authController.logout();
                          if (success) {
                            Get.offAll(() => const LoginScreen());
                          }
                        } finally {
                          isLogoutLoading.value = false;
                        }
                      },
                child: loading
                    ? const AppButtonLoader(size: 18)
                    : const Text(
                        'Logout',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final progressController = Get.find<ProgressController>();

    final bgColor = isDark ? const Color(0xFF0B1220) : AppColor.background;
    final surfaceColor = isDark ? const Color(0xFF172235) : AppColor.surface;
    final textPrimaryColor = isDark ? Colors.white : AppColor.textPrimary;
    final textSecondaryColor = isDark
        ? const Color(0xFF94A3B8)
        : AppColor.textSecondary;
    final borderColor = isDark ? const Color(0xFF334155) : AppColor.border;
    final pillBgColor = isDark
        ? const Color(0xFF1E293B)
        : const Color(0xFFF1F5F9);

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          // Top Organic Curved Blue Wave Design
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 170,
            child: CustomPaint(painter: _TopWavePainter()),
          ),

          // Main Content
          SafeArea(
            child: Column(
              children: [
                // Top Custom Header / AppBar
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Navigator.canPop(context)
                          ? IconButton(
                              icon: Icon(
                                Icons.arrow_back_rounded,
                                color: textPrimaryColor,
                                size: 22,
                              ),
                              onPressed: () => Get.back(),
                            )
                          : const SizedBox(width: 44),
                      Text(
                        'Profile',
                        style: TextStyle(
                          color: textPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          letterSpacing: -0.3,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.settings_outlined,
                          color: textPrimaryColor,
                          size: 22,
                        ),
                        onPressed: () {
                          Get.to(() => const SettingScreen());
                        },
                      ),
                    ],
                  ),
                ),

                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Column(
                      children: [
                        // User Avatar & Info Section (Horizontal Row)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 8,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Left: Avatar with Edit Badge
                              GestureDetector(
                                onTap: () => _showAvatarPicker(context, isDark),
                                child: Stack(
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
                                            color: AppColor.secondary
                                                .withValues(alpha: 0.12),
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
                                                      (
                                                        context,
                                                        error,
                                                        stackTrace,
                                                      ) {
                                                        return Icon(
                                                          Icons.person_rounded,
                                                          size: 48,
                                                          color: isDark
                                                              ? const Color(
                                                                  0xFF60A5FA,
                                                                )
                                                              : AppColor
                                                                    .secondary,
                                                        );
                                                      },
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
                                          size: 13,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(width: 18),

                              // Right: User Name, Email & Badges
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _displayName,
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: textPrimaryColor,
                                        letterSpacing: -0.5,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      _email,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: textSecondaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        // Level Badge
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            color: pillBgColor,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(
                                                Icons
                                                    .workspace_premium_outlined,
                                                size: 15,
                                                color: AppColor.primary,
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                'Beginner',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: textPrimaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        const SizedBox(width: 8),

                                        // Quick Edit Profile Affordance
                                        InkWell(
                                          onTap: () => _showEditProfileSheet(
                                            context,
                                            isDark,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 5,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColor.secondary
                                                  .withValues(alpha: 0.1),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                color: AppColor.secondary
                                                    .withValues(alpha: 0.3),
                                              ),
                                            ),
                                            child: const Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.edit_rounded,
                                                  size: 13,
                                                  color: AppColor.secondary,
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  'Edit',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColor.secondary,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Stats Overview Card (3 Columns)
                        Obx(() {
                          progressController.progressUpdateTrigger.value;
                          final currentStreak = progressController
                              .getCurrentStreak();

                          final stats = calculateStats(progressController);
                          final completedCount = stats['roadmaps'] ?? 0;
                          final totalTopicsCount = stats['topics'] ?? 0;
                          final pointsCount = totalTopicsCount * 25;

                          return Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            decoration: BoxDecoration(
                              color: surfaceColor,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: borderColor),
                              boxShadow: [
                                BoxShadow(
                                  color: textPrimaryColor.withValues(
                                    alpha: 0.04,
                                  ),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // Col 1: Courses Completed
                                Expanded(
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.menu_book_rounded,
                                        color: isDark
                                            ? const Color(0xFF60A5FA)
                                            : AppColor.secondary,
                                        size: 26,
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        '$completedCount',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: textPrimaryColor,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'Courses\nCompleted',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: textSecondaryColor,
                                          height: 1.2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Container(
                                  height: 40,
                                  width: 1,
                                  color: borderColor,
                                ),

                                // Col 2: Day Streak
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Icon(
                                        Icons.local_fire_department_rounded,
                                        color: AppColor.primary,
                                        size: 26,
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        currentStreak.toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: textPrimaryColor,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'Day Streak',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: textSecondaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Container(
                                  height: 40,
                                  width: 1,
                                  color: borderColor,
                                ),

                                // Col 3: Total Points
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Icon(
                                        Icons.star_rounded,
                                        color: Color(0xFFEAB308),
                                        size: 26,
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        '$pointsCount',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: textPrimaryColor,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'Total Points',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: textSecondaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),

                        const SizedBox(height: 16),

                        // Keep Learning Banner Card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF1E293B)
                                : AppColor.lightBlue,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: isDark
                                  ? const Color(0xFF334155)
                                  : AppColor.secondary.withValues(alpha: 0.2),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? const Color(0xFF172235)
                                      : Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.emoji_events_rounded,
                                  color: Color(0xFFEAB308),
                                  size: 26,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Keep Learning!',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: textPrimaryColor,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      "You're doing great. Take the next step towards your goal.",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: textSecondaryColor,
                                        height: 1.3,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.primary,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 10,
                                  ),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {
                                  continueLearning(progressController);
                                },
                                child: const Text(
                                  'Continue →',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Menu List Items
                        _buildMenuItem(
                          isDark: isDark,
                          icon: Icons.person_outline_rounded,
                          iconColor: isDark
                              ? const Color(0xFF60A5FA)
                              : AppColor.secondary,
                          title: 'Edit Profile',
                          subtitle:
                              'Change your display name and personal info',
                          onTap: () {
                            _showEditProfileSheet(context, isDark);
                          },
                        ),
                        const SizedBox(height: 10),

                        _buildMenuItem(
                          isDark: isDark,
                          icon: Icons.bar_chart_rounded,
                          iconColor: AppColor.primary,
                          title: 'Learning Statistics',
                          subtitle: 'Track your progress and insights',
                          onTap: () {
                            Get.to(() => const LearningStatisticsScreen());
                          },
                        ),
                        const SizedBox(height: 10),

                        _buildMenuItem(
                          isDark: isDark,
                          icon: Icons.emoji_events_outlined,
                          iconColor: const Color(0xFFEAB308),
                          title: 'Achievements & Badges',
                          subtitle: 'View unlocked trophies and rewards',
                          onTap: () {
                            Get.to(() => const AchievementsScreen());
                          },
                        ),
                        const SizedBox(height: 10),

                        _buildMenuItem(
                          isDark: isDark,
                          icon: Icons.edit_note_rounded,
                          iconColor: isDark
                              ? const Color(0xFF60A5FA)
                              : AppColor.secondary,
                          title: 'My Learning Notes',
                          subtitle: 'View and manage personal step notes',
                          onTap: () {
                            Get.to(() => const MyNotesScreen());
                          },
                        ),
                        const SizedBox(height: 20),

                        // Logout Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: isDark
                                  ? const Color(0xFF172235)
                                  : Colors.white,
                              side: BorderSide(
                                color: AppColor.primary.withValues(alpha: 0.6),
                                width: 1.5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () => _showLogoutDialog(context, isDark),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.logout_rounded,
                                  color: AppColor.primary,
                                  size: 20,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Logout',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
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

  Widget _buildMenuItem({
    required bool isDark,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF172235) : AppColor.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? const Color(0xFF334155) : AppColor.border,
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.15)
                  : AppColor.textPrimary.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
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
                      color: isDark ? Colors.white : AppColor.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark
                          ? const Color(0xFF94A3B8)
                          : AppColor.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: isDark ? const Color(0xFF94A3B8) : AppColor.textSecondary,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}

class _TopWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintBase = Paint()
      ..color = const Color(0xFFD6EBFF).withValues(alpha: 0.8)
      ..style = PaintingStyle.fill;

    final pathBase = Path();
    pathBase.moveTo(0, 0);
    pathBase.lineTo(0, size.height * 0.7);
    pathBase.quadraticBezierTo(
      size.width * 0.35,
      size.height * 1.15,
      size.width * 0.75,
      size.height * 0.65,
    );
    pathBase.quadraticBezierTo(
      size.width * 0.9,
      size.height * 0.45,
      size.width,
      size.height * 0.55,
    );
    pathBase.lineTo(size.width, 0);
    pathBase.close();
    canvas.drawPath(pathBase, paintBase);

    final paintAccent = Paint()
      ..color = const Color(0xFF60A5FA).withValues(alpha: 0.45)
      ..style = PaintingStyle.fill;

    final pathAccent = Path();
    pathAccent.moveTo(size.width * 0.45, 0);
    pathAccent.quadraticBezierTo(
      size.width * 0.65,
      size.height * 0.8,
      size.width,
      size.height * 0.6,
    );
    pathAccent.lineTo(size.width, 0);
    pathAccent.close();
    canvas.drawPath(pathAccent, paintAccent);

    final paintDeep = Paint()
      ..color = const Color(0xFF2563EB).withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;

    final pathDeep = Path();
    pathDeep.moveTo(size.width * 0.7, 0);
    pathDeep.quadraticBezierTo(
      size.width * 0.82,
      size.height * 0.9,
      size.width,
      size.height * 0.75,
    );
    pathDeep.lineTo(size.width, 0);
    pathDeep.close();
    canvas.drawPath(pathDeep, paintDeep);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
