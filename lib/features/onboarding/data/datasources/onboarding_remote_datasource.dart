import 'package:dio/dio.dart';


abstract class OnboardingRemoteDataSource{
  Future<List<dynamic>> getCategories();
  Future<String> savePreferences(List<int> ids);
}

class OnboardingRemoteDataSourceImpl implements OnboardingRemoteDataSource{
  final Dio dio;

  OnboardingRemoteDataSourceImpl(this.dio);

  @override
  Future<List<dynamic>> getCategories() async {
    final response = await dio.get("/categories");
    return response.data["categories"];
   
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