import 'package:flutter/material.dart';

void main() {
  runApp(const DailyChallengeApp());
}

class DailyChallengeApp extends StatelessWidget {
  const DailyChallengeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily Challenge App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body: Center(
          child: Text('Daily Challenge App Started'),
        ),
      ),
    );
  }
}