import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/settings/settings.dart';
import 'package:tic_tac_toe/styles/style.dart';

class SinglePlayerGame extends StatefulWidget {
  const SinglePlayerGame({Key? key}) : super(key: key);

  @override
  State<SinglePlayerGame> createState() => _SinglePlayerGameState();
}

class _SinglePlayerGameState extends State<SinglePlayerGame> {
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

  TableRow _tableRow(int i1, int i2, int i3) {
    return TableRow(
      children: [_cellRow(i1), _cellRow(i2), _cellRow(i3)],
    );
  }

  InkWell _cellRow(int index) {
    return InkWell(
      onTap: () => _handleMove(index),
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

  void _handleMove(int index) {
    if (_finished) {
      return;
    }
    if (_board[index] == '') {
      _board[index] = 'X';
      if (!_isGameOver()) {
        // wait
        Future.delayed(const Duration(milliseconds: 500), () {
          _adversaryMove();
          setState(() {});
        });
      } else if (_isWinner(_board, 'X')) {
        _showSnackbar("You won!");
        _finished = true;
      } else {
        _showSnackbar("It's a draw!");
        _finished = true;
      }
      setState(() {});
    }
  }

  void _resetBoard() {
    _board.fillRange(0, 9, '');
    _finished = false;
    setState(() {});
  }

  void _adversaryMove() {
    final Settings settings = context.read<Settings>();
    int bestMove = _minimax(_board, 'O', settings.getDepth())['index'];
    _board[bestMove] = 'O';
    if (_isWinner(_board, 'O')) {
      _showSnackbar("You lost!");
      _finished = true;
    }
  }

  void _showSnackbar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  Map<String, dynamic> _minimax(List<String> board, String player, int depth) {
    List<int> emptyCells = _findEmptyCells(board);
    if (_isWinner(board, 'O')) {
      return {'score': 1};
    } else if (_isWinner(board, 'X')) {
      return {'score': -1};
    } else if (emptyCells.isEmpty || depth == 0) {
      return {'score': 0};
    }
    List<Map<String, dynamic>> moves = [];
    for (int index in emptyCells) {
      Map<String, dynamic> move = {};
      move['index'] = index;
      board[index] = player;
      var result = _minimax(board, player == 'O' ? 'X' : 'O', depth - 1);
      move['score'] = result['score'];
      board[index] = '';
      moves.add(move);
    }
    int bestMove = 0;
    int bestScore = player == 'O' ? -10000 : 10000;
    for (var move in moves) {
      if ((player == 'O' && move['score'] > bestScore) ||
          (player == 'X' && move['score'] < bestScore)) {
        bestScore = move['score'];
        bestMove = move['index'];
      }
    }
    return {'index': bestMove, 'score': bestScore};
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
