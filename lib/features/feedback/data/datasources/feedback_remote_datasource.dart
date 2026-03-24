import 'package:dio/dio.dart';
import '../models/feedback_model.dart';

abstract class FeedbackRemoteDataSource{
  Future<Map<String, dynamic>> submitFeedback(FeedbackModel model);
}

class FeedbackRemoteDataSourceImpl implements FeedbackRemoteDataSource{
  final Dio dio;

  FeedbackRemoteDataSourceImpl(this.dio);

  @override
  Future<Map<String,dynamic>> submitFeedback(FeedbackModel model) async{
   final response= await dio.post(
      "/feedback",
      data: model.toJson(),
   
    );
    return response.data;

    
  }
  
}