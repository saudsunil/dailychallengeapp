import '../../domain/entities/history.dart';

class HistoryModel extends History {
  HistoryModel({
    required int id,
    required String title,
    required String category,
    required bool completed,
    required String week,
    required String month,
  }) : super(
          id: id,
          title: title,
          category: category,
          completed: completed,
          week: week,
          month: month,
        );

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      id: json["id"],
      title: json["title"],
      category: json["category"],
      completed: json["completed"],
      week: json["week"],
      month: json["month"],
    );
  }
}