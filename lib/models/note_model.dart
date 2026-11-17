class NoteModel {
  final String id;
  final String roadmapTitle;
  final int stepId;
  final String stepTitle;
  final String title;
  final String content;
  final String createdAt;
  final String updatedAt;

  NoteModel({
    required this.id,
    required this.roadmapTitle,
    required this.stepId,
    required this.stepTitle,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roadmapTitle': roadmapTitle,
      'stepId': stepId,
      'stepTitle': stepTitle,
      'title': title,
      'content': content,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'] as String? ?? '',
      roadmapTitle: json['roadmapTitle'] as String? ?? '',
      stepId: json['stepId'] as int? ?? 0,
      stepTitle: json['stepTitle'] as String? ?? '',
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
    );
  }
}
