import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/router.dart';
import 'package:tic_tac_toe/settings/settings.dart';
import 'package:tic_tac_toe/styles/style.dart';

void main() {
  runApp(const TicTacToe());
}

class TicTacToe extends StatelessWidget {
  const TicTacToe({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => Settings()),
        Provider(create: (context) => Style()),
      ],
      child: MaterialApp.router(
          title: 'Tic-Tac-Toe',
          theme: ThemeData.dark(
            useMaterial3: true,
          ),
          routerConfig: router),
    );
  }
}
