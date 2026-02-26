import 'package:dio/dio.dart';
abstract class ChallengeRemoteDataSource {
  Future<Map<String, dynamic>> getTodayChallenge(String userId);
  Future<Map<String, dynamic>> getStreak(String userId);
  Future<void> completeChallenge(String userId, int challengeId);
}

class ChallengeRemoteDataSourceImpl
    implements ChallengeRemoteDataSource {
  final Dio dio;

  ChallengeRemoteDataSourceImpl(this.dio);

  @override
  Future<Map<String, dynamic>> getTodayChallenge(String userId) async {
    final response = await dio.get(
      "/challenge/today",
      queryParameters: {"user_id": userId},
    );

    return response.data;
  }

  @override
  Future<Map<String, dynamic>> getStreak(String userId) async {
    final response = await dio.get(
      "/streak",
      queryParameters: {"user_id": userId},
    );

    return response.data;
  }

  @override
  Future<void> completeChallenge(String userId, int challengeId) async {
    await dio.post(
      "/challenge/complete",
      data: {
        "user_id": userId,
        "challenge_id": challengeId,
      },
    );
  }
}