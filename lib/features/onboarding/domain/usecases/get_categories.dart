import '../entities/category.dart';
import '../repositories/onboarding_repository.dart';

class GetCategories {
  final OnboardingRepository repository;

  GetCategories(this.repository);

  Future<List<Category>> call() async{
    return await repository.getCategories();
  }
}