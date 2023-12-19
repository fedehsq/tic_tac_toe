import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/styles/style.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = context.watch<Style>();
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.rotate(
                angle: -0.1,
                child:  Text(
                  'Tic-Tac-Toe',
                  style: style.title
                ),
              ),
              const SizedBox(height: 60),
              ElevatedButton(
                onPressed: () => GoRouter.of(context).go('/game'),
                child: Text('Play', style: style.button),
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
