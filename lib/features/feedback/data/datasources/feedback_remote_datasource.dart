import 'package:dio/dio.dart';
import '../models/feedback_model.dart';

abstract class FeedbackRemoteDataSource{
  Future<void> submitFeedback(FeedbackModel model);
}

class FeedbackRemoteDataSourceImpl implements FeedbackRemoteDataSource{
  final Dio dio;

  FeedbackRemoteDataSourceImpl(this.dio);

  @override
  Future<void> submitFeedback(FeedbackModel model) async{
   await dio.post(
      "/feedback",
      data: model.toJson(),
   
    );

    
  }
  
}