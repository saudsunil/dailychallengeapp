import '../repositories/challenge_repository.dart';
import '../entities/streak.dart';

class GetStreak {
  final ChallengeRepository repository;

  GetStreak(this.repository);

  Future<Streak> call(String userId) {
    return repository.getStreak(userId);
  }
}