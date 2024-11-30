import 'dart:async'; // Import to add delay
import 'package:flutter/material.dart';

class NQueensProvider extends ChangeNotifier {
  int n = 8; // Default board size
  List<List<int>> board = [];
  List<int> solution = [];

  NQueensProvider() {
    initializeBoard();
    solveNQueens();
  }

  void initializeBoard() {
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

  Future<bool> solveNQueensRecursive(int col) async {
    if (col >= n) return true;

    for (int i = 0; i < n; i++) {
      if (isSafe(i, col)) {
        solution[col] = i;
        notifyListeners();
        await Future.delayed(const Duration(milliseconds: 500)); // Add delay

        if (await solveNQueensRecursive(col + 1)) {
          return true;
        }

        solution[col] = -1; // Backtrack
        notifyListeners();
        await Future.delayed(const Duration(milliseconds: 500));
      }
    }
    return false;
  }

  void solveNQueens() {
    solveNQueensRecursive(0);
  }
}
