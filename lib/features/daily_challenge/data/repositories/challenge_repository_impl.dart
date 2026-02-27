import '../../domain/repositories/challenge_repository.dart';
import '../datasources/challenge_remote_datasource.dart';
import '../models/challenge_model.dart';
import '../models/streak_model.dart';
import '../../domain/entities/challenge.dart';
import '../../domain/entities/streak.dart';

class ChallengeRepositoryImpl implements ChallengeRepository {
  final ChallengeRemoteDataSourceImpl remote;

  ChallengeRepositoryImpl(this.remote);

  @override
  Future<Challenge> getTodayChallenge(String userId) async {
    final data = await remote.getTodayChallenge(userId);
    return ChallengeModel.fromJson(data);
  }

  @override

  Future<Streak> getStreak(String userId) async {
    final data = await remote.getStreak(userId);
    return StreakModel.fromJson(data);
  }

  @override
  Future<void> completeChallenge(String userId, int challengeId) async {
    await remote.completeChallenge(userId, challengeId);
  }
}