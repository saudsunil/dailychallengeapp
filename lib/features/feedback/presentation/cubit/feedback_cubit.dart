import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/feedback.dart';
import '../../domain/usecases/submit_feedback.dart';
import 'feedback_state.dart';


class FeedbackCubit extends Cubit<FeedbackState>{
  final SubmitFeedback submitFeedback;

  FeedbackCubit(this.submitFeedback)
      : super(const FeedbackState.initial());

  Future<void> submit({
    required String title,
    required String satisfaction,
    required String description,
    required String userId,
  }) async{
       try{
    emit(const FeedbackState.loading());

 
      final feedback= Feedback(
        title: title,
        satisfaction: satisfaction,
        description: description,
        userId: userId,
      );
      await submitFeedback(feedback);

      emit(const FeedbackState.success());
    } catch(e){
      emit(FeedbackState.error(e.toString()));
    }
  }
}