class Challenge {
  final int id;
  final String title;
  final String categoryName;
  final String emoji;
  final String difficulty;
  final bool completed;

  Challenge({
    required this.id,
    required this.title,
    required this.categoryName,
    required this.emoji,
    required this.difficulty,
    required this.completed,
  });
}