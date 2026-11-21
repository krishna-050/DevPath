import 'package:dev_path/Widgets/app_snackbar.dart';
import 'package:dev_path/app/theme/app_color.dart';
import 'package:dev_path/controller/note_controller.dart';
import 'package:dev_path/models/note_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyNotesScreen extends StatefulWidget {
  const MyNotesScreen({super.key});

  @override
  State<MyNotesScreen> createState() => _MyNotesScreenState();
}

class _MyNotesScreenState extends State<MyNotesScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _formatDate(String isoString) {
    try {
      final date = DateTime.parse(isoString);
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      return '${date.day} ${months[date.month - 1]} ${date.year}';
    } catch (e) {
      return isoString;
    }
  }

  void _showNoteDialog({
    required BuildContext context,
    required NoteController noteController,
    NoteModel? existingNote,
    String defaultRoadmapTitle = 'General',
    int defaultStepId = 0,
    String defaultStepTitle = 'General Note',
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
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            top: 20,
            left: 20,
            right: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    existingNote == null ? 'Create Personal Note' : 'Edit Note',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textPrimaryColor,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close_rounded, color: textSecondaryColor),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                controller: titleController,
                style: TextStyle(color: textPrimaryColor, fontSize: 15),
                decoration: InputDecoration(
                  hintText: 'Note Title (e.g. Key Concept / Code Snippet)',
                  hintStyle: TextStyle(color: textSecondaryColor, fontSize: 13),
                  filled: true,
                  fillColor: isDark
                      ? const Color(0xFF0B1220)
                      : AppColor.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: contentController,
                maxLines: 4,
                style: TextStyle(color: textPrimaryColor, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Write your notes or reminders here...',
                  hintStyle: TextStyle(color: textSecondaryColor, fontSize: 13),
                  filled: true,
                  fillColor: isDark
                      ? const Color(0xFF0B1220)
                      : AppColor.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    final title = titleController.text.trim();
                    final content = contentController.text.trim();

                    if (title.isEmpty || content.isEmpty) {
                      AppSnackBar.show(
                        title: 'Missing Information',
                        message: 'Please enter both title and content for your note.',
                        type: SnackBarType.warning,
                      );
                      return;
                    }

                    if (existingNote == null) {
                      noteController.addNote(
                        roadmapTitle: defaultRoadmapTitle,
                        stepId: defaultStepId,
                        stepTitle: defaultStepTitle,
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
                  child: Text(
                    existingNote == null ? 'Save Note' : 'Update Note',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
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
    final noteController = Get.isRegistered<NoteController>()
        ? Get.find<NoteController>()
        : Get.put(NoteController());

    final bgColor = isDark ? const Color(0xFF0B1220) : AppColor.background;
    final surfaceColor = isDark ? const Color(0xFF172235) : AppColor.surface;
    final textPrimaryColor = isDark ? Colors.white : AppColor.textPrimary;
    final textSecondaryColor = isDark
        ? const Color(0xFF94A3B8)
        : AppColor.textSecondary;
    final borderColor = isDark ? const Color(0xFF334155) : AppColor.border;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bgColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: textPrimaryColor),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'My Learning Notes',
          style: TextStyle(
            color: textPrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColor.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'New Note',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          _showNoteDialog(context: context, noteController: noteController);
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                controller: _searchController,
                onChanged: (val) {
                  noteController.searchQuery.value = val;
                },
                style: TextStyle(color: textPrimaryColor, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Search notes by title or content...',
                  hintStyle: TextStyle(color: textSecondaryColor, fontSize: 13),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: isDark
                        ? const Color(0xFF60A5FA)
                        : AppColor.secondary,
                  ),
                  suffixIcon: Obx(() {
                    if (noteController.searchQuery.value.isNotEmpty) {
                      return IconButton(
                        icon: Icon(
                          Icons.close_rounded,
                          color: textSecondaryColor,
                        ),
                        onPressed: () {
                          _searchController.clear();
                          noteController.searchQuery.value = '';
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  }),
                  filled: true,
                  fillColor: surfaceColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: borderColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: borderColor),
                  ),
                ),
              ),
            ),

            // Notes List
            Expanded(
              child: Obx(() {
                final filteredList = noteController.filteredNotes;

                if (filteredList.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xFF1E293B)
                                  : AppColor.lightBlue,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.edit_note_rounded,
                              size: 48,
                              color: isDark
                                  ? const Color(0xFF60A5FA)
                                  : AppColor.secondary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            noteController.searchQuery.value.isNotEmpty
                                ? 'No matching notes found'
                                : 'No Personal Notes Yet',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: textPrimaryColor,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Save key code snippets, explanations, and reminders while completing steps.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              color: textSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final note = filteredList[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: surfaceColor,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: borderColor),
                        boxShadow: [
                          BoxShadow(
                            color: textPrimaryColor.withValues(alpha: 0.03),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Roadmap & Step Badge
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? const Color(0xFF1E293B)
                                      : AppColor.lightBlue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  note.stepId > 0
                                      ? '${note.roadmapTitle} • Step ${note.stepId}'
                                      : note.roadmapTitle,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: isDark
                                        ? const Color(0xFF60A5FA)
                                        : AppColor.secondary,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit_outlined,
                                      size: 18,
                                      color: AppColor.primary,
                                    ),
                                    onPressed: () {
                                      _showNoteDialog(
                                        context: context,
                                        noteController: noteController,
                                        existingNote: note,
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete_outline_rounded,
                                      size: 18,
                                      color: Color(0xFFEF4444),
                                    ),
                                    onPressed: () {
                                      Get.dialog(
                                        AlertDialog(
                                          backgroundColor: surfaceColor,
                                          title: Text(
                                            'Delete Note',
                                            style: TextStyle(
                                              color: textPrimaryColor,
                                            ),
                                          ),
                                          content: Text(
                                            'Are you sure you want to delete "${note.title}"?',
                                            style: TextStyle(
                                              color: textSecondaryColor,
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text(
                                                'Cancel',
                                                style: TextStyle(
                                                  color: textSecondaryColor,
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                noteController.deleteNote(
                                                  note.id,
                                                );
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                'Delete',
                                                style: TextStyle(
                                                  color: Color(0xFFEF4444),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            note.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: textPrimaryColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            note.content,
                            style: TextStyle(
                              fontSize: 13,
                              color: textSecondaryColor,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Saved on ${_formatDate(note.createdAt)}',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: textSecondaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
