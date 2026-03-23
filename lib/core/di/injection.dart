import 'package:get_it/get_it.dart';
import '../network/dio_client.dart';

// Onboarding imports
import '../../features/onboarding/data/datasources/onboarding_remote_datasource.dart';
import '../../features/onboarding/data/repositories/onboarding_repository_impl.dart';
import '../../features/onboarding/domain/repositories/onboarding_repository.dart';
import '../../features/onboarding/domain/usecases/get_categories.dart';
import '../../features/onboarding/domain/usecases/save_preferences.dart';
import '../../features/onboarding/presentation/cubit/onboarding_cubit.dart';

// Daily Challenge
import '../../features/daily_challenge/data/datasources/challenge_remote_datasource.dart';
import '../../features/daily_challenge/data/repositories/challenge_repository_impl.dart';
import '../../features/daily_challenge/domain/repositories/challenge_repository.dart';
import '../../features/daily_challenge/domain/usecases/get_today_challenge.dart';
import '../../features/daily_challenge/domain/usecases/get_streak.dart';
import '../../features/daily_challenge/domain/usecases/complete_challenge.dart';
import '../../features/daily_challenge/presentation/cubit/challenge_cubit.dart';

// History
import '../../features/history/data/datasources/history_remote_datasource.dart';
import '../../features/history/data/repositories/history_repository_impl.dart';
import '../../features/history/domain/repositories/history_repository.dart';
import '../../features/history/domain/usecases/get_history.dart';
import '../../features/history/presentation/cubit/history_cubit.dart';

//feedback
import '../../features/feedback/data/datasources/feedback_remote_datasource.dart';
import '../../features/feedback/data/repositories/feedback_repository_impl.dart';
import '../../features/feedback/domain/repositories/feedback_repository.dart';
import '../../features/feedback/domain/usecases/submit_feedback.dart';
import '../../features/feedback/presentation/cubit/feedback_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {

  // 🌐 CORE (Dio)
  sl.registerLazySingleton(() => DioClient().dio);

  //=======================daily challenge========================

  // 🔵 DATASOURCE
  sl.registerLazySingleton<OnboardingRemoteDataSource>(
    () => OnboardingRemoteDataSourceImpl(sl()),
  );

  // 🟢 REPOSITORY
  sl.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepositoryImpl(sl()),
  );

  // 🟡 USECASES
  sl.registerLazySingleton(() => GetCategories(sl()));
  sl.registerLazySingleton(() => SavePreferences(sl()));

  // 🔴 CUBIT
  sl.registerFactory(
    () => OnboardingCubit(
      sl(), // GetCategories
      sl(), // SavePreferences
    ),
  );

  // ================= DAILY CHALLENGE =================

// 🔵 DATASOURCE
sl.registerLazySingleton<ChallengeRemoteDataSource>(
  () => ChallengeRemoteDataSourceImpl(sl()),
);

// 🟢 REPOSITORY
sl.registerLazySingleton<ChallengeRepository>(
  () => ChallengeRepositoryImpl(sl()),
);

// 🟡 USECASES
sl.registerLazySingleton(() => GetTodayChallenge(sl()));
sl.registerLazySingleton(() => GetStreak(sl()));
sl.registerLazySingleton(() => CompleteChallenge(sl()));

// 🔴 CUBIT
sl.registerFactory(
  () => ChallengeCubit(
    sl(), // GetTodayChallenge
    sl(), // GetStreak
    sl(), // CompleteChallenge
  ),
);

// ================= HISTORY =================

// 🔵 DATASOURCE
sl.registerLazySingleton<HistoryRemoteDataSource>(
  () => HistoryRemoteDataSourceImpl(sl()),
);

// 🟢 REPOSITORY
sl.registerLazySingleton<HistoryRepository>(
  () => HistoryRepositoryImpl(sl()),
);

// 🟡 USECASE
sl.registerLazySingleton(() => GetHistory(sl()));

// 🔴 CUBIT
sl.registerFactory(
  () => HistoryCubit(
    sl(),
  ),
);
//=======================feedback=========================//
// DATASOURCE
sl.registerLazySingleton<FeedbackRemoteDataSource>(
  () => FeedbackRemoteDataSourceImpl(sl()),
);

// REPOSITORY
sl.registerLazySingleton<FeedbackRepository>(
  () => FeedbackRepositoryImpl(sl()),
);

// USECASE
sl.registerLazySingleton(() => SubmitFeedback(sl()));

// CUBIT
sl.registerFactory(() => FeedbackCubit(sl()));

}