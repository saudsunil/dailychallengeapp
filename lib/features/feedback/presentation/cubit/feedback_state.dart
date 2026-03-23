import 'package:freezed_annotation/freezed_annotation.dart';

part 'feedback_state.freezed.dart';

@freezed
class FeedbackState with _$FeedbackState{
  const factory FeedbackState.initial()= _Initial;
  const factory FeedbackState.loading()= _Loading;
  const factory FeedbackState.success()= _Success;
  const factory FeedbackState.error(String message)= _Error;
}