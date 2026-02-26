import '../repositories/challenge_repository.dart';

class CompleteChallenge {
  final ChallengeRepository repository;

  CompleteChallenge(this.repository);

  Future<void> call(String userId, int challengeId) {
    return repository.completeChallenge(userId, challengeId);
  }
}