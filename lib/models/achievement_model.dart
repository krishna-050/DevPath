class AchievementModel {
  final String id;
  final String title;
  final String description;
  final String iconEmoji;
  final int targetValue;
  final String type; // 'topic', 'streak', 'roadmap'

  const AchievementModel({
    required this.id,
    required this.title,
    required this.description,
    required this.iconEmoji,
    required this.targetValue,
    required this.type,
  });

  static const List<AchievementModel> allAchievements = [
    AchievementModel(
      id: 'first_step',
      title: 'First Step',
      description: 'Complete your first topic.',
      iconEmoji: '🎯',
      targetValue: 1,
      type: 'topic',
    ),
    AchievementModel(
      id: 'getting_started',
      title: 'Getting Started',
      description: 'Complete 10 topics.',
      iconEmoji: '🚀',
      targetValue: 10,
      type: 'topic',
    ),
    AchievementModel(
      id: 'consistent_learner',
      title: 'Consistent Learner',
      description: 'Reach a 3-day streak.',
      iconEmoji: '🔥',
      targetValue: 3,
      type: 'streak',
    ),
    AchievementModel(
      id: 'week_warrior',
      title: 'Week Warrior',
      description: 'Reach a 7-day streak.',
      iconEmoji: '⚔️',
      targetValue: 7,
      type: 'streak',
    ),
    AchievementModel(
      id: 'roadmap_explorer',
      title: 'Roadmap Explorer',
      description: 'Complete your first roadmap.',
      iconEmoji: '🏆',
      targetValue: 1,
      type: 'roadmap',
    ),
    AchievementModel(
      id: 'knowledge_master',
      title: 'Knowledge Master',
      description: 'Complete 100 topics.',
      iconEmoji: '👑',
      targetValue: 100,
      type: 'topic',
    ),
  ];
}
