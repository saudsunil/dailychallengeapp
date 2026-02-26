import '../entities/category.dart';

abstract class OnboardingRepository{ 
  Future<List<Category>> getCategories();
  Future<void> savePreferences(List<int> selectedIds);
}