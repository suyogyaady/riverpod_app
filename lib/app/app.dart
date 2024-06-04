import 'package:flutter/material.dart';
import 'package:riverpod_app/screens/student_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: StudentScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
