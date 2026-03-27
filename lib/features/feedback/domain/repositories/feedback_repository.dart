import 'package:dailychallengeapp/features/feedback/data/models/feedback_response_model.dart';

import '../entities/feedback.dart';

abstract class FeedbackRepository{
  Future<FeedbackResponseModel> submitFeedback(Feedback feedback);
}