

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
      if (!mounted) return;
      context.read<ChallengeCubit>().loadChallenge(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 242, 253),
      appBar: AppBar(
        title: Padding(
          padding:const EdgeInsets.only(left: 9, top:10,),
          child: Row(
          children: const[
            Icon(Icons.wb_sunny, color:Color.fromARGB(255, 27, 130, 214)),
            SizedBox(width:8),
          
         Text(
          "Daily Challenge",
           style: TextStyle(color:Color.fromARGB(255, 27, 130, 214), fontWeight: FontWeight.bold, fontSize:24),
         ),
          ],
      ),),
      backgroundColor: const Color.fromARGB(255, 231, 242, 253),
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.blue),
      ),
      body: BlocBuilder<ChallengeCubit, ChallengeState>(
        builder: (context, state) {
          return state.when( 
                initial: ()=> const SizedBox(),

                loading: ()=> const Center(child: CircularProgressIndicator(),),

                error: (message)=> Center(child: Text(message),),

         loaded: (challenge, streak){
            return Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //streak container
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top:16, bottom: 10, left:13, right:16),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 253, 224, 142),
                      borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:9),
                        child: Text(
                    "🔥 Current Streak",
                    style: const TextStyle(fontSize: 18, fontWeight : FontWeight.bold, color: Color.fromARGB(255, 94, 46, 46), height: 1.0),
                  
                  ),),
                
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child:
                  Text(
                    "${streak.currentStreak} days",
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 94, 46, 46)),
                  ),),
                ],
                  ),
                  ),

                  const SizedBox(height:20),

                  Container(
                    
                    padding: const EdgeInsets.only(bottom:28, top:22, left:16, right:16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 3),
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,  
                    
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                         
                          "Category: ${challenge.categoryName}",
                          style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 77, 74, 74), ),
                        ),
                        const SizedBox(height: 4),
                  Text(
                    challenge.title,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                 

                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: challenge.completed ? Colors.white : const Color.fromARGB(255, 73, 185, 131),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                       
                      ),
                    onPressed: challenge.completed
                        ? null
                        : () async {
                          final cubit = context.read<ChallengeCubit>();
                            final prefs = await SharedPreferences.getInstance();
                            final userId = prefs.getString("user_id");

                            if (userId != null) {
                              if (!mounted) return;
                              cubit.complete(userId, challenge.id);
                            }
                          },
                    child: const Text("Mark as Completed",
                     style: TextStyle(color: Colors.white, fontSize: 18),),
                       

                                
                  ),),
                ],
              ),
                  ),
                ],
              ),
            );
          },

          );
        },
      ),
     
    );
  }
}

