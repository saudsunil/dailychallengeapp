import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_categories.dart';
import '../../domain/usecases/save_preferences.dart';
import 'onboarding_state.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OnboardingCubit extends Cubit<OnboardingState> {
  final GetCategories getCategories;
  final SavePreferences savePreferences;



  OnboardingCubit(
    this.getCategories,
    this.savePreferences,
  ) : super(const OnboardingState.initial()) {
    loadCategories();
  }

  void loadCategories() async {
    try {
      emit(const OnboardingState.loading());

      final categories = await getCategories();

      emit(OnboardingState.loaded(
        categories: categories,
        selectedIds: [],
      ));
    } catch (e) {
      emit(OnboardingState.error(e.toString()));
    }
  }


  void toggleSelection(int id) {
    state.maybeWhen(
      loaded: (categories, selectedIds){
        final updated = List<int>.from(selectedIds);

    if (updated.contains(id)) {
      updated.remove(id);
    } else {
      updated.add(id);
    }


    emit(OnboardingState.loaded(
      categories: categories,
      selectedIds: updated,
    ));
  },
  orElse: () {},
);
  }

Future<void> submit() async {
 state.maybeWhen(
  loaded: (_, selectedIds) async {
    emit(const OnboardingState.loading());

    try {
      final userId = await savePreferences(selectedIds);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("user_id", userId);

      emit(const OnboardingState.success());
    } catch (e) {
      emit(OnboardingState.error(e.toString()));
    }
  },
  orElse: () {},
);
}

}