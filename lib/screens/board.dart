import 'package:flutter/material.dart';

class Board extends StatefulWidget {
  const Board({Key? key}) : super(key: key);

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Board'),
      ),
      body: Center(
        child: Table(
          border: TableBorder.all(color: Colors.white),
          children: [
            _tableRow(0, 1, 2),
            _tableRow(3, 4, 5),
            _tableRow(6, 7, 8),
          ],
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
    if (_board[index] == '') {
      _board[index] = 'X';
      if (!_isGameOver()) {
        // wait 
        Future.delayed(const Duration(milliseconds: 500), () {
          _adversaryMove();
          setState(() {});
        });
      } else {
        _showSnackbar("It's a draw!");
        _resetBoard();
      }
      setState(() {});
    }
  }

  Future<void> _resetBoard() {
    return Future.delayed(const Duration(seconds: 2), () {
        _board.fillRange(0, 9, '');
        setState(() {});
      });
  }

  void _adversaryMove() {
    int bestMove = _minimax(_board, 'O')['index'];
    _board[bestMove] = 'O';
    if (_isWinner(_board, 'O')) {
      _showSnackbar("You lost!");
      _resetBoard();
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

  Map<String, dynamic> _minimax(List<String> board, String player) {
    List<int> emptyCells = _findEmptyCells(board);
    if (_isWinner(board, 'O')) {
      return {'score': 1};
    } else if (_isWinner(board, 'X')) {
      return {'score': -1};
    } else if (emptyCells.isEmpty) {
      return {'score': 0};
    }
    List<Map<String, dynamic>> moves = [];
    for (int index in emptyCells) {
      Map<String, dynamic> move = {};
      move['index'] = index;
      board[index] = player;
      var result = _minimax(board, player == 'O' ? 'X' : 'O');
      move['score'] = result['score'];
      board[index] = ''; 
      moves.add(move);
    }
    int bestMove = 0;
    int bestScore = player == 'O'
        ? -10000
        : 10000; 
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
