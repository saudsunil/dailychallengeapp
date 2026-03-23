import '../entities/feedback.dart';

abstract class FeedbackRepository{
  Future<void> submitFeedback(Feedback feedback);
}