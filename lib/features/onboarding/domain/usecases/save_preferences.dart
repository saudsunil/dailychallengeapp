import '../repositories/onboarding_repository.dart';

class SavePreferences {
  final OnboardingRepository repository;

  SavePreferences(this.repository);

  Future<void> call(List<int> ids) async {
    return await repository.savePreferences(ids);
  }
}