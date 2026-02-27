import '../entities/category.dart';

abstract class OnboardingRepository{ 
  Future<List<Category>> getCategories();
  Future<String> savePreferences(List<int> selectedIds);
}