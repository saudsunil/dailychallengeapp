import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_categories.dart';
import '../../domain/usecases/save_preferences.dart';
import 'onboarding_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final GetCategories getCategories;
  final SavePreferences savePreferences;

  List<int> selectedIds = [];

  OnboardingCubit(
    this.getCategories,
    this.savePreferences,
  ) : super(OnboardingInitial()) {
    loadCategories();
  }

  void loadCategories() async {
    try {
      emit(OnboardingLoading());

      final categories = await getCategories();

      emit(OnboardingLoaded(
        categories: categories,
        selectedIds: selectedIds,
      ));
    } catch (e) {
      emit(OnboardingError(e.toString()));
    }
  }

  void toggleSelection(int id) {
    if (selectedIds.contains(id)) {
      selectedIds.remove(id);
    } else {
      selectedIds.add(id);
    }

    if (state is OnboardingLoaded) {
      final current = state as OnboardingLoaded;

      emit(OnboardingLoaded(
        categories: current.categories,
        selectedIds: selectedIds,
      ));
    }
  }
Future<void> submit() async {
  if (state is OnboardingLoaded) {
    final currentState = state as OnboardingLoaded;

    emit(OnboardingLoading());

    try {
      final userId =
          await savePreferences(currentState.selectedIds);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("user_id", userId);

      emit(OnboardingSuccess()); // 🔥 important
    } catch (e) {
      emit(OnboardingError(e.toString()));
    }
  }
}}