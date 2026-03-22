import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/category.dart';

part 'onboarding_state.freezed.dart';

@freezed
class OnboardingState with _$OnboardingState {
  const factory OnboardingState.initial() = _Initial;

  const factory OnboardingState.loading() = _Loading;

  const factory OnboardingState.loaded({
    required List<Category> categories,
    required List<int> selectedIds,
  }) = _Loaded;

  const factory OnboardingState.error(String message) = _Error;

  const factory OnboardingState.success() = _Success;
}