import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection.dart';

import 'features/onboarding/presentation/pages/onboarding_page.dart';
import 'features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'features/daily_challenge/presentation/cubit/challenge_cubit.dart';
import 'features/history/presentation/cubit/history_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init(); // 🔥 initialize get_it

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<OnboardingCubit>(),
        ),
        BlocProvider(
          create: (_) => sl<ChallengeCubit>(),
        ),      
        BlocProvider(
          create: (_) => sl<HistoryCubit>(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: OnboardingPage(),
      ),
    );
  }
}