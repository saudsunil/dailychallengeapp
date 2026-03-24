import '../entities/feedback.dart';

abstract class FeedbackRepository{
  Future<Map<String,dynamic>> submitFeedback(Feedback feedback);
}