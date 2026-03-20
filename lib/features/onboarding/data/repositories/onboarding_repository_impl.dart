import '../../domain/entities/category.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../datasources/onboarding_remote_datasource.dart';
import '../models/category_model.dart';


class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingRemoteDataSource remoteDataSource;

  OnboardingRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Category>> getCategories() async {
    final data = await remoteDataSource.getCategories();
    return data.map((json) => CategoryModel.fromJson(json)).toList();
  }

  @override
  Future<String> savePreferences(List<int> ids) {
    return remoteDataSource.savePreferences(ids);
}}