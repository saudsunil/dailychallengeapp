import 'package:flutter_bloc/flutter_bloc.dart';
import 'challenge_state.dart';
import '../../domain/usecases/get_today_challenge.dart';
import '../../domain/usecases/get_streak.dart';
import '../../domain/usecases/complete_challenge.dart';


class ChallengeCubit extends Cubit<ChallengeState> {

final GetTodayChallenge getTodayChallenge;
final GetStreak getStreak;
final CompleteChallenge completeChallenge;

ChallengeCubit(
  this.getTodayChallenge,
  this.getStreak,
  this.completeChallenge,
) : super(ChallengeInitial());
  Future<void> loadChallenge(String userId) async {
    emit(ChallengeLoading());

    try {
      final challenge = await getTodayChallenge(userId);
      final streak = await getStreak(userId);

      emit(ChallengeLoaded(
        challenge: challenge,
        streak: streak,
      ));
    } catch (e) {
      emit(ChallengeError(e.toString()));
    }
  }

  Future<void> complete(String userId, int challengeId) async {
    await completeChallenge(userId, challengeId);
    loadChallenge(userId);
  }
}