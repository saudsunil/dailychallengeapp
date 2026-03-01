import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../cubit/history_cubit.dart';
import '../cubit/history_state.dart';
import 'package:intl/intl.dart'; 


class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

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
      context.read<HistoryCubit>().loadHistory(userId);
    }
  }




  @override
  Widget build(BuildContext context) {
    final borderColors = [Colors.green, Colors.yellow, Colors.red];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 242, 253),
      appBar: AppBar(
      backgroundColor: const Color.fromARGB(255, 231, 242, 253),
      elevation: 0,
        title: Padding(
          padding:const EdgeInsets.only(left: 9, top:10,),
        child:Row(
          children: const [
            Icon(Icons.history, color:Color.fromARGB(255, 27, 130, 214)),
            SizedBox(width: 9),
            Text(
              "History",
              style: TextStyle(color:Color.fromARGB(255, 27, 130, 214), fontWeight: FontWeight.bold, fontSize:24,),
            ),
          ],
        ),
      ),),
      body: BlocBuilder<HistoryCubit, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HistoryLoaded) {

            return GridView.builder(
              
              padding: const EdgeInsets.all(25),
              itemCount: state.history.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 14,
                childAspectRatio: 4.3,
              ),
              itemBuilder: (context, index) {
                final item = state.history[index];
                final borderColor = borderColors[index % borderColors.length];
                final formattedDate =
                    DateFormat('EEE, MMM d').format(item.date);

                return Container(
                  padding: const EdgeInsets.only(left: 8, top: 0, right: 8, bottom: 12),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: borderColor, width: 3),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      // Tick/cross icon with shadow
                      Padding(padding: const EdgeInsets.only( bottom: 17),
                      child:Container(
                        decoration: const BoxDecoration(
                         
                        ),
                        child: Icon(
                          item.completed ? Icons.check : Icons.close,
                          color: Colors.black,
                          size: 18,
                        ),
                      ),),
                      const SizedBox(width: 4),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(height: 1),
                          
                            Text(
                              "${item.categoryName} • $formattedDate",
                              style: const TextStyle(
                                color: Color.fromARGB(255, 77, 74, 74), 
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }

          if (state is HistoryError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox();
        },
      ),
    );
  }
}