class FeedbackResponseModel{
  final String status;
  final String message;

  FeedbackResponseModel({
    required this.status,
    required this.message,
  });

  factory FeedbackResponseModel.fromJson(Map<String, dynamic> json){
    return FeedbackResponseModel(
      status: json["status"],
      message: json["message"],
    );
  }
}