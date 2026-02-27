import 'package:dio/dio.dart';

abstract class HistoryRemoteDataSource{
  Future<List<dynamic>> getHistory(String userId);
}

class HistoryRemoteDataSourceImpl implements HistoryRemoteDataSource  {
  final Dio dio;

  HistoryRemoteDataSourceImpl(this.dio);

 @override
  Future<List<dynamic>> getHistory(String userId) async {
    final response = await dio.get(
      "/challenge/history",
      queryParameters: {"user_id": userId},
    );

    return response.data["history"];
  }
}