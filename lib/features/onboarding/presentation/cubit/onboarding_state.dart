import '../../domain/entities/category.dart';

abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {}

class OnboardingLoading extends OnboardingState {}

class OnboardingLoaded extends OnboardingState {
  final List<Category> categories;
  final List<int> selectedIds;

  OnboardingLoaded({
    required this.categories,
    required this.selectedIds,
  });
}

class OnboardingError extends OnboardingState {
  final String message;

  OnboardingError(this.message);
}