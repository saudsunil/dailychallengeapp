import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';

import '../../../daily_challenge/presentation/pages/daily_challenge_page.dart';
import '../../../history/presentation/pages/history_pages.dart';
import '../../../feedback/presentation/pages/feedback_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();


  @override
  Widget build(BuildContext context) {
    
  final _pages = const [
    DailyChallengePage(),
    HistoryPage(),
    FeedbackPage(),
  ];

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final selectedIndex = state.selectedIndex;

        return Scaffold(
          body: IndexedStack(
            index: selectedIndex,
            children: _pages,
          ),

          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(context,  "Home", 0, selectedIndex),
                _buildNavItem(context, "History", 1, selectedIndex),
                _buildNavItem(context,"Feedback", 2, selectedIndex ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    String label,
    int index,
    int selectedIndex,
  ) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => context.read<HomeCubit>().changeTab(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(255, 27, 130, 214)
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(30),
        ),
       child: Text (
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : const Color.fromARGB(255, 71, 69, 69),
          fontWeight: FontWeight.bold,
        ),)
      ),
    );
  }
}