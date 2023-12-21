import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/settings/settings.dart';
import 'package:tic_tac_toe/styles/style.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = context.watch<Style>();
    final settings = context.watch<Settings>();
    settings.playSound();
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.rotate(
                angle: -0.1,
                child: Text('Tic-Tac-Toe', style: style.title),
              ),
              const SizedBox(height: 60),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => GoRouter.of(context).go('/singleplayer'),
                    child: Text('Single Player', style: style.button),
                  ),
                  ElevatedButton(
                    onPressed: () => GoRouter.of(context).go('/multiplayer'),
                    child: Text('Multiplayer', style: style.button),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              ValueListenableBuilder(
                valueListenable: settings.soundOn,
                builder: (context, value, child) {
                  return IconButton(
                    onPressed: settings.toggleSound,
                    icon: Icon(
                      value ? Icons.volume_up : Icons.volume_off,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => GoRouter.of(context).go('/settings'),
          child: const Icon(Icons.settings),
        ));
  }
}
