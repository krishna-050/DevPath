import 'package:dev_path/models/roadmap_model.dart';

class RoadmapData {
  static final List<RoadmapModel> roadmaps = [
    RoadmapModel(
      id: 1,
      language: 'Flutter',
      description: 'Build beautiful apps for mobile, web and desktop.',
      imgUrl: 'assets/images/flutter.jpg',
      duration: '6-8 months',
      level: 'Beginner to Advanced',
      category: 'Mobile',
    ),
    RoadmapModel(
      id: 2,
      language: 'Web Development',
      description: 'Learn HTML, CSS, JS and modern frameworks.',
      imgUrl: 'assets/images/web.webp',
      duration: '6-12 months',
      level: 'Beginner to Advanced',
      category: 'Frontend',
    ),
    RoadmapModel(
      id: 3,
      language: 'Python',
      description: 'From basics to advanced Python concepts.',
      imgUrl: 'assets/images/python.webp',
      duration: '3-6 months',
      level: 'Beginner to Advanced',
      category: 'Backend',
    ),
    RoadmapModel(
      id: 4,
      language: 'React',
      description: 'Build modern and interactive UIs.',
      imgUrl: 'assets/images/react.webp',
      duration: '4-8 months',
      level: 'Intermediate',
      category: 'Frontend',
    ),
    RoadmapModel(
      id: 5,
      language: 'Java',
      description: 'Learn Java and OOP concepts.',
      imgUrl: 'assets/images/app_icon.png',
      duration: '4-8 months',
      level: 'Intermediate',
      category: 'Backend',
    ),
  ];
}

