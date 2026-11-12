import 'package:dev_path/app/theme/app_color.dart';
import 'package:dev_path/controller/progress_controller.dart';
import 'package:dev_path/models/roadmap_step_model.dart';
import 'package:dev_path/screens/webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StepDetailScreen extends StatefulWidget {
  final RoadmapStepModel step;
  final String roadmapTitle;

  const StepDetailScreen({
    super.key,
    required this.step,
    this.roadmapTitle = 'Roadmap',
  });

  @override
  State<StepDetailScreen> createState() => _StepDetailScreenState();
}

class _StepDetailScreenState extends State<StepDetailScreen> {
  late ProgressController progressController;
  late String progressKey;
  late List<bool> _completedTopics;

  @override
  void initState() {
    super.initState();
    // _completedTopics = List<bool>.filled(widget.step.subtopics.length, false);
    progressController = Get.find<ProgressController>();

    progressKey = '${widget.roadmapTitle}_${widget.step.id}';

    _completedTopics = progressController.loadProgress(
        progressKey,
        widget.step.subtopics.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    final step = widget.step;
    final totalTopics = step.subtopics.length;
    final completedCount =
        _completedTopics.where((completed) => completed).length;
    final progress = totalTopics > 0 ? completedCount / totalTopics : 0.0;
    final isAllCompleted = totalTopics > 0 && completedCount == totalTopics;

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.background,
        centerTitle: false,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: AppColor.textPrimary,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          widget.roadmapTitle,
          style: const TextStyle(
            color: AppColor.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: -0.3,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.share_outlined,
              color: AppColor.textPrimary,
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero Step Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            AppColor.secondary,
                            Color(0xFF1E3A8A),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.secondary.withValues(alpha: 0.28),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          Colors.white.withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      'STEP ${step.id}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          Colors.white.withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.schedule_rounded,
                                          size: 14,
                                          color: Colors.white70,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          step.duration,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 16),

                              Text(
                                step.title,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: -0.5,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Text(
                                step.description,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white.withValues(alpha: 0.85),
                                  height: 1.4,
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Progress Indicator Bar
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Step Mastery',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      Text(
                                        '${(progress * 100).toInt()}% Completed',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: LinearProgressIndicator(
                                      value: progress,
                                      minHeight: 8,
                                      backgroundColor:
                                          Colors.white.withValues(alpha: 0.2),
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                        AppColor.primary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Positioned(
                            right: -10,
                            bottom: -10,
                            child: Icon(
                              Icons.task_alt_rounded,
                              size: 110,
                              color: Colors.white.withValues(alpha: 0.08),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Subtopics Checklist Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Topics to Master',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColor.textPrimary,
                            letterSpacing: -0.3,
                          ),
                        ),
                        Text(
                          '$completedCount/$totalTopics completed',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColor.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    ...List.generate(step.subtopics.length, (index) {
                      final isChecked = _completedTopics[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _completedTopics[index] =
                                  !_completedTopics[index];
                            });
                            progressController.saveProgress(
                              progressKey,
                              _completedTopics,
                            );
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: isChecked
                                  ? AppColor.lightOrange.withValues(alpha: 0.5)
                                  : AppColor.surface,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isChecked
                                    ? AppColor.primary.withValues(alpha: 0.5)
                                    : AppColor.border.withValues(alpha: 0.7),
                                width: isChecked ? 1.5 : 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.textPrimary
                                      .withValues(alpha: 0.03),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: isChecked
                                        ? AppColor.primary
                                        : Colors.transparent,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isChecked
                                          ? AppColor.primary
                                          : AppColor.border,
                                      width: 2,
                                    ),
                                  ),
                                  child: isChecked
                                      ? const Icon(
                                          Icons.check_rounded,
                                          size: 16,
                                          color: Colors.white,
                                        )
                                      : null,
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Text(
                                    step.subtopics[index],
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: isChecked
                                          ? AppColor.textPrimary
                                          : AppColor.textPrimary,
                                      decoration: isChecked
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                      decorationColor: AppColor.textSecondary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 20),

                    // Step Resources Section
                    if (step.resources != null &&
                        step.resources!.isNotEmpty) ...[
                      const Text(
                        'Recommended Resources',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColor.textPrimary,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...step.resources!.map((resString) {
                        final parts = resString.split(': http');
                        final title = parts[0].trim();
                        final url =
                            parts.length > 1 ? 'http${parts[1]}'.trim() : '';

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: InkWell(
                            onTap: () {
                              if (url.isNotEmpty) {
                                Get.to(
                                  () => WebViewScreen(url: url, title: title),
                                );
                              }
                            },
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppColor.surface,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: AppColor.border),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColor.textPrimary
                                        .withValues(alpha: 0.03),
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
                                      color: AppColor.lightBlue,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(
                                      Icons.description_outlined,
                                      color: AppColor.secondary,
                                      size: 22,
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          title,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.textPrimary,
                                          ),
                                        ),
                                        if (url.isNotEmpty) ...[
                                          const SizedBox(height: 2),
                                          Text(
                                            url,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 11,
                                              color: AppColor.secondary,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(
                                    Icons.open_in_new_rounded,
                                    color: AppColor.secondary,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ],

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // Bottom Floating Action Button Bar
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColor.surface,
                boxShadow: [
                  BoxShadow(
                    color: AppColor.textPrimary.withValues(alpha: 0.08),
                    blurRadius: 16,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isAllCompleted ? AppColor.success : AppColor.primary,
                    foregroundColor: Colors.white,
                    elevation: 3,
                    shadowColor:
                        (isAllCompleted ? AppColor.success : AppColor.primary)
                            .withValues(alpha: 0.35),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    if (!isAllCompleted) {
                      setState(() {
                        _completedTopics = List<bool>.filled(
                            widget.step.subtopics.length, true);
                      });
                      progressController.saveProgress(
                        progressKey,
                        _completedTopics,
                      );
                      Get.snackbar(
                        'Step Mastered! 🎉',
                        'Great job finishing all topics for ${step.title}!',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: AppColor.surface,
                        colorText: AppColor.textPrimary,
                        margin: const EdgeInsets.all(16),
                        borderRadius: 12,
                      );
                    } else {
                      Get.back();
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isAllCompleted
                            ? Icons.check_circle_rounded
                            : Icons.task_alt_rounded,
                        size: 22,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        isAllCompleted
                            ? 'Step Mastered 🎉'
                            : 'Mark All Topics Completed',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

