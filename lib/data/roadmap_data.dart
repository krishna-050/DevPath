import 'package:dev_path/models/roadmap_model.dart';

class RoadmapData {
  static final List<RoadmapModel> roadmaps = [
    RoadmapModel(
      id: 1,
      language: 'Flutter',
      description: 'Build beautiful cross-platform mobile apps.',
      imgUrl: 'assets/images/flutter.jpg',
      duration: '6-8 months',
      category: 'App Development',
    ),
    RoadmapModel(
      id: 2,
      language: 'Web Development',
      description: 'Learn HTML, CSS, JavaScript and build websites.',
      imgUrl: 'assets/images/web.webp',
      duration: '2-3 months',
      category: 'Web Development',
    ),
    RoadmapModel(
      id: 3,
      language: 'Python',
      description: 'Learn Python from basics to advanced concepts.',
      imgUrl: 'assets/images/python.webp',
      duration: '3-6 months',
      category: 'Programming',
    ),
    RoadmapModel(
      id: 4,
      language: 'React',
      description: 'Build modern web applications using React.',
      imgUrl: 'assets/images/react.webp',
      duration: '4-6 months',
      category: 'Web Development',
    ),
  ];
}
