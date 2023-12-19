import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/settings/settings.dart';
import 'package:tic_tac_toe/styles/style.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<Settings>();
    final style = context.watch<Style>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Settings', style: style.title),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('God Mode', style: style.subtitle),
                ValueListenableBuilder(
                    valueListenable: settings.godMode,
                    builder: (context, godMode, child) => Switch(
                        value: godMode,
                        onChanged: (value) => settings.toggleGodMode())),
              ],
            ),
            const SizedBox(height: 60),
            // Back button
            ElevatedButton(
              onPressed: () => GoRouter.of(context).pop(),
              child: Text('Back', style: style.button),
            ),
          ],
        ),
      ),
    );
  }
}
