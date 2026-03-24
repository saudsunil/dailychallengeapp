import 'package:dailychallengeapp/features/feedback/data/models/feedback_response_model.dart';

import '../entities/feedback.dart';
import '../repositories/feedback_repository.dart';


class SubmitFeedback{
  final FeedbackRepository repository;

  SubmitFeedback(this.repository);

  Future<FeedbackResponseModel> call(Feedback feedback){
    return repository.submitFeedback(feedback);
  }
}