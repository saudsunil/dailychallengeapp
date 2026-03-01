
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/onboarding_cubit.dart';
import '../cubit/onboarding_state.dart';
 
import '../../../home/presentation/pages/homepage.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor: const Color.fromARGB(255, 231, 242, 253),

  appBar: AppBar(
    backgroundColor: const Color.fromARGB(255, 231, 242, 253),
     
    elevation: 0,
    iconTheme: const IconThemeData(color: Colors.blue),
    title: Padding(
      padding: const EdgeInsets.only(left: 9, top:10),
      child:
     Text(
      "🎯 Pick Your Interests",
      style: TextStyle(
        color: Color.fromARGB(255, 27, 130, 214),
        fontWeight: FontWeight.bold,
        fontSize: 24,
      
      ),
    ),
  ),),

  body: SafeArea(
    child: Padding(
     padding: const EdgeInsets.fromLTRB(23, 0, 23, 23),
      child: BlocListener<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const HomePage(),
              ),
            );
          }
        },
        child: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {

            if (state is OnboardingLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is OnboardingError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (state is OnboardingLoaded) {

              final borderColors = [
                Colors.blue,
                Colors.orange,
                Colors.green,
                Colors.red,
              ];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:4, bottom:16 ),
                   
                 child: const Text(
                    "Choose categories you like the most",
                    style: TextStyle(color: Color.fromARGB(255, 77, 74, 74), fontSize: 16),
                  ),),

                  const SizedBox(height: 20),

                  /// 🔵 GRID (Not Expanded anymore)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.categories.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 22,
                      childAspectRatio: 1.9, // 👈 rectangular shape
                    ),
                    itemBuilder: (context, index) {

                      final category = state.categories[index];
                      final isSelected =
                          state.selectedIds.contains(category.id);

                      final color =
                          borderColors[index % borderColors.length];

                      return GestureDetector(
                        onTap: () => context
                            .read<OnboardingCubit>()
                            .toggleSelection(category.id),

                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? color.withAlpha((0.15 * 255).round())
                                : Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.transparent
                                  : color,
                              width: 3,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "${category.emoji} ${category.name}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 30),

                  /// 🟢 CONTINUE BUTTON (Just below grid)
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 27, 130, 214),
                      ),
                      child: const Text(
                        "Continue",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    ),
  ),
);  
  }
}