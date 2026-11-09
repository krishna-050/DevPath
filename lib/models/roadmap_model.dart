class RoadmapModel {
  final int id;
  final String language;
  final String description;
  final String imgUrl;
  final String duration;
  final String category;
  final String level;

  RoadmapModel({
    required this.id,
    required this.language,
    required this.description,
    required this.imgUrl,
    required this.duration,
    required this.category,
    this.level = 'Beginner to Advanced',
  });
}