import 'package:dio/dio.dart';
import '../models/feedback_model.dart';
import '../models/feedback_response_model.dart';

abstract class FeedbackRemoteDataSource{
  Future<FeedbackResponseModel> submitFeedback(FeedbackModel model);
}

class FeedbackRemoteDataSourceImpl implements FeedbackRemoteDataSource{
  final Dio dio;

  FeedbackRemoteDataSourceImpl(this.dio);

  @override
  Future<FeedbackResponseModel> submitFeedback(FeedbackModel model) async{
   final response= await dio.post(
      "/feedback",
      data: model.toJson(),
   
    );
    if (response.statusCode == 200 || response.statusCode == 201){
      return FeedbackResponseModel.fromJson(response.data);
    }else{
      throw Exception("Failed to submit feedback");
    }

    
  }
  
}