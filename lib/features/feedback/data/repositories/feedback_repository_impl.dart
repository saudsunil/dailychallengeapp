import 'package:dailychallengeapp/features/feedback/data/models/feedback_response_model.dart';

import '../../domain/entities/feedback.dart';
import '../../domain/repositories/feedback_repository.dart';
import '../datasources/feedback_remote_datasource.dart';
import '../models/feedback_model.dart';


class FeedbackRepositoryImpl implements FeedbackRepository{
  final FeedbackRemoteDataSource remote;

  FeedbackRepositoryImpl(this.remote);

  @override
  Future<FeedbackResponseModel> submitFeedback(Feedback feedback) async{
    final model= FeedbackModel(
      title: feedback.title,
      satisfaction: feedback.satisfaction,
      description: feedback.description,
      userId: feedback.userId,
    );
    return await remote.submitFeedback(model);// pass response
  }
}