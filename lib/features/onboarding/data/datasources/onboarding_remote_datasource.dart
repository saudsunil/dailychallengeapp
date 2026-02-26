import 'package:dio/dio.dart';
import "../models/category_model.dart";

abstract class OnboardingRemoteDataSource{
  Future<List<CategoryModel>> getCategories();
  Future<String> savePreferences(List<int> ids);
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
  Future<String> savePreferences(List<int> ids) async {
   final response = await dio.post(
  "/preferences",
  data: {
    "category_ids": ids,
  },
);

return response.data["user_id"];
  }
}