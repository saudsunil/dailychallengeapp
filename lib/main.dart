// import 'package:flutter/material.dart';
// import 'features/onboarding/presentation/pages/onboarding_page.dart';
// import 'features/onboarding/presentation/cubit/onboarding_cubit.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'core/network/dio_client.dart';
// import 'features/onboarding/domain/usecases/get_categories.dart';
// import 'features/onboarding/domain/usecases/save_preferences.dart';
// import 'features/onboarding/data/repositories/onboarding_repository_impl.dart';
// import 'features/onboarding/data/datasources/onboarding_remote_datasource.dart';

// void main() {
//   final dioClient = DioClient();

//   final remoteDataSource =
//       OnboardingRemoteDataSourceImpl(dioClient.dio);

//   final repository =
//       OnboardingRepositoryImpl(remoteDataSource);

//   runApp(
//     BlocProvider(
//       create: (_) => OnboardingCubit(
//         GetCategories(repository),
//         SavePreferences(repository),
//       ),
//       child: const MyApp(),
//     ),
//   );
// }
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: OnboardingPage(),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'features/onboarding/data/datasources/onboarding_remote_datasource.dart';
import 'features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'features/onboarding/domain/usecases/get_categories.dart';
import 'features/onboarding/domain/usecases/save_preferences.dart';
import 'features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'features/onboarding/presentation/pages/onboarding_page.dart';

import 'features/daily_challenge/data/datasources/challenge_remote_datasource.dart';
import 'features/daily_challenge/data/repositories/challenge_repository_impl.dart';
import 'features/daily_challenge/domain/usecases/get_today_challenge.dart';
import 'features/daily_challenge/domain/usecases/get_streak.dart';
import 'features/daily_challenge/domain/usecases/complete_challenge.dart';
import 'features/daily_challenge/presentation/cubit/challenge_cubit.dart';


import 'features/history/data/datasources/history_remote_datasource.dart';
import 'features/history/data/repositories/history_repository_impl.dart';   
import 'features/history/domain/usecases/get_history.dart';
import 'features/history/presentation/cubit/history_cubit.dart';

void main() {
  final dio = Dio(
    BaseOptions(
      // baseUrl: "http://localhost:3000",
      baseUrl: "http://10.0.2.2:3000",
      connectTimeout: const Duration(seconds: 500),
      receiveTimeout: const Duration(seconds: 500),
    ),
  );

  // 🟣 Onboarding Dependencies
  final onboardingRemote =
      OnboardingRemoteDataSourceImpl(dio);

  final onboardingRepository =
      OnboardingRepositoryImpl(onboardingRemote);

  final getCategories = GetCategories(onboardingRepository);
  final savePreferences = SavePreferences(onboardingRepository);

  // 🔵 Daily Challenge Dependencies
  final challengeRemote =
      ChallengeRemoteDataSourceImpl(dio);

  final challengeRepository =
      ChallengeRepositoryImpl(challengeRemote);

  final getTodayChallenge =
      GetTodayChallenge(challengeRepository);

  final getStreak =
      GetStreak(challengeRepository);

  final completeChallenge =
      CompleteChallenge(challengeRepository);

  // 🟢 History Dependencies
final historyRemote =
    HistoryRemoteDataSourceImpl(dio);

final historyRepository =
    HistoryRepositoryImpl(historyRemote);

final getHistory =
    GetHistory(historyRepository);

  runApp(MyApp(
    getCategories: getCategories,
    savePreferences: savePreferences,
    getTodayChallenge: getTodayChallenge,
    getStreak: getStreak,
    completeChallenge: completeChallenge,
    getHistory: getHistory,
  ));
}

class MyApp extends StatelessWidget {
  final GetCategories getCategories;
  final SavePreferences savePreferences;
  final GetTodayChallenge getTodayChallenge;
  final GetStreak getStreak;
  final CompleteChallenge completeChallenge;
  final GetHistory getHistory;

  const MyApp({
    super.key,
    required this.getCategories,
    required this.savePreferences,
    required this.getTodayChallenge,
    required this.getStreak,
    required this.completeChallenge,
    required this.getHistory,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => OnboardingCubit(
            getCategories,
            savePreferences,
          ),
        ),
        BlocProvider(
          create: (_) => ChallengeCubit(
            getTodayChallenge,
            getStreak,
            completeChallenge,
          ),
        ),
        BlocProvider(
          create: (_) => HistoryCubit(
            getHistory,
          ),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: OnboardingPage(),
      ),
    );
  }
}