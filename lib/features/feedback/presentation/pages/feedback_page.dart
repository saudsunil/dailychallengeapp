import 'package:flutter/material.dart';
import'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/feedback_cubit.dart';
import '../cubit/feedback_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  String satisfaction = "high";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: const Color.fromARGB(255, 231, 242, 253),
      appBar: AppBar(
      backgroundColor: const Color.fromARGB(255, 231, 242, 253),
      elevation: 0,
        title: Padding(
          padding:const EdgeInsets.only(left: 9, top:10,),
        child:Row(
          children: const [
            Icon(Icons.feedback, color:Color.fromARGB(255, 27, 130, 214)),
            SizedBox(width: 9),
            Text(
              "Feedback",
              style: TextStyle(color:Color.fromARGB(255, 27, 130, 214), fontWeight: FontWeight.bold, fontSize:24,),
            ),
          ],
        ),
      ),),

      body:  Padding(
          padding: EdgeInsets.only(top:40, left:20, right:20),
      
         
        
      

        child:BlocListener<FeedbackCubit, FeedbackState>(
       listener: (context, state) {
  state.maybeWhen(
    success: () {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "Feedback Submitted",
            textAlign: TextAlign.center,
          ),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height / 2,
            left: 40,
            right: 40,
          ),
        ),
      );
    },
    error: (message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    },
    orElse: () {},
  );
},
         
        child:Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
                SizedBox(
  height: 55,
  child: TextField(
    controller: titleController,
    decoration: InputDecoration(
      labelText: "Title",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.orange, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.orange, width: 3),
      ),
    ),
  ),
),
            
              const SizedBox(height:30),

              SizedBox(
  height: 55,
  width: double.infinity,
  child: DropdownButtonFormField<String>(
    value: satisfaction,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.green, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.green, width: 3),
      ),
    ),
    items: ["high", "medium", "low"]
        .map((e) => DropdownMenuItem(
              value: e,
              child: Text(e),
            ))
        .toList(),
    onChanged: (value) {
      setState(() => satisfaction = value!);
    },
  ),
),
              const SizedBox(height:30),

            SizedBox(
              height: 55,
              child: TextField(
               controller: descriptionController,
         decoration: InputDecoration(
      labelText: "Description",
    
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 3),
      ),
    ),
  ),
),

              const SizedBox(height: 40),
              SizedBox(
               width: double.infinity,
              child:ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 73, 185, 131),
                  padding: const EdgeInsets.symmetric(vertical: 16),
   

                ),

              onPressed: () async {
  final title = titleController.text.trim();
  final desc = descriptionController.text.trim();

  if (title.isEmpty || desc.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Fill above contents")),
    );
    return;
  }

  final prefs = await SharedPreferences.getInstance();
  final userId = prefs.getString("user_id");

  if (userId != null) {
    context.read<FeedbackCubit>().submit(
      title: title,
      satisfaction: satisfaction,
      description: desc,
      userId: userId,
    );
  }
},
                child: const Text("Submit",
                style: TextStyle(color: Colors.white, fontSize:18 ),
                 ),
              ),
          ),],
          ),
        ),
      ),
       ), );
  }
}