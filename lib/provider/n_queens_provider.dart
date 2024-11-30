import 'package:flutter/material.dart';

class NQueensProvider extends ChangeNotifier {
  int n = 8;
  List<List<int>> board = [];
  List<int> solution = [];

  NQueensProvider() {
    initialzeBoard();
    solveNQueens();
  }

  void initialzeBoard() {
    board = List.generate(n, (_) => List.filled(n, 0));
    solution = List.filled(n, -1);
  }

  bool isSafe(int row, int col) {
    for (int i = 0; i < col; i++) {
      if (solution[i] == row ||
          solution[i] - i == row - col ||
          solution[i] + i == row + col) {
        return false;
      }
    }
    return true;
  }

  bool solveNQueensRecursive(int col) {
    if (col >= n) return true;
    for (int i = 0; i < n; i++) {
      if (isSafe(i, col)) {
        solution[col] = i;
        if (solveNQueensRecursive(col + 1)) {
          return true;
        }
        solution[col] = -1;
      }
    }
    return false;
  }

  void solveNQueens() {
    if (solveNQueensRecursive(0)) {
      for (int i = 0; i < n; i++) {
        board[solution[i]][i] = 1;
      }
    }
    notifyListeners();
  }
}
