
import 'package:dev_path/models/roadmap_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SavedController extends GetxController {
  final GetStorage box = GetStorage();

  final RxList<RoadmapModel> savedRoadmaps =
      <RoadmapModel>[].obs;

  static const String savedKey = 'saved_roadmap_ids';

  // Load saved roadmaps from local storage
  void loadSavedRoadmaps(List<RoadmapModel> allRoadmaps) {
    final List<dynamic> savedIds =
        box.read(savedKey) ?? [];

    final savedList = allRoadmaps.where(
          (roadmap) => savedIds.contains(roadmap.id),
    ).toList();

    savedRoadmaps.assignAll(savedList);
  }

  // Save roadmap IDs to local storage
  void saveToStorage() {
    final savedIds = savedRoadmaps
        .map((roadmap) => roadmap.id)
        .toList();

    box.write(savedKey, savedIds);
  }

  void addToSaved(RoadmapModel roadmap) {
    if (!isSaved(roadmap)) {
      savedRoadmaps.add(roadmap);
      saveToStorage();
    }
  }

  void removeFromSaved(RoadmapModel roadmap) {
    savedRoadmaps.removeWhere(
          (item) => item.id == roadmap.id,
    );

    saveToStorage();
  }

  bool isSaved(RoadmapModel roadmap) {
    return savedRoadmaps.any(
          (item) => item.id == roadmap.id,
    );
  }

  void toggleSaved(RoadmapModel roadmap) {
    if (isSaved(roadmap)) {
      removeFromSaved(roadmap);
    } else {
      addToSaved(roadmap);
    }
  }
}
