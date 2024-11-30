import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/n_queens_provider.dart';
import '../widget/square.dart';

class Chessboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NQueensProvider>(context);
    return GridView.builder(
      itemCount: provider.n * provider.n,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
      itemBuilder: (ctx, index) {
        final row = index ~/ provider.n;
        final col = index % provider.n;
        return Square(isQueen: provider.board[row][col] == 1);
      },
    );
  }
}
