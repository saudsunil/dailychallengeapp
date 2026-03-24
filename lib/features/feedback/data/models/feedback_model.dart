class FeedbackModel{
  final String title;
  final String satisfaction;
  final String description;
  final String userId;

  FeedbackModel({
    required this.title,
    required this.satisfaction,
    required this.description,
    required this.userId,
  });


Map<String, dynamic> toJson(){
  return{
    "title": title,
    "satisfaction": satisfaction,
    "description": description,
    "user_id": userId,
  };
}}