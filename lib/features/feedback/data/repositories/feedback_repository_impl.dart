import '../../domain/entities/feedback.dart';
import '../../domain/repositories/feedback_repository.dart';
import '../datasources/feedback_remote_datasource.dart';
import '../models/feedback_model.dart';


class FeedbackRepositoryImpl implements FeedbackRepository{
  final FeedbackRemoteDataSource remote;

  FeedbackRepositoryImpl(this.remote);

  @override
  Future<void> submitFeedback(Feedback feedback) async{
    final model= FeedbackModel(
      title: feedback.title,
      satisfaction: feedback.satisfaction,
      description: feedback.description,
      userId: feedback.userId,
    );
    await remote.submitFeedback(model);
  }
}