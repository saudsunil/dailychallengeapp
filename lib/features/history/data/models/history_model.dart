import '../../domain/entities/history.dart';

class HistoryModel extends History {
  HistoryModel({
    required super.title,
    required super.categoryName,
    required super.categoryEmoji,
    required super.completed,
    required super.date,
  });

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