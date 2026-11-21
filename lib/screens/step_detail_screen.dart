import 'dart:math' as math;

import 'package:dev_path/Widgets/app_snackbar.dart';
import 'package:dev_path/Widgets/global_ai_button.dart';
import 'package:dev_path/app/theme/app_color.dart';
import 'package:dev_path/controller/note_controller.dart';
import 'package:dev_path/controller/progress_controller.dart';
import 'package:dev_path/models/note_model.dart';
import 'package:dev_path/models/roadmap_step_model.dart';
import 'package:dev_path/screens/personal_ai_screen.dart';
import 'package:dev_path/screens/webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class StepDetailScreen extends StatefulWidget {
  final RoadmapStepModel step;
  final String roadmapTitle;

  const StepDetailScreen({
    super.key,
    required this.step,
    required this.roadmapTitle,
  });

  @override
  State<StepDetailScreen> createState() => _StepDetailScreenState();
}

class _StepDetailScreenState extends State<StepDetailScreen>
    with TickerProviderStateMixin {
  late List<bool> _completedTopics;
  late TabController _tabController;
  late AnimationController _headerAnimController;
  late Animation<double> _headerFadeAnim;

  @override
  void initState() {
    super.initState();
    final progressController = Get.find<ProgressController>();
    final progressKey = '${widget.roadmapTitle}_${widget.step.id}';

    _completedTopics = progressController.loadProgress(
      progressKey,
      widget.step.subtopics.length,
    );

    // Determine tab count based on content
    int tabCount = 2; // Topics + Resources
    if (widget.step.exercises != null && widget.step.exercises!.isNotEmpty) {
      tabCount++;
    }
    tabCount++; // Notes tab

    _tabController = TabController(length: tabCount, vsync: this);
    _headerAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _headerFadeAnim = CurvedAnimation(
      parent: _headerAnimController,
      curve: Curves.easeOut,
    );
    _headerAnimController.forward();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _headerAnimController.dispose();
    super.dispose();
  }

  void _showAddNoteSheet({
    required BuildContext context,
    required NoteController noteController,
    required String roadmapTitle,
    required RoadmapStepModel step,
    NoteModel? existingNote,
  }) {
    final titleController = TextEditingController(
      text: existingNote?.title ?? '',
    );
    final contentController = TextEditingController(
      text: existingNote?.content ?? '',
    );

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = isDark ? const Color(0xFF172235) : AppColor.surface;
    final textPrimaryColor = isDark ? Colors.white : AppColor.textPrimary;
    final textSecondaryColor = isDark
        ? const Color(0xFF94A3B8)
        : AppColor.textSecondary;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: surfaceColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            top: 8,
            left: 20,
            right: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: textSecondaryColor.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColor.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.sticky_note_2_rounded,
                      color: AppColor.primary,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          existingNote == null ? 'Add Note' : 'Edit Note',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textPrimaryColor,
                          ),
                        ),
                        Text(
                          'Step ${step.id}: ${step.title}',
                          style: TextStyle(
                            fontSize: 12,
                            color: textSecondaryColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close_rounded, color: textSecondaryColor),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: titleController,
                style: TextStyle(color: textPrimaryColor, fontSize: 15),
                decoration: InputDecoration(
                  hintText: 'Note title...',
                  hintStyle: TextStyle(color: textSecondaryColor, fontSize: 14),
                  prefixIcon: Icon(
                    Icons.title_rounded,
                    color: textSecondaryColor,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: isDark
                      ? const Color(0xFF0B1220)
                      : AppColor.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: contentController,
                maxLines: 5,
                style: TextStyle(color: textPrimaryColor, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Write your notes, reminders, or key takeaways...',
                  hintStyle: TextStyle(color: textSecondaryColor, fontSize: 13),
                  filled: true,
                  fillColor: isDark
                      ? const Color(0xFF0B1220)
                      : AppColor.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    final title = titleController.text.trim();
                    final content = contentController.text.trim();
                    if (title.isEmpty || content.isEmpty) {
                      AppSnackBar.show(
                        title: 'Missing Info',
                        message: 'Please fill in both title and content.',
                        type: SnackBarType.warning,
                      );
                      return;
                    }
                    if (existingNote == null) {
                      noteController.addNote(
                        roadmapTitle: roadmapTitle,
                        stepId: step.id,
                        stepTitle: step.title,
                        title: title,
                        content: content,
                      );
                    } else {
                      noteController.updateNote(
                        id: existingNote.id,
                        title: title,
                        content: content,
                      );
                    }
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        existingNote == null
                            ? Icons.save_rounded
                            : Icons.update_rounded,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        existingNote == null ? 'Save Note' : 'Update Note',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final step = widget.step;
    final progressController = Get.find<ProgressController>();
    final noteController = Get.isRegistered<NoteController>()
        ? Get.find<NoteController>()
        : Get.put(NoteController());

    final progressKey = '${widget.roadmapTitle}_${step.id}';
    final totalTopics = step.subtopics.length;
    final completedCount = _completedTopics
        .where((completed) => completed)
        .length;
    final progress = totalTopics > 0 ? completedCount / totalTopics : 0.0;
    final isAllCompleted = totalTopics > 0 && completedCount == totalTopics;

    final bgColor = isDark ? const Color(0xFF0B1220) : AppColor.background;
    final surfaceColor = isDark ? const Color(0xFF172235) : AppColor.surface;
    final textPrimaryColor = isDark ? Colors.white : AppColor.textPrimary;
    final textSecondaryColor = isDark
        ? const Color(0xFF94A3B8)
        : AppColor.textSecondary;
    final borderColor = isDark ? const Color(0xFF334155) : AppColor.border;

    final levelColor = _getLevelColor(step.level);

    final hasExercises = step.exercises != null && step.exercises!.isNotEmpty;
    final tabs = <Tab>[
      const Tab(text: 'Topics'),
      if (hasExercises) const Tab(text: 'Exercises'),
      const Tab(text: 'Resources'),
      const Tab(text: 'Notes'),
    ];

    return Scaffold(
      floatingActionButton: GlobalAIButton(
        onPressed: () {
          Get.to(() => PersonalAiScreen());
          // Later AI Chat Screen open karenge
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: bgColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 280,
              pinned: true,
              backgroundColor: bgColor,
              elevation: 0,
              automaticallyImplyLeading: false,
              leading: const SizedBox.shrink(),
              actions: const [],
              flexibleSpace: FlexibleSpaceBar(
                background: FadeTransition(
                  opacity: _headerFadeAnim,
                  child: _buildHeroHeader(
                    context: context,
                    step: step,
                    isDark: isDark,
                    progress: progress,
                    completedCount: completedCount,
                    totalTopics: totalTopics,
                    levelColor: levelColor,
                    isAllCompleted: isAllCompleted,
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(48),
                child: Container(
                  color: bgColor,
                  child: TabBar(
                    controller: _tabController,
                    tabs: tabs,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    labelColor: AppColor.primary,
                    unselectedLabelColor: textSecondaryColor,
                    labelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    indicatorColor: AppColor.primary,
                    indicatorWeight: 3,
                    indicatorSize: TabBarIndicatorSize.label,
                    dividerColor: borderColor,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            // --- TOPICS TAB ---
            _TopicsTab(
              step: step,
              completedTopics: _completedTopics,
              isDark: isDark,
              surfaceColor: surfaceColor,
              textPrimaryColor: textPrimaryColor,
              textSecondaryColor: textSecondaryColor,
              borderColor: borderColor,
              bgColor: bgColor,
              onToggle: (index) {
                setState(() {
                  _completedTopics[index] = !_completedTopics[index];
                });
                progressController.saveProgress(progressKey, _completedTopics);
                progressController.saveLastOpenedStep(
                  widget.roadmapTitle,
                  step.id,
                );
              },
            ),

            // --- EXERCISES TAB (optional) ---
            if (hasExercises)
              _ExercisesTab(
                exercises: step.exercises!,
                isDark: isDark,
                surfaceColor: surfaceColor,
                textPrimaryColor: textPrimaryColor,
                textSecondaryColor: textSecondaryColor,
                borderColor: borderColor,
                bgColor: bgColor,
              ),

            // --- RESOURCES TAB ---
            _ResourcesTab(
              step: step,
              isDark: isDark,
              surfaceColor: surfaceColor,
              textPrimaryColor: textPrimaryColor,
              textSecondaryColor: textSecondaryColor,
              borderColor: borderColor,
              bgColor: bgColor,
            ),

            // --- NOTES TAB ---
            _NotesTab(
              step: step,
              roadmapTitle: widget.roadmapTitle,
              noteController: noteController,
              isDark: isDark,
              surfaceColor: surfaceColor,
              textPrimaryColor: textPrimaryColor,
              textSecondaryColor: textSecondaryColor,
              borderColor: borderColor,
              bgColor: bgColor,
              onAddNote: () => _showAddNoteSheet(
                context: context,
                noteController: noteController,
                roadmapTitle: widget.roadmapTitle,
                step: step,
              ),
              onEditNote: (note) => _showAddNoteSheet(
                context: context,
                noteController: noteController,
                roadmapTitle: widget.roadmapTitle,
                step: step,
                existingNote: note,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(
        context: context,
        isAllCompleted: isAllCompleted,
        isDark: isDark,
        surfaceColor: surfaceColor,
        textPrimaryColor: textPrimaryColor,
        progressController: progressController,
        progressKey: progressKey,
        step: step,
      ),
    );
  }

  Widget _buildHeroHeader({
    required BuildContext context,
    required RoadmapStepModel step,
    required bool isDark,
    required double progress,
    required int completedCount,
    required int totalTopics,
    required Color levelColor,
    required bool isAllCompleted,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF1479D4), const Color(0xFF0F2850)]
              : [AppColor.secondary, const Color(0xFF0D3B8E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Background decorative shapes
          Positioned(
            right: -40,
            top: -40,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
          ),
          Positioned(
            right: 20,
            bottom: 40,
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 25, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Phase + Level + Status Badges
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => Get.back(),
                              behavior: HitTestBehavior.opaque,
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ),
                            ),
                            SizedBox(width: 33),
                            _HeroBadge(
                              label: step.phase,
                              icon: Icons.layers_rounded,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 6),
                      // Status Badge
                      // Container(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 8, vertical: 4),
                      //   decoration: BoxDecoration(
                      //     color: isAllCompleted
                      //         ? const Color(0xFF22C55E).withValues(alpha: 0.25)
                      //         : Colors.white.withValues(alpha: 0.15),
                      //     borderRadius: BorderRadius.circular(20),
                      //     border: Border.all(
                      //       color: isAllCompleted
                      //           ? const Color(0xFF22C55E)
                      //           : Colors.white.withValues(alpha: 0.3),
                      //       width: 1,
                      //     ),
                      //   ),
                      //   child: Row(
                      //     mainAxisSize: MainAxisSize.min,
                      //     children: [
                      //       Icon(
                      //         isAllCompleted
                      //             ? Icons.stars_rounded
                      //             : Icons.bolt_rounded,
                      //         color: isAllCompleted
                      //             ? const Color(0xFF4ADE80)
                      //             : const Color(0xFFFFB703),
                      //         size: 12,
                      //       ),
                      //       const SizedBox(width: 4),
                      //       Text(
                      //         isAllCompleted ? 'Mastered 🎉' : 'In Progress',
                      //         style: TextStyle(
                      //           color: isAllCompleted
                      //               ? const Color(0xFF4ADE80)
                      //               : Colors.white,
                      //           fontSize: 10.5,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Title
                  Text(
                    step.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: -0.4,
                      height: 1.25,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  // Description
                  Text(
                    step.description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.8),
                      height: 1.35,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 14),
                  // Stats row: duration + topics + progress ring
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.schedule_rounded,
                              color: Colors.white,
                              size: 13,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              step.duration,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.checklist_rounded,
                              color: Colors.white,
                              size: 13,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '$totalTopics topics',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 6),
                      _HeroBadge(
                        label: step.level,
                        icon: Icons.bar_chart_rounded,
                        color: levelColor,
                      ),
                      const Spacer(),
                      _ProgressRing(
                        progress: progress,
                        completedCount: completedCount,
                        totalTopics: totalTopics,
                        isAllCompleted: isAllCompleted,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar({
    required BuildContext context,
    required bool isAllCompleted,
    required bool isDark,
    required Color surfaceColor,
    required Color textPrimaryColor,
    required ProgressController progressController,
    required String progressKey,
    required RoadmapStepModel step,
  }) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: MediaQuery.of(context).padding.bottom + 12,
      ),
      decoration: BoxDecoration(
        color: surfaceColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 54,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isAllCompleted
                ? AppColor.success
                : AppColor.primary,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          onPressed: () {
            if (!isAllCompleted) {
              setState(() {
                _completedTopics = List<bool>.filled(
                  widget.step.subtopics.length,
                  true,
                );
              });
              progressController.saveProgress(progressKey, _completedTopics);
              progressController.saveLastOpenedStep(
                widget.roadmapTitle,
                step.id,
              );
              AppSnackBar.show(
                title: '🎉 Step Mastered!',
                message: 'All topics for "${step.title}" are complete!',
                type: SnackBarType.success,
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
                    : Icons.done_all_rounded,
                size: 22,
              ),
              const SizedBox(width: 10),
              Text(
                isAllCompleted
                    ? 'Step Mastered! Back to Roadmap'
                    : 'Mark All Topics Completed',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getLevelColor(String level) {
    final l = level.toLowerCase();
    if (l.contains('beginner')) return const Color(0xFF22C55E);
    if (l.contains('intermediate')) return const Color(0xFFF59E0B);
    if (l.contains('advanced')) return const Color(0xFFEF4444);
    return AppColor.primary;
  }
}

// ─────────────────────────────────────────────────────────────
// TOPICS TAB
// ─────────────────────────────────────────────────────────────
class _TopicsTab extends StatelessWidget {
  final RoadmapStepModel step;
  final List<bool> completedTopics;
  final bool isDark;
  final Color surfaceColor;
  final Color textPrimaryColor;
  final Color textSecondaryColor;
  final Color borderColor;
  final Color bgColor;
  final void Function(int index) onToggle;

  const _TopicsTab({
    required this.step,
    required this.completedTopics,
    required this.isDark,
    required this.surfaceColor,
    required this.textPrimaryColor,
    required this.textSecondaryColor,
    required this.borderColor,
    required this.bgColor,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final completedCount = completedTopics.where((c) => c).length;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      physics: const BouncingScrollPhysics(),
      children: [
        // Learning Objectives Banner
        if (step.learningObjectives != null &&
            step.learningObjectives!.isNotEmpty) ...[
          _ObjectivesBanner(
            objectives: step.learningObjectives!,
            isDark: isDark,
            textPrimaryColor: textPrimaryColor,
            textSecondaryColor: textSecondaryColor,
          ),
          const SizedBox(height: 16),
        ],

        // Section header
        Row(
          children: [
            Expanded(
              child: Text(
                'Topics to Master',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: textPrimaryColor,
                  letterSpacing: -0.3,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color:
                    completedCount == completedTopics.length &&
                        completedTopics.isNotEmpty
                    ? AppColor.success.withValues(alpha: 0.12)
                    : AppColor.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '$completedCount/${completedTopics.length}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color:
                      completedCount == completedTopics.length &&
                          completedTopics.isNotEmpty
                      ? AppColor.success
                      : AppColor.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Topics list
        ...List.generate(step.subtopics.length, (index) {
          final isChecked = completedTopics[index];
          return _TopicItem(
            index: index,
            topic: step.subtopics[index],
            isChecked: isChecked,
            isDark: isDark,
            surfaceColor: surfaceColor,
            textPrimaryColor: textPrimaryColor,
            textSecondaryColor: textSecondaryColor,
            borderColor: borderColor,
            onTap: () => onToggle(index),
          );
        }),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// TOPIC ITEM with number badge
// ─────────────────────────────────────────────────────────────
class _TopicItem extends StatelessWidget {
  final int index;
  final String topic;
  final bool isChecked;
  final bool isDark;
  final Color surfaceColor;
  final Color textPrimaryColor;
  final Color textSecondaryColor;
  final Color borderColor;
  final VoidCallback onTap;

  const _TopicItem({
    required this.index,
    required this.topic,
    required this.isChecked,
    required this.isDark,
    required this.surfaceColor,
    required this.textPrimaryColor,
    required this.textSecondaryColor,
    required this.borderColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          decoration: BoxDecoration(
            color: isChecked
                ? AppColor.primary.withValues(alpha: 0.07)
                : surfaceColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isChecked
                  ? AppColor.primary.withValues(alpha: 0.4)
                  : borderColor,
              width: isChecked ? 1.5 : 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Number / Check badge
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isChecked
                      ? AppColor.primary
                      : isDark
                      ? const Color(0xFF1E293B)
                      : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: isChecked
                      ? const Icon(
                          Icons.check_rounded,
                          size: 18,
                          color: Colors.white,
                        )
                      : Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: textSecondaryColor,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 12),
              // Topic text
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    topic,
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: isChecked ? FontWeight.w500 : FontWeight.w600,
                      color: isChecked ? textSecondaryColor : textPrimaryColor,
                      decoration: isChecked
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      decorationColor: textSecondaryColor,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// OBJECTIVES BANNER
// ─────────────────────────────────────────────────────────────
class _ObjectivesBanner extends StatelessWidget {
  final String objectives;
  final bool isDark;
  final Color textPrimaryColor;
  final Color textSecondaryColor;

  const _ObjectivesBanner({
    required this.objectives,
    required this.isDark,
    required this.textPrimaryColor,
    required this.textSecondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF1E3A5F), const Color(0xFF172235)]
              : [const Color(0xFFE0EFFF), const Color(0xFFEEF7FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? const Color(0xFF2563EB).withValues(alpha: 0.3)
              : const Color(0xFF93C5FD).withValues(alpha: 0.6),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColor.secondary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.emoji_objects_rounded,
              color: AppColor.secondary,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Learning Objectives',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? const Color(0xFF60A5FA)
                        : AppColor.secondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  objectives,
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark
                        ? const Color(0xFFCBD5E1)
                        : const Color(0xFF334155),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// EXERCISES TAB
// ─────────────────────────────────────────────────────────────
class _ExercisesTab extends StatelessWidget {
  final List<String> exercises;
  final bool isDark;
  final Color surfaceColor;
  final Color textPrimaryColor;
  final Color textSecondaryColor;
  final Color borderColor;
  final Color bgColor;

  const _ExercisesTab({
    required this.exercises,
    required this.isDark,
    required this.surfaceColor,
    required this.textPrimaryColor,
    required this.textSecondaryColor,
    required this.borderColor,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    final exerciseColors = [
      const Color(0xFFF97316),
      const Color(0xFF8B5CF6),
      const Color(0xFF06B6D4),
      const Color(0xFF10B981),
      const Color(0xFFF43F5E),
    ];

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      physics: const BouncingScrollPhysics(),
      children: [
        // Header banner
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? [const Color(0xFF2D1B4E), const Color(0xFF172235)]
                  : [const Color(0xFFF3EEFF), const Color(0xFFFAF7FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark
                  ? const Color(0xFF7C3AED).withValues(alpha: 0.3)
                  : const Color(0xFFC4B5FD).withValues(alpha: 0.6),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF8B5CF6).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.code_rounded,
                  color: Color(0xFF8B5CF6),
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Practice Exercises',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? const Color(0xFFA78BFA)
                            : const Color(0xFF6D28D9),
                      ),
                    ),
                    Text(
                      '${exercises.length} hands-on coding challenges',
                      style: TextStyle(fontSize: 12, color: textSecondaryColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Exercise cards
        ...List.generate(exercises.length, (index) {
          final color = exerciseColors[index % exerciseColors.length];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: borderColor),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: color,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Exercise ${index + 1}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: color,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                    // Copy button
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(
                          ClipboardData(text: exercises[index]),
                        );
                        AppSnackBar.show(
                          title: 'Copied to Clipboard',
                          message: 'Exercise prompt copied.',
                          type: SnackBarType.success,
                          duration: const Duration(seconds: 2),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.copy_rounded, color: color, size: 12),
                            const SizedBox(width: 4),
                            Text(
                              'Copy',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  exercises[index],
                  style: TextStyle(
                    fontSize: 13.5,
                    color: textPrimaryColor,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// RESOURCES TAB
// ─────────────────────────────────────────────────────────────
class _ResourcesTab extends StatelessWidget {
  final RoadmapStepModel step;
  final bool isDark;
  final Color surfaceColor;
  final Color textPrimaryColor;
  final Color textSecondaryColor;
  final Color borderColor;
  final Color bgColor;

  const _ResourcesTab({
    required this.step,
    required this.isDark,
    required this.surfaceColor,
    required this.textPrimaryColor,
    required this.textSecondaryColor,
    required this.borderColor,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    final hasResources = step.resources != null && step.resources!.isNotEmpty;

    if (!hasResources) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.link_off_rounded,
              size: 56,
              color: textSecondaryColor.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 12),
            Text(
              'No resources added yet',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: textSecondaryColor,
              ),
            ),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      physics: const BouncingScrollPhysics(),
      children: [
        // Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E293B) : AppColor.lightBlue,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Icon(Icons.bookmark_rounded, color: AppColor.secondary, size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  '${step.resources!.length} recommended resources for this topic',
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark
                        ? const Color(0xFF93C5FD)
                        : AppColor.secondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Resource cards
        ...step.resources!.map((resString) {
          final parts = resString.split(': http');
          final title = parts[0].trim();
          final url = parts.length > 1 ? 'http${parts[1]}'.trim() : '';

          // Detect type & icon
          final lowerUrl = url.toLowerCase();
          final lowerTitle = title.toLowerCase();

          IconData icon = Icons.description_rounded;
          Color color = AppColor.secondary;
          String typeTag = 'Docs';

          if (lowerUrl.contains('youtube') ||
              lowerUrl.contains('video') ||
              lowerTitle.contains('video')) {
            icon = Icons.ondemand_video_rounded;
            color = const Color(0xFFEF4444);
            typeTag = 'Video';
          } else if (lowerUrl.contains('github') ||
              lowerUrl.contains('code') ||
              lowerUrl.contains('dartpad')) {
            icon = Icons.code_rounded;
            color = const Color(0xFF10B981);
            typeTag = 'Interactive Code';
          } else if (lowerTitle.contains('guide') ||
              lowerTitle.contains('tutorial')) {
            icon = Icons.school_rounded;
            color = const Color(0xFF8B5CF6);
            typeTag = 'Tutorial';
          }

          return GestureDetector(
            onTap: () {
              if (url.isNotEmpty) {
                Get.to(() => WebViewScreen(url: url, title: title));
              }
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: borderColor),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(icon, color: color, size: 22),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: color.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                typeTag,
                                style: TextStyle(
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.bold,
                                  color: color,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: textPrimaryColor,
                            height: 1.3,
                          ),
                        ),
                        if (url.isNotEmpty) ...[
                          const SizedBox(height: 3),
                          Text(
                            url,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 11, color: color),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.open_in_new_rounded,
                      color: color,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// NOTES TAB
// ─────────────────────────────────────────────────────────────
class _NotesTab extends StatelessWidget {
  final RoadmapStepModel step;
  final String roadmapTitle;
  final NoteController noteController;
  final bool isDark;
  final Color surfaceColor;
  final Color textPrimaryColor;
  final Color textSecondaryColor;
  final Color borderColor;
  final Color bgColor;
  final VoidCallback onAddNote;
  final void Function(NoteModel note) onEditNote;

  const _NotesTab({
    required this.step,
    required this.roadmapTitle,
    required this.noteController,
    required this.isDark,
    required this.surfaceColor,
    required this.textPrimaryColor,
    required this.textSecondaryColor,
    required this.borderColor,
    required this.bgColor,
    required this.onAddNote,
    required this.onEditNote,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final stepNotes = noteController.getNotesForStep(roadmapTitle, step.id);

      return ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        physics: const BouncingScrollPhysics(),
        children: [
          // Add Note button
          GestureDetector(
            onTap: onAddNote,
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColor.primary.withValues(alpha: 0.4),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(16),
                color: AppColor.primary.withValues(alpha: 0.05),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColor.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add_rounded,
                      color: AppColor.primary,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Add a note for this step',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColor.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (stepNotes.isEmpty) ...[
            const SizedBox(height: 40),
            Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF1E293B)
                          : const Color(0xFFF8FAFC),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.sticky_note_2_outlined,
                      size: 44,
                      color: textSecondaryColor.withValues(alpha: 0.5),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No notes yet',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: textPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Tap above to save key insights,\nreminders, or summaries.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: textSecondaryColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            ...stepNotes.map((note) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: borderColor),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: isDark ? 0.2 : 0.04,
                      ),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: AppColor.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.sticky_note_2_rounded,
                            color: AppColor.primary,
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            note.title,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: textPrimaryColor,
                            ),
                          ),
                        ),
                        // Edit button
                        GestureDetector(
                          onTap: () => onEditNote(note),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            margin: const EdgeInsets.only(left: 4),
                            decoration: BoxDecoration(
                              color: AppColor.secondary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.edit_outlined,
                              color: AppColor.secondary,
                              size: 15,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        // Delete button
                        GestureDetector(
                          onTap: () => noteController.deleteNote(note.id),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEF4444)
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.delete_outline_rounded,
                              color: Color(0xFFEF4444),
                              size: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: borderColor,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      note.content,
                      style: TextStyle(
                        fontSize: 13.5,
                        color: textSecondaryColor,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ],
      );
    });
  }
}

// ─────────────────────────────────────────────────────────────
// HERO BADGE
// ─────────────────────────────────────────────────────────────
class _HeroBadge extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color? color;

  const _HeroBadge({required this.label, required this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color != null
            ? color!.withValues(alpha: 0.2)
            : Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color != null
              ? color!.withValues(alpha: 0.4)
              : Colors.white.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color ?? Colors.white, size: 12),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                color: color ?? Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// CIRCULAR PROGRESS RING
// ─────────────────────────────────────────────────────────────
class _ProgressRing extends StatelessWidget {
  final double progress;
  final int completedCount;
  final int totalTopics;
  final bool isAllCompleted;

  const _ProgressRing({
    required this.progress,
    required this.completedCount,
    required this.totalTopics,
    required this.isAllCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 58,
      height: 58,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(58, 58),
            painter: _RingPainter(
              progress: progress,
              isCompleted: isAllCompleted,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${(progress * 100).toInt()}%',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final bool isCompleted;

  _RingPainter({required this.progress, required this.isCompleted});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 6) / 2;
    const strokeWidth = 4.0;

    // Background ring
    final bgPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    // Progress arc
    final progressPaint = Paint()
      ..color = isCompleted ? const Color(0xFF22C55E) : AppColor.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_RingPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.isCompleted != isCompleted;
}
