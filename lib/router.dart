import 'package:go_router/go_router.dart';
import 'package:tic_tac_toe/game/game_mode.dart';
import 'package:tic_tac_toe/screens/main_menu.dart';
import 'package:tic_tac_toe/screens/settings.dart';
import 'package:tic_tac_toe/screens/board.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainMenuScreen(),
      routes: [
        GoRoute(
            path: 'singleplayer',
            builder: (context, state) => const Board(
                  gameMode: GameMode.singleplayer,
                )),
        GoRoute(
            path: 'multiplayer',
            builder: (context, state) => const Board(
                  gameMode: GameMode.multiplayer,
                )),
        GoRoute(
          path: 'settings',
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
  ],
);
