import 'package:dev_path/models/note_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class NoteController extends GetxController {
  final box = GetStorage();
  static const String _notesStorageKey = 'personal_notes_list';

  final RxList<NoteModel> notes = <NoteModel>[].obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadNotes();
  }

  void loadNotes() {
    final rawData = box.read(_notesStorageKey);
    if (rawData != null && rawData is List) {
      final loadedList = rawData
          .map((item) {
            if (item is Map) {
              return NoteModel.fromJson(Map<String, dynamic>.from(item));
            }
            return null;
          })
          .whereType<NoteModel>()
          .toList();

      notes.assignAll(loadedList);
    }
  }

  void saveNotesToStorage() {
    final jsonList = notes.map((note) => note.toJson()).toList();
    box.write(_notesStorageKey, jsonList);
  }

  void addNote({
    required String roadmapTitle,
    required int stepId,
    required String stepTitle,
    required String title,
    required String content,
  }) {
    final nowIso = DateTime.now().toIso8601String();
    final newNote = NoteModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      roadmapTitle: roadmapTitle,
      stepId: stepId,
      stepTitle: stepTitle,
      title: title,
      content: content,
      createdAt: nowIso,
      updatedAt: nowIso,
    );

    notes.insert(0, newNote);
    saveNotesToStorage();

    Get.snackbar(
      'Note Created',
      'Personal learning note saved successfully.',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  void updateNote({
    required String id,
    required String title,
    required String content,
  }) {
    final index = notes.indexWhere((note) => note.id == id);
    if (index != -1) {
      final oldNote = notes[index];
      final updatedNote = NoteModel(
        id: oldNote.id,
        roadmapTitle: oldNote.roadmapTitle,
        stepId: oldNote.stepId,
        stepTitle: oldNote.stepTitle,
        title: title,
        content: content,
        createdAt: oldNote.createdAt,
        updatedAt: DateTime.now().toIso8601String(),
      );

      notes[index] = updatedNote;
      saveNotesToStorage();

      Get.snackbar(
        'Note Updated',
        'Personal learning note updated.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

  void deleteNote(String id) {
    notes.removeWhere((note) => note.id == id);
    saveNotesToStorage();

    Get.snackbar(
      'Note Deleted',
      'Note removed from your collection.',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  List<NoteModel> getNotesForStep(String roadmapTitle, int stepId) {
    return notes
        .where((note) =>
            note.roadmapTitle.toLowerCase() == roadmapTitle.toLowerCase() &&
            note.stepId == stepId)
        .toList();
  }

  List<NoteModel> get filteredNotes {
    if (searchQuery.value.trim().isEmpty) {
      return notes;
    }
    final query = searchQuery.value.toLowerCase().trim();
    return notes.where((note) {
      return note.title.toLowerCase().contains(query) ||
          note.content.toLowerCase().contains(query) ||
          note.roadmapTitle.toLowerCase().contains(query) ||
          note.stepTitle.toLowerCase().contains(query);
    }).toList();
  }
}
