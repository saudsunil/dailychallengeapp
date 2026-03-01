import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;

  DioClient()
      : dio = Dio(
          BaseOptions(
            // baseUrl: "http://10.0.2.2:3000",
            // baseUrl: "http://localhost:3000",
              baseUrl: "http://192.168.18.3:3000",
            connectTimeout: const Duration(seconds: 500),
            receiveTimeout: const Duration(seconds: 500),
          ),
        );
}