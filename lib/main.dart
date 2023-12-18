import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/board.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(
        // dark theme
        
        useMaterial3: true,
      ),
      home: Board()
    );
  }
}
