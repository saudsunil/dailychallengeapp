import '../entities/feedback.dart';
import '../repositories/feedback_repository.dart';


class SubmitFeedback{
  final FeedbackRepository repository;

  SubmitFeedback(this.repository);

  Future<Map<String, dynamic>> call(Feedback feedback){
    return repository.submitFeedback(feedback);
  }
}