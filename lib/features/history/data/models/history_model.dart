import '../../domain/entities/history.dart';

class HistoryModel extends History {
  HistoryModel({
    required String title,
    required String categoryName,
    required String categoryEmoji,
    required bool completed,
    required DateTime date,
  }) : super(
          title: title,
          categoryName: categoryName,
          categoryEmoji: categoryEmoji,
          completed: completed,
          date: date,
        );

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      title: json['title'] ?? '',
      categoryName: json['category']?['name'] ?? '',
      categoryEmoji: json['category']?['emoji'] ?? '',
      completed: json['status'] == 'completed',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
    );
  }
}