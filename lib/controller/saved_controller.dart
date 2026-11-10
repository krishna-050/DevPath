
import 'package:dev_path/models/roadmap_model.dart';
import 'package:get/get.dart';

class SavedController extends GetxController {

  RxList<RoadmapModel> savedRoadmaps = <RoadmapModel>[].obs;

  void addToSaved(RoadmapModel roadmap) {
    if(!isSaved(roadmap)){
      savedRoadmaps.add(roadmap);
    }

  }
  void removeFromSaved(RoadmapModel roadmap) {
    savedRoadmaps.removeWhere(
            (item) => item.id == roadmap.id
    );
  }

  bool isSaved(RoadmapModel roadmap) {
    return savedRoadmaps.any(
            (item) => item.id == roadmap.id
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