import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dev_path/models/roadmap_step_model.dart';

class ProgressController extends GetxController{

  final box = GetStorage();

  void saveProgress(String key,List<bool> completedTopics){

    box.write(key, completedTopics);

  }

  List<bool> loadProgress(String key, int totalTopics){
    final saveTopics =box.read(key);

    if(saveTopics==null|| saveTopics is! List){

      return List<bool>.filled(totalTopics, false);

    }
    return List<bool>.generate(
      totalTopics,(index)=>index <saveTopics.length ? saveTopics[index] == true : false,
    );
  }


// Get total completed topics across the roadmap
  int getCompletedTopicCount(
      String roadmapTitle,
      List<RoadmapStepModel> steps,
      ) {
    int completedCount = 0;

    for (final step in steps) {
      final completedTopics = loadProgress(
        '${roadmapTitle}_${step.id}',
        step.subtopics.length,
      );

      completedCount += completedTopics
          .where((completed) => completed)
          .length;
    }

    return completedCount;
  }

// Get total topics across the roadmap
  int getTotalTopicCount(List<RoadmapStepModel> steps) {
    int totalCount = 0;

    for (final step in steps) {
      totalCount += step.subtopics.length;
    }

    return totalCount;
  }


}