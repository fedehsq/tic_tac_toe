import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/settings/settings.dart';
import 'package:tic_tac_toe/styles/style.dart';

class BaseGame extends StatefulWidget {
  const BaseGame({Key? key}) : super(key: key);

  @override
  State<BaseGame> createState() => _BaseGameState();

  void handleMove(int index, List<String> board, bool finished, BuildContext context) {}
}

class _BaseGameState extends State<BaseGame> {
  static const List<List<int>> _winningCases = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [2, 4, 6],
    [0, 4, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8]
  ];
  final List<String> _board = List.filled(9, '');
  bool _finished = false;

  @override
  Widget build(BuildContext context) {
    final style = context.watch<Style>();
    final Settings settings = context.watch<Settings>();
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Game', style: style.title),
              _buildAdditionalInfo(context),
              Table(
                border: TableBorder.all(
                    color: Colors.red, borderRadius: BorderRadius.circular(10)),
                children: [
                  _tableRow(0, 1, 2),
                  _tableRow(3, 4, 5),
                  _tableRow(6, 7, 8),
                ],
              ),
              Visibility(
                visible: _finished,
                child: ElevatedButton(
                  onPressed: () => _resetBoard(),
                  child: Text('Play Again', style: style.button),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdditionalInfo(BuildContext context) {
    return Container(); // Override in subclasses if needed
  }

  TableRow _tableRow(int i1, int i2, int i3) {
    return TableRow(
      children: [_cellRow(i1), _cellRow(i2), _cellRow(i3)],
    );
  }

  InkWell _cellRow(int index) {
    return InkWell(
      onTap: () => widget.handleMove(index, _board, _finished, context),
      child: SizedBox(
        height: 100,
        child: Icon(_board[index] == 'X'
            ? Icons.close
            : _board[index] == 'O'
                ? Icons.circle_outlined
                : null),
      ),
    );
  }

  void _resetBoard() {
    _board.fillRange(0, 9, '');
    _finished = false;
    setState(() {});
  }

  void _showSnackbar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  bool _isWinner(List<String> board, String player) {
    for (var winningCase in _winningCases) {
      if (board[winningCase[0]] == player &&
          board[winningCase[1]] == player &&
          board[winningCase[2]] == player) {
        return true;
      }
    }
    return false;
  }

  List<int> _findEmptyCells(List<String> board) {
    List<int> emptyCells = [];
    for (int i = 0; i < board.length; i++) {
      if (board[i] == '') {
        emptyCells.add(i);
      }
    }
    return emptyCells;
  }

  bool _isGameOver() {
    return _isWinner(_board, 'X') ||
        _isWinner(_board, 'O') ||
        _findEmptyCells(_board).isEmpty;
  }
}
