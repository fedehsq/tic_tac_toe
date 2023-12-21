import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/game/base_game.dart';
import 'package:tic_tac_toe/game/multiplayer_game.dart';
import 'package:tic_tac_toe/game/singleplayer_game.dart';
import 'package:tic_tac_toe/router.dart';
import 'package:tic_tac_toe/settings/settings.dart';
import 'package:tic_tac_toe/styles/style.dart';

void main() {
  runApp(const TicTacToe());
}

class TicTacToe extends StatelessWidget {
  const TicTacToe({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => Settings()),
        Provider(create: (context) => Style()),
        Provider(create: (context) => BaseGame()),
        Provider(create: (context) => SinglePlayerGame()),
        Provider(create: (context) => MultiPlayerGame()),
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
