class RoadmapStepModel {
  final int id;
  final String title;
  final String description;
  final String duration;
  final List<String> subtopics;
  final List<String>? resources;
  final String phase;
  final String level;
  final String? learningObjectives;
  final List<String>? exercises;

  RoadmapStepModel({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    this.subtopics = const [],
    this.resources = const [],
    this.phase = 'Fundamentals',
    this.level = 'Beginner',
    this.learningObjectives,
    this.exercises,
  });
}
