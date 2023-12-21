import 'package:tic_tac_toe/game/base_game.dart';

class MultiPlayerGame extends BaseGame {
  String player = 'X';
  void handleMove(int index) {
    if (finished) {
      return;
    }
    board[index] = player;
    player = player == 'X' ? 'O' : 'X';

    if (isWinner(board, 'X')) {
      finished = true;
    } else if (isWinner(board, 'O')) {
      finished = true;
    } else if (findEmptyCells(board).isEmpty) {
      finished = true;
    }
  }
}