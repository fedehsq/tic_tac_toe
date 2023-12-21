import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/game/base_game.dart';
import 'package:tic_tac_toe/game/game_mode.dart';
import 'package:tic_tac_toe/game/multiplayer_game.dart';
import 'package:tic_tac_toe/game/singleplayer_game.dart';
import 'package:tic_tac_toe/settings/settings.dart';
import 'package:tic_tac_toe/styles/style.dart';
import 'package:tic_tac_toe/widgets/my_cell.dart';

class Board extends StatefulWidget {
  final GameMode gameMode;
  const Board({Key? key, required this.gameMode}) : super(key: key);

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  late final BaseGame game;

  @override
  void initState() {
    super.initState();
    if (widget.gameMode == GameMode.singleplayer) {
      game = context.read<SinglePlayerGame>();
    } else {
      game = context.read<MultiPlayerGame>();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Style style = context.watch<Style>();
    final Settings settings = context.watch<Settings>();
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Game', style: style.title),
              if (widget.gameMode == GameMode.singleplayer)
                Text('God Mode: ${settings.godMode.value}',
                    style: style.subtitle),
              Table(
                border: TableBorder.all(
                    color: Colors.red, borderRadius: BorderRadius.circular(10)),
                children: [
                  _tableRow(0, 1, 2),
                  _tableRow(3, 4, 5),
                  _tableRow(6, 7, 8),
                ],
              ),
              ButtonBar(children: [
                ElevatedButton(
                  onPressed: () {
                    game.resetBoard();
                    GoRouter.of(context).pop();
                  },
                  child: Text('Back', style: style.button),
                ),
                Visibility(
                  visible: game.finished,
                  child: ElevatedButton(
                    onPressed: () => setState(() {
                      game.resetBoard();
                    }),
                    child: Text('Play Again', style: style.button),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  TableRow _tableRow(int i1, int i2, int i3) {
    return TableRow(
      children: [
        _cellRow(i1),
        _cellRow(i2),
        _cellRow(i3),
      ],
    );
  }

  MyCell _cellRow(int index) {
    return MyCell(
      onTap: () => setState(() {
        if (widget.gameMode == GameMode.singleplayer) {
          final Settings settings = context.read<Settings>();
          (game as SinglePlayerGame).handleMove(index, settings.getDepth());
        } else {
          (game as MultiPlayerGame).handleMove(index);
        }
      }),
      player: game.board[index],
    );
  }
}
