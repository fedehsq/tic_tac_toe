import 'package:tic_tac_toe/game/base_game.dart';

class SinglePlayerGame extends BaseGame {
  void adversaryMove(int depth) {
    int bestMove = minimax(board, 'O', depth)['index'];
    board[bestMove] = 'O';
    if (isWinner(board, 'O')) {
      // _showSnackbar("You lost!");
      finished = true;
    }
  }

  void handleMove(int index, int depth) {
    if (finished) {
      return;
    }
    if (board[index] == '') {
      board[index] = 'X';
      if (!isGameOver()) {
        adversaryMove(depth);
      } else if (isWinner(board, 'X')) {
        // _showSnackbar("You won!");
        finished = true;
      } else {
        // _showSnackbar("It's a draw!");
        finished = true;
      }
    }
  }

  Map<String, dynamic> minimax(List<String> board, String player, int depth) {
    List<int> emptyCells = findEmptyCells(board);
    if (isWinner(board, 'O')) {
      return {'score': 1};
    } else if (isWinner(board, 'X')) {
      return {'score': -1};
    } else if (emptyCells.isEmpty || depth == 0) {
      return {'score': 0};
    }
    List<Map<String, dynamic>> moves = [];
    for (int index in emptyCells) {
      Map<String, dynamic> move = {};
      move['index'] = index;
      board[index] = player;
      var result = minimax(board, player == 'O' ? 'X' : 'O', depth - 1);
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
}
