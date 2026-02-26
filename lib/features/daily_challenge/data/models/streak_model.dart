import '../../domain/entities/streak.dart';

class StreakModel extends Streak {
  StreakModel({
    required super.currentStreak,
    required super.longestStreak,
  });

  factory StreakModel.fromJson(Map<String, dynamic> json) {
    return StreakModel(
      currentStreak: json["current_streak"],
      longestStreak: json["longest_streak"],
    );
  }
}