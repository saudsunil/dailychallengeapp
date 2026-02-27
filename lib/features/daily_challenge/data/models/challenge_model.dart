import '../../domain/entities/challenge.dart';

class ChallengeModel extends Challenge {
  ChallengeModel({
    required super.id,
    required super.title,
    required super.categoryName,
    required super.emoji,
    required super.difficulty,
    required super.completed,
  });

  factory ChallengeModel.fromJson(Map<String, dynamic> json) {
    return ChallengeModel(
      id: json["id"],
      title: json["title"],
      categoryName: json["category"]["name"],
      emoji: json["category"]["emoji"],
      difficulty: json["difficulty"],
      completed: json["completed"],
    );
  }
}