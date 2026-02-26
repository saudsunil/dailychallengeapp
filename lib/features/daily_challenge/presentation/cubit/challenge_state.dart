import '../../domain/entities/challenge.dart';
import '../../domain/entities/streak.dart';

abstract class ChallengeState {}

class ChallengeInitial extends ChallengeState {}

class ChallengeLoading extends ChallengeState {}

class ChallengeLoaded extends ChallengeState {
  final Challenge challenge;
  final Streak streak;

  ChallengeLoaded({
    required this.challenge,
    required this.streak,
  });
}

class ChallengeError extends ChallengeState {
  final String message;

  ChallengeError(this.message);
}