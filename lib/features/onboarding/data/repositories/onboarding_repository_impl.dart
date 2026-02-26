import '../../domain/entities/category.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../datasources/onboarding_remote_datasource.dart';


class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingRemoteDataSource remoteDataSource;

  OnboardingRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Category>> getCategories() {
    return remoteDataSource.getCategories();
  }

  @override
  Future<String> savePreferences(List<int> selectedIds) {
    return remoteDataSource.savePreferences(selectedIds);
}}