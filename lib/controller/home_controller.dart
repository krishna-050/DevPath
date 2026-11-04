import 'package:dev_path/data/roadmap_data.dart';
import 'package:dev_path/models/roadmap_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  @override
  void onInit(){
    super.onInit();
    roadmapList.assignAll(RoadmapData.roadmaps);
  }
  RxList<RoadmapModel> roadmapList = <RoadmapModel>[
  ].obs;

}