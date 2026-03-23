import '../entities/feedback.dart';
import '../repositories/feedback_repository.dart';


class SubmitFeedback{
  final FeedbackRepository repository;

  SubmitFeedback(this.repository);

  Future<void> call(Feedback feedback){
    return repository.submitFeedback( feedback);
  }
}