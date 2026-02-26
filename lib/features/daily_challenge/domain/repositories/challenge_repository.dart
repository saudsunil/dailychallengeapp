import '../entities/challenge.dart';
import '../entities/streak.dart';

abstract class ChallengeRepository {
  Future<Challenge> getTodayChallenge(String userId);
  Future<Streak> getStreak(String userId);
  Future<void> completeChallenge(String userId, int challengeId);
}