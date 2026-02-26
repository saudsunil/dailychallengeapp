import 'package:dio/dio.dart';
import "../models/category_model.dart";

abstract class OnboardingRemoteDataSource{
  Future<List<CategoryModel>> getCategories();
  Future<void> savePreferences(List<int> ids);
}

class OnboardingRemoteDataSourceImpl implements OnboardingRemoteDataSource{
  final Dio dio;

  OnboardingRemoteDataSourceImpl(this.dio);

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await dio.get("/categories");
    final List data = response.data["categories"];

    return data.map((json)=> CategoryModel.fromJson(json)).toList();
  }

 @override
  Future<void> savePreferences(List<int> ids) async {
    await dio.post("/preferences", data: {
      "selected_ids": ids,
    });
  }
}