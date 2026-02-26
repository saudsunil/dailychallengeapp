import 'package:flutter/material.dart';
import 'features/onboarding/presentation/pages/onboarding_page.dart';
import 'features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/network/dio_client.dart';
import 'features/onboarding/domain/usecases/get_categories.dart';
import 'features/onboarding/domain/usecases/save_preferences.dart';
import 'features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'features/onboarding/data/datasources/onboarding_remote_datasource.dart';

void main() {
  final dioClient = DioClient();

  final remoteDataSource =
      OnboardingRemoteDataSourceImpl(dioClient.dio);

  final repository =
      OnboardingRepositoryImpl(remoteDataSource);

  runApp(
    BlocProvider(
      create: (_) => OnboardingCubit(
        GetCategories(repository),
        SavePreferences(repository),
      ),
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingPage(),
    );
  }
}