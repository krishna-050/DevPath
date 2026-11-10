import 'package:dev_path/data/roadmap_data.dart';
import 'package:dev_path/models/roadmap_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  @override

  RxList<RoadmapModel> roadmapList = <RoadmapModel>[
  ].obs;
  RxString searchQuery = ''.obs;

  void onInit(){
    super.onInit();
    roadmapList.assignAll(RoadmapData.roadmaps);
  }
  // Update search query
  void searchRoadmap(String value){
    searchQuery.value =value;
  }

  List <RoadmapModel> get filteredRoadmaps{
    final query = searchQuery.value.toLowerCase().trim();

    if(query.isEmpty){
      return roadmapList;
    }
    return roadmapList.where((roadmap) {
      return roadmap.language.toLowerCase().contains(query) ||
          roadmap.category.toLowerCase().contains(query) ||
          roadmap.description.toLowerCase().contains(query);
    }).toList();
  }

}