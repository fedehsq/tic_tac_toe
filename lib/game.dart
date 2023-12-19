class Game {
  static const List<List<int>> winningCases = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [2, 4, 6],
    [0, 4, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8]
  ];
  final List<String> board = List.filled(9, '');
  bool finished = false;

  void resetBoard() {
    board.fillRange(0, 9, '');
    finished = false;
  }


  bool isWinner(List<String> board, String player) {
    for (var winningCase in winningCases) {
      if (board[winningCase[0]] == player &&
          board[winningCase[1]] == player &&
          board[winningCase[2]] == player) {
        return true;
      }
    }
    return false;
  }

  List<int> findEmptyCells(List<String> board) {
    List<int> emptyCells = [];
    for (int i = 0; i < board.length; i++) {
      if (board[i] == '') {
        emptyCells.add(i);
      }
    }
    return emptyCells;
  }
}