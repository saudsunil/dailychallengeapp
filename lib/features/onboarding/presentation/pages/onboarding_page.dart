import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/onboarding_cubit.dart';
import '../cubit/onboarding_state.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {

              // 🔵 Loading State
              if (state is OnboardingLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              // 🔴 Error State
              if (state is OnboardingError) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              // 🟢 Loaded State
              if (state is OnboardingLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),

                    const Text(
                      "🎯 Pick Your Interests",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "Choose categories you like",
                      style: TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 30),

                    Expanded(
                      child: GridView.builder(
                        itemCount: state.categories.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 1.2,
                        ),
                        itemBuilder: (context, index) {
                          final category = state.categories[index];

                          final isSelected =
                              state.selectedIds.contains(category.id);

                          return GestureDetector(
                            onTap: () => context
                                .read<OnboardingCubit>()
                                .toggleSelection(category.id),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.blue.shade50
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.blue
                                      : Colors.grey.shade300,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "${category.emoji} ${category.name}",
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 10),

                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: state.selectedIds.isEmpty
                            ? null
                            : () {
                                context
                                    .read<OnboardingCubit>()
                                    .submit();
                              },
                        child: const Text("Continue"),
                      ),
                    ),
                  ],
                );
              }

              // ⚪ Default fallback
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}