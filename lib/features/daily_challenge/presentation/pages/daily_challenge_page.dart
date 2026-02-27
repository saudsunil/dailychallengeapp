// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../cubit/challenge_cubit.dart';
// import '../cubit/challenge_state.dart'; 

// class DailyChallengePage extends StatelessWidget {
//   final String userId;

//   const DailyChallengePage({super.key, required this.userId});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => context.read<ChallengeCubit>()
//         ..loadChallenge(userId),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Daily Challenge"),
//         ),
//         body: BlocBuilder<ChallengeCubit, ChallengeState>(
//           builder: (context, state) {
//             if (state is ChallengeLoading) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             if (state is ChallengeLoaded) {
//               return Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "🔥 Current Streak: ${state.streak.currentStreak}",
//                       style: const TextStyle(fontSize: 18),
//                     ),
//                     const SizedBox(height: 20),

//                     Text(
//                       "${state.challenge.emoji} ${state.challenge.title}",
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),

//                     const SizedBox(height: 10),
//                     Text("Difficulty: ${state.challenge.difficulty}"),

//                     const SizedBox(height: 20),

//                     ElevatedButton(
//                       onPressed: state.challenge.completed
//                           ? null
//                           : () {
//                               context
//                                   .read<ChallengeCubit>()
//                                   .complete(userId, state.challenge.id);
//                             },
//                       child: const Text("Mark as Completed"),
//                     ),
//                   ],
//                 ),
//               );
//             }

//             if (state is ChallengeError) {
//               return Center(child: Text(state.message));
//             }

//             return const SizedBox();
//           },
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: "Home",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.history),
//               label: "History",
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../cubit/challenge_cubit.dart';
import '../cubit/challenge_state.dart';


class DailyChallengePage extends StatefulWidget {
  const DailyChallengePage({super.key});

  @override
  State<DailyChallengePage> createState() => _DailyChallengePageState();
}

class _DailyChallengePageState extends State<DailyChallengePage> {

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString("user_id");

    if (userId != null) {
      context.read<ChallengeCubit>().loadChallenge(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Challenge"),
      ),
      body: BlocBuilder<ChallengeCubit, ChallengeState>(
        builder: (context, state) {
          if (state is ChallengeLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ChallengeLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "🔥 Current Streak: ${state.streak.currentStreak}",
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),

                  Text(
                    "${state.challenge.emoji} ${state.challenge.title}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),
                  Text("Difficulty: ${state.challenge.difficulty}"),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: state.challenge.completed
                        ? null
                        : () async {
                            final prefs = await SharedPreferences.getInstance();
                            final userId = prefs.getString("user_id");

                            if (userId != null) {
                              context.read<ChallengeCubit>().complete(
                                    userId,
                                    state.challenge.id,
                                  );
                            }
                          },
                    child: const Text("Mark as Completed"),
                  ),
                ],
              ),
            );
          }

          if (state is ChallengeError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox();
        },
      ),
     
    );
  }
}

