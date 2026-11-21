import 'package:dev_path/Widgets/global_ai_button.dart';
import 'package:dev_path/app/theme/app_color.dart';
import 'package:dev_path/controller/progress_controller.dart';
import 'package:dev_path/data/roadmap_data.dart';
import 'package:dev_path/data/roadmap_step_data.dart';
import 'package:dev_path/models/roadmap_model.dart';
import 'package:dev_path/models/roadmap_step_model.dart';
import 'package:dev_path/screens/learning_statistics_screen.dart';
import 'package:dev_path/screens/personal_ai_screen.dart';
import 'package:dev_path/screens/step_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoadmapDetailScreen extends StatefulWidget {
  final RoadmapModel? roadmap;

  const RoadmapDetailScreen({super.key, this.roadmap});

  @override
  State<RoadmapDetailScreen> createState() => _RoadmapDetailScreenState();
}

class _RoadmapDetailScreenState extends State<RoadmapDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _headerFadeAnimation;
  late Animation<double> _timelineGrowAnimation;

  final List<Map<String, dynamic>> _cardThemes = const [
    // 0: Dart Basics
    {
      'primary': Color(0xFF0072FF),
      'node': Color(0xFF0284C7),
      'iconGradients': [Color(0xFF0072FF), Color(0xFF00C6FF)],
      'bgGradientLight': [Color(0xFFEBF6FE), Color(0xFFF3F9FE)],
      'borderLight': Color(0xFFBAE6FD),
      'shadowLight': Color(0xFF0072FF),
      'bgDark': Color(0xFF10233D),
      'borderDark': Color(0xFF1D4ED8),
      'isCode': true,
      'icon': Icons.code_rounded,
    },
    // 1: Flutter Setup
    {
      'primary': Color(0xFF8B5CF6),
      'node': Color(0xFF9333EA),
      'iconGradients': [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
      'bgGradientLight': [Color(0xFFF5EEFD), Color(0xFFFAF5FE)],
      'borderLight': Color(0xFFE9D5FF),
      'shadowLight': Color(0xFF8B5CF6),
      'bgDark': Color(0xFF26133B),
      'borderDark': Color(0xFF7E22CE),
      'isCode': false,
      'icon': Icons.phone_android_rounded,
    },
    // 2: Widgets
    {
      'primary': Color(0xFF16A34A),
      'node': Color(0xFF10B981),
      'iconGradients': [Color(0xFF22C55E), Color(0xFF16A34A)],
      'bgGradientLight': [Color(0xFFECFDF3), Color(0xFFF4FDF7)],
      'borderLight': Color(0xFFBBF7D0),
      'shadowLight': Color(0xFF22C55E),
      'bgDark': Color(0xFF0F2B1D),
      'borderDark': Color(0xFF15803D),
      'isCode': false,
      'icon': Icons.grid_view_rounded,
    },
    // 3: Assets
    {
      'primary': Color(0xFFEA580C),
      'node': Color(0xFFF59E0B),
      'iconGradients': [Color(0xFFFB923C), Color(0xFFEA580C)],
      'bgGradientLight': [Color(0xFFFFF7ED), Color(0xFFFFFAF3)],
      'borderLight': Color(0xFFFED7AA),
      'shadowLight': Color(0xFFFB923C),
      'bgDark': Color(0xFF331D0F),
      'borderDark': Color(0xFFC2410C),
      'isCode': false,
      'icon': Icons.image_rounded,
    },
    // 4: Version Control
    {
      'primary': Color(0xFF7E22CE),
      'node': Color(0xFF6366F1),
      'iconGradients': [Color(0xFFA855F7), Color(0xFF7E22CE)],
      'bgGradientLight': [Color(0xFFF6F0FE), Color(0xFFFAF6FE)],
      'borderLight': Color(0xFFDDD6FE),
      'shadowLight': Color(0xFFA855F7),
      'bgDark': Color(0xFF23143B),
      'borderDark': Color(0xFF6D28D9),
      'isCode': false,
      'icon': Icons.alt_route_rounded,
    },
    // 5: APIs & Networking
    {
      'primary': Color(0xFF0891B2),
      'node': Color(0xFF06B6D4),
      'iconGradients': [Color(0xFF06B6D4), Color(0xFF0891B2)],
      'bgGradientLight': [Color(0xFFE8FAF9), Color(0xFFF2FCFB)],
      'borderLight': Color(0xFFA5F3FC),
      'shadowLight': Color(0xFF06B6D4),
      'bgDark': Color(0xFF0E282E),
      'borderDark': Color(0xFF0E7490),
      'isCode': false,
      'icon': Icons.language_rounded,
    },
    // 6: Storage & Firebase
    {
      'primary': Color(0xFF1D4ED8),
      'node': Color(0xFF3B82F6),
      'iconGradients': [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
      'bgGradientLight': [Color(0xFFEDF5FF), Color(0xFFF5FAFF)],
      'borderLight': Color(0xFFBFDBFE),
      'shadowLight': Color(0xFF3B82F6),
      'bgDark': Color(0xFF131F3B),
      'borderDark': Color(0xFF1E40AF),
      'isCode': false,
      'icon': Icons.storage_rounded,
    },
    // 7: State Management
    {
      'primary': Color(0xFF65A30D),
      'node': Color(0xFF84CC16),
      'iconGradients': [Color(0xFF84CC16), Color(0xFF65A30D)],
      'bgGradientLight': [Color(0xFFF4FCE7), Color(0xFFF9FDF2)],
      'borderLight': Color(0xFFD9F99D),
      'shadowLight': Color(0xFF84CC16),
      'bgDark': Color(0xFF1B290B),
      'borderDark': Color(0xFF4D7C0F),
      'isCode': false,
      'icon': Icons.settings_suggest_rounded,
    },
    // 8: Animations
    {
      'primary': Color(0xFFD946EF),
      'node': Color(0xFFF59E0B),
      'iconGradients': [Color(0xFFA855F7), Color(0xFFEC4899)],
      'bgGradientLight': [Color(0xFFFFF1F2), Color(0xFFFFF8F9)],
      'borderLight': Color(0xFFFECDD3),
      'shadowLight': Color(0xFFEC4899),
      'bgDark': Color(0xFF330E20),
      'borderDark': Color(0xFFBE185D),
      'isCode': false,
      'icon': Icons.view_in_ar_rounded,
    },
    // 9: Advanced Dart
    {
      'primary': Color(0xFF9333EA),
      'node': Color(0xFFA855F7),
      'iconGradients': [Color(0xFF9333EA), Color(0xFF7E22CE)],
      'bgGradientLight': [Color(0xFFF5EEFD), Color(0xFFFAF5FE)],
      'borderLight': Color(0xFFE9D5FF),
      'shadowLight': Color(0xFF9333EA),
      'bgDark': Color(0xFF26133B),
      'borderDark': Color(0xFF7E22CE),
      'isCode': false,
      'icon': Icons.extension_rounded,
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _headerFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.35, curve: Curves.easeOut),
      ),
    );

    _timelineGrowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.10, 0.85, curve: Curves.easeInOut),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final roadmapItem = widget.roadmap ?? RoadmapData.roadmaps.first;
    final roadmapSteps = RoadmapStepData.getStepsForLanguage(
      roadmapItem.language,
    );

    final progressController = Get.isRegistered<ProgressController>()
        ? Get.find<ProgressController>()
        : Get.put(ProgressController());

    final textPrimaryColor = isDark ? Colors.white : const Color(0xFF102B50);
    final textSecondaryColor = isDark
        ? const Color(0xFF94A3B8)
        : const Color(0xFF52647C);

    return Scaffold(
      floatingActionButton: GlobalAIButton(
        onPressed: () {
          Get.to(() => PersonalAiScreen());
          // Later AI Chat Screen open karenge
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Stack(
        children: [
          // Background Painter (Fluid waves and subtle dot grid)
          Positioned.fill(
            child: CustomPaint(
              painter: _RoadmapDetailBackgroundPainter(isDark: isDark),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(
                left: 14,
                right: 14,
                top: 6,
                bottom: 24,
              ),
              child: Column(
                children: [
                  // 1. Top Header Row (Back, Logo, Title, Progress Pill)
                  FadeTransition(
                    opacity: _headerFadeAnimation,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4, bottom: 14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Clean iOS-style Back Icon
                          GestureDetector(
                            onTap: () => Get.back(),
                            behavior: HitTestBehavior.opaque,
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: textPrimaryColor,
                                size: 22,
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),

                          // Official Flutter Logo (Clean, no box)
                          if (roadmapItem.language.toLowerCase() == 'flutter')
                            const FlutterLogo(size: 44)
                          else
                            Image.asset(
                              roadmapItem.imgUrl,
                              width: 40,
                              height: 40,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(
                                    Icons.code_rounded,
                                    color: AppColor.secondary,
                                    size: 30,
                                  ),
                            ),
                          const SizedBox(width: 10),

                          // Title and Subtitle
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '${roadmapItem.language} Roadmap',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w800,
                                    color: textPrimaryColor,
                                    letterSpacing: -0.4,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Your complete learning path',
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w500,
                                    color: textSecondaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Progress Capsule Badge (O 0%)
                          Obx(() {
                            progressController.progressUpdateTrigger.value;
                            final total = progressController.getTotalTopicCount(
                              roadmapSteps,
                            );
                            final completed = progressController
                                .getCompletedTopicCount(
                                  roadmapItem.language,
                                  roadmapSteps,
                                );
                            final progressRatio = total > 0
                                ? completed / total
                                : 0.0;
                            final percentage = (progressRatio * 100).toInt();

                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? const Color(0xFF1E293B)
                                    : Colors.white.withValues(alpha: 0.85),
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: isDark
                                      ? const Color(0xFF334155)
                                      : Colors.white,
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF0072FF)
                                        .withValues(alpha: 0.08),
                                    blurRadius: 10,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      value: progressRatio,
                                      strokeWidth: 3.5,
                                      backgroundColor: isDark
                                          ? const Color(0xFF334155)
                                          : const Color(0xFFDDE6F0),
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                            Color(0xFF3B82F6),
                                          ),
                                    ),
                                  ),
                                  const SizedBox(width: 7),
                                  Text(
                                    '$percentage%',
                                    style: TextStyle(
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.bold,
                                      color: textPrimaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),

                  // 2. "Start Here ↓" Pill Button
                  ScaleTransition(
                    scale: CurvedAnimation(
                      parent: _animationController,
                      curve: const Interval(
                        0.08,
                        0.38,
                        curve: Curves.easeOutBack,
                      ),
                    ),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 9,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF00C6FF), Color(0xFF0072FF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF0072FF)
                                  .withValues(alpha: 0.45),
                              blurRadius: 16,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Start Here',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.2,
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.arrow_downward_rounded,
                              color: Colors.white,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // 3. Staggered Dual-Column Cards & Central Timeline
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final double totalWidth = constraints.maxWidth;
                      final double centerX = totalWidth / 2;

                      const double cardHeight = 104.0;
                      const double verticalSpacing = 16.0;
                      const double stepY =
                          cardHeight + verticalSpacing; // 120.0
                      const double rightColumnOffset = stepY / 2; // 60.0

                      const double connectorWidth = 10.0;
                      final double cardWidth = centerX - 10 - connectorWidth;

                      final int leftCardCount = (roadmapSteps.length + 1) ~/ 2;
                      final int rightCardCount = roadmapSteps.length ~/ 2;

                      final double leftTotalHeight = leftCardCount > 0
                          ? (leftCardCount - 1) * stepY + cardHeight
                          : 0.0;
                      final double rightTotalHeight = rightCardCount > 0
                          ? rightColumnOffset +
                                (rightCardCount - 1) * stepY +
                                cardHeight
                          : 0.0;

                      final double totalHeight =
                          leftTotalHeight > rightTotalHeight
                          ? leftTotalHeight
                          : rightTotalHeight;

                      // Extract node colors
                      final List<Color> nodeColors = List.generate(
                        roadmapSteps.length,
                        (i) =>
                            _cardThemes[i % _cardThemes.length]['node']
                                as Color,
                      );

                      return SizedBox(
                        width: totalWidth,
                        height: totalHeight + 24,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // Timeline Spine & Nodes & Connectors
                            Positioned.fill(
                              child: AnimatedBuilder(
                                animation: _timelineGrowAnimation,
                                builder: (context, child) {
                                  return CustomPaint(
                                    painter: _TimelineSpinePainter(
                                      centerX: centerX,
                                      stepY: stepY,
                                      rightColumnOffset: rightColumnOffset,
                                      cardHeight: cardHeight,
                                      cardWidth: cardWidth,
                                      totalSteps: roadmapSteps.length,
                                      totalHeight: totalHeight,
                                      nodeColors: nodeColors,
                                      progress: _timelineGrowAnimation.value,
                                    ),
                                  );
                                },
                              ),
                            ),

                            // Cards
                            ...List.generate(roadmapSteps.length, (index) {
                              final step = roadmapSteps[index];
                              final isLeft = index % 2 == 0;

                              final themeIndex = index % _cardThemes.length;
                              final cardTheme = _cardThemes[themeIndex];

                              final primaryColor =
                                  cardTheme['primary'] as Color;
                              final iconGradients =
                                  cardTheme['iconGradients'] as List<Color>;
                              final bgGradients = isDark
                                  ? [
                                      cardTheme['bgDark'] as Color,
                                      cardTheme['bgDark'] as Color,
                                    ]
                                  : (cardTheme['bgGradientLight']
                                        as List<Color>);
                              final cardBorder = isDark
                                  ? (cardTheme['borderDark'] as Color)
                                  : (cardTheme['borderLight'] as Color);
                              final shadowColor = isDark
                                  ? Colors.black.withValues(alpha: 0.25)
                                  : (cardTheme['shadowLight'] as Color)
                                        .withValues(alpha: 0.12);
                              final cardIcon = cardTheme['icon'] as IconData;
                              final isCode = cardTheme['isCode'] as bool;

                              final double topPosition = isLeft
                                  ? (index ~/ 2) * stepY
                                  : rightColumnOffset + ((index ~/ 2) * stepY);

                              final startInterval = (0.10 + (index * 0.05))
                                  .clamp(0.0, 0.75);
                              final endInterval = (startInterval + 0.35).clamp(
                                0.2,
                                1.0,
                              );

                              final cardFadeAnimation =
                                  Tween<double>(begin: 0.0, end: 1.0).animate(
                                    CurvedAnimation(
                                      parent: _animationController,
                                      curve: Interval(
                                        startInterval,
                                        endInterval,
                                        curve: Curves.easeOutCubic,
                                      ),
                                    ),
                                  );

                              final slideAnimation =
                                  Tween<Offset>(
                                    begin: Offset(isLeft ? -0.15 : 0.15, 0.0),
                                    end: Offset.zero,
                                  ).animate(
                                    CurvedAnimation(
                                      parent: _animationController,
                                      curve: Interval(
                                        startInterval,
                                        endInterval,
                                        curve: Curves.easeOutCubic,
                                      ),
                                    ),
                                  );

                              return Positioned(
                                left: isLeft ? 0 : null,
                                right: !isLeft ? 0 : null,
                                top: topPosition,
                                width: cardWidth,
                                height: cardHeight,
                                child: SlideTransition(
                                  position: slideAnimation,
                                  child: FadeTransition(
                                    opacity: cardFadeAnimation,
                                    child: _buildTopicCard(
                                      step: step,
                                      roadmapTitle: roadmapItem.language,
                                      primaryColor: primaryColor,
                                      iconGradients: iconGradients,
                                      bgGradients: bgGradients,
                                      cardBorder: cardBorder,
                                      shadowColor: shadowColor,
                                      cardIcon: cardIcon,
                                      isCode: isCode,
                                      isDark: isDark,
                                      textPrimaryColor: textPrimaryColor,
                                      textSecondaryColor: textSecondaryColor,
                                      progressController: progressController,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 12),

                  // 4. "And Much More..." Pill Banner with celebratory rays
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      // Radiating Yellow Sparks (Left)
                      Positioned(
                        left: 14,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Transform.rotate(
                              angle: -0.4,
                              child: Container(
                                width: 9,
                                height: 2.5,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFBBF24),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Transform.rotate(
                              angle: 0.4,
                              child: Container(
                                width: 9,
                                height: 2.5,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFBBF24),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Centered Pill Container
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 32),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: isDark
                                ? [
                                    const Color(0xFF1E293B),
                                    const Color(0xFF0F172A),
                                  ]
                                : [
                                    const Color(0xFFEEF6FF),
                                    const Color(0xFFF6FAFE),
                                    Colors.white,
                                  ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: isDark
                                ? const Color(0xFF334155)
                                : const Color(0xFFBAE6FD),
                            width: 1.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF0284C7)
                                  .withValues(alpha: 0.08),
                              blurRadius: 14,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  '🏆',
                                  style: TextStyle(fontSize: 18),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'And Much More...',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: textPrimaryColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Complete the roadmap to become a ${roadmapItem.language} expert!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11.5,
                                color: textSecondaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Radiating Yellow Sparks (Right)
                      Positioned(
                        right: 14,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Transform.rotate(
                              angle: -0.4,
                              child: Container(
                                width: 9,
                                height: 2.5,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFBBF24),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Transform.rotate(
                              angle: 0.4,
                              child: Container(
                                width: 9,
                                height: 2.5,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFBBF24),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // 5. "Track Your Progress" Bottom Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF172235) : Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: isDark
                            ? const Color(0xFF334155)
                            : const Color(0xFFE2E8F0),
                        width: 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: isDark
                              ? Colors.black.withValues(alpha: 0.3)
                              : const Color(0xFF0072FF).withValues(alpha: 0.06),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // 3 Vertical Rounded Purple Bars Icon
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: 4.5,
                              height: 12,
                              decoration: BoxDecoration(
                                color: const Color(0xFF8B5CF6),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            const SizedBox(width: 3),
                            Container(
                              width: 4.5,
                              height: 18,
                              decoration: BoxDecoration(
                                color: const Color(0xFF8B5CF6),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            const SizedBox(width: 3),
                            Container(
                              width: 4.5,
                              height: 24,
                              decoration: BoxDecoration(
                                color: const Color(0xFF8B5CF6),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 14),

                        // Title & Subtitle
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Track Your Progress',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: textPrimaryColor,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Keep learning, keep growing!',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: textSecondaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // "View Progress →" Pill Button
                        InkWell(
                          onTap: () {
                            Get.to(() => const LearningStatisticsScreen());
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 9,
                            ),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF8B5CF6)
                                      .withValues(alpha: 0.35),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'View Progress',
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 14,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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

  Widget _buildTopicCard({
    required RoadmapStepModel step,
    required String roadmapTitle,
    required Color primaryColor,
    required List<Color> iconGradients,
    required List<Color> bgGradients,
    required Color cardBorder,
    required Color shadowColor,
    required IconData cardIcon,
    required bool isCode,
    required bool isDark,
    required Color textPrimaryColor,
    required Color textSecondaryColor,
    required ProgressController progressController,
  }) {
    final progressKey = '${roadmapTitle}_${step.id}';
    final completedTopics = progressController.loadProgress(
      progressKey,
      step.subtopics.length,
    );
    final isStepCompleted =
        step.subtopics.isNotEmpty &&
        completedTopics.every((completed) => completed);

    return InkWell(
      onTap: () async {
        await Get.to(
          () => StepDetailScreen(step: step, roadmapTitle: roadmapTitle),
        );
        if (mounted) {
          setState(() {});
        }
      },
      borderRadius: BorderRadius.circular(22),
      child: Container(
        padding: const EdgeInsets.fromLTRB(11, 10, 8, 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: bgGradients,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: isStepCompleted ? AppColor.success : cardBorder,
            width: isStepCompleted ? 1.8 : 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Top Row: Icon Box, Title, Chevron
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Squircle Icon Container
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: iconGradients,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withValues(alpha: 0.32),
                        blurRadius: 7,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: isStepCompleted
                        ? const Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                            size: 19,
                          )
                        : isCode
                        ? const Text(
                            '</>',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.5,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -1.2,
                            ),
                          )
                        : Icon(cardIcon, color: Colors.white, size: 20),
                  ),
                ),
                const SizedBox(width: 8),

                // Title
                Expanded(
                  child: Text(
                    step.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.bold,
                      color: textPrimaryColor,
                      letterSpacing: -0.2,
                    ),
                  ),
                ),

                const SizedBox(width: 2),

                // Chevron Arrow Right
                Icon(
                  Icons.chevron_right_rounded,
                  color: isDark ? Colors.white70 : textPrimaryColor,
                  size: 18,
                ),
              ],
            ),
            const SizedBox(height: 6),

            // Description underneath
            Text(
              step.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10.5,
                color: textSecondaryColor,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Custom Timeline Painter for vertical gradient spine, nodes, and horizontal connectors
class _TimelineSpinePainter extends CustomPainter {
  final double centerX;
  final double stepY;
  final double rightColumnOffset;
  final double cardHeight;
  final double cardWidth;
  final int totalSteps;
  final double totalHeight;
  final List<Color> nodeColors;
  final double progress;

  _TimelineSpinePainter({
    required this.centerX,
    required this.stepY,
    required this.rightColumnOffset,
    required this.cardHeight,
    required this.cardWidth,
    required this.totalSteps,
    required this.totalHeight,
    required this.nodeColors,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (totalSteps == 0) return;

    // 1. Draw central vertical spine
    const double topY = -18.0;
    final double bottomY = totalHeight + 16.0;
    final double currentBottomY = topY + ((bottomY - topY) * progress);

    final spineColors = [
      const Color(0xFF00C6FF),
      ...nodeColors,
      const Color(0xFF38BDF8),
    ];

    final spinePaint = Paint()
      ..shader = LinearGradient(
        colors: spineColors,
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTRB(centerX - 1.5, topY, centerX + 1.5, bottomY))
      ..strokeWidth = 2.8
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(centerX, topY),
      Offset(centerX, currentBottomY),
      spinePaint,
    );

    // 2. Draw horizontal connectors and nodes
    for (int i = 0; i < totalSteps; i++) {
      final isLeft = i % 2 == 0;
      final double cardTop = isLeft
          ? (i ~/ 2) * stepY
          : rightColumnOffset + ((i ~/ 2) * stepY);
      final double nodeY = cardTop + (cardHeight / 2);

      if (nodeY > currentBottomY) continue;

      final nodeColor = nodeColors[i % nodeColors.length];

      // Horizontal connector
      final connectorPaint = Paint()
        ..color = nodeColor
        ..strokeWidth = 2.6
        ..strokeCap = StrokeCap.round;

      if (isLeft) {
        // Connector from card right edge to central node
        canvas.drawLine(
          Offset(cardWidth, nodeY),
          Offset(centerX, nodeY),
          connectorPaint,
        );
      } else {
        // Connector from central node to card left edge
        canvas.drawLine(
          Offset(centerX, nodeY),
          Offset(size.width - cardWidth, nodeY),
          connectorPaint,
        );
      }

      // Node shadow
      final shadowPaint = Paint()
        ..color = nodeColor.withValues(alpha: 0.45)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4.0);
      canvas.drawCircle(Offset(centerX, nodeY + 1.5), 7.5, shadowPaint);

      // Node outer white ring
      final whitePaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(centerX, nodeY), 7.5, whitePaint);

      // Node inner colored circle
      final nodePaint = Paint()
        ..color = nodeColor
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(centerX, nodeY), 5.0, nodePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _TimelineSpinePainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.totalSteps != totalSteps ||
      oldDelegate.totalHeight != totalHeight;
}

/// Custom Background Painter to render the soft fluid waves and dot grid
class _RoadmapDetailBackgroundPainter extends CustomPainter {
  final bool isDark;

  const _RoadmapDetailBackgroundPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    // 1. Base gradient
    final basePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: isDark
            ? [
                const Color(0xFF0B1220),
                const Color(0xFF0F172A),
                const Color(0xFF131F35),
              ]
            : [
                const Color(0xFFF7FAFD),
                const Color(0xFFEEF5FD),
                const Color(0xFFF2F6FC),
              ],
      ).createShader(rect);
    canvas.drawRect(rect, basePaint);

    // 2. Top-right fluid wave
    final wave1Paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.centerLeft,
        colors: isDark
            ? [
                const Color(0xFF1E3A8A).withValues(alpha: 0.25),
                const Color(0xFF0B1220).withValues(alpha: 0.0),
              ]
            : [
                const Color(0xFFDCEEFE).withValues(alpha: 0.65),
                const Color(0xFFEBF5FE).withValues(alpha: 0.1),
              ],
      ).createShader(rect);

    final path1 = Path();
    path1.moveTo(size.width * 0.45, 0);
    path1.quadraticBezierTo(
      size.width * 0.85,
      size.height * 0.09,
      size.width,
      size.height * 0.20,
    );
    path1.lineTo(size.width, 0);
    path1.close();
    canvas.drawPath(path1, wave1Paint);

    // 3. Subtle Decorative Dot Grid at top-right
    final dotPaint = Paint()
      ..color = isDark
          ? const Color(0xFF38BDF8).withValues(alpha: 0.25)
          : const Color(0xFF93C5FD).withValues(alpha: 0.45);

    const int cols = 4;
    const int rows = 4;
    const double spacing = 9.0;
    final double startX = size.width - 44;
    const double startY = 96.0;

    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        canvas.drawCircle(
          Offset(startX + (c * spacing), startY + (r * spacing)),
          1.5,
          dotPaint,
        );
      }
    }

    // 4. Middle-left soft organic curve
    final wave2Paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: isDark
            ? [
                const Color(0xFF1E293B).withValues(alpha: 0.3),
                const Color(0xFF0B1220).withValues(alpha: 0.0),
              ]
            : [
                const Color(0xFFE3EFFD).withValues(alpha: 0.45),
                const Color(0xFFF3F7FD).withValues(alpha: 0.0),
              ],
      ).createShader(rect);

    final path2 = Path();
    path2.moveTo(0, size.height * 0.30);
    path2.quadraticBezierTo(
      size.width * 0.22,
      size.height * 0.38,
      0,
      size.height * 0.48,
    );
    path2.close();
    canvas.drawPath(path2, wave2Paint);

    // 5. Bottom-right soft organic curve
    final wave3Paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.centerLeft,
        colors: isDark
            ? [
                const Color(0xFF312E81).withValues(alpha: 0.2),
                const Color(0xFF0B1220).withValues(alpha: 0.0),
              ]
            : [
                const Color(0xFFDFEEFD).withValues(alpha: 0.5),
                const Color(0xFFF3F7FD).withValues(alpha: 0.0),
              ],
      ).createShader(rect);

    final path3 = Path();
    path3.moveTo(size.width, size.height * 0.68);
    path3.quadraticBezierTo(
      size.width * 0.78,
      size.height * 0.78,
      size.width,
      size.height * 0.88,
    );
    path3.close();
    canvas.drawPath(path3, wave3Paint);
  }

  @override
  bool shouldRepaint(covariant _RoadmapDetailBackgroundPainter oldDelegate) =>
      oldDelegate.isDark != isDark;
}
