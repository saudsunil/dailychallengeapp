import '../repositories/challenge_repository.dart';
import '../entities/challenge.dart';

class GetTodayChallenge {
  final ChallengeRepository repository;

  GetTodayChallenge(this.repository);

  Future<Challenge> call(String userId) {
    return repository.getTodayChallenge(userId);
  }
}