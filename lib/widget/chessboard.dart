import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/n_queens_provider.dart';
import 'square.dart';

class ChessBoard extends StatelessWidget {
  const ChessBoard({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NQueensProvider>(context);
    final boardSize =
        MediaQuery.of(context).size.width - 32; // Assuming square board

    return Container(
      decoration: const BoxDecoration(color: Colors.grey),
      child: SizedBox(
        width: boardSize,
        height: boardSize,
        child: Stack(
          children: [
            GridView.builder(
              itemCount: provider.n * provider.n,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: provider.n,
              ),
              itemBuilder: (context, index) {
                final row = index ~/ provider.n;
                final col = index % provider.n;
                return Square(row: row, col: col);
              },
            ),
            ..._buildAnimatedQueens(context, provider, boardSize),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildAnimatedQueens(
      BuildContext context, NQueensProvider provider, double boardSize) {
    final cellSize = boardSize / provider.n;

    return provider.solution.asMap().entries.map((entry) {
      final col = entry.key;
      final row = entry.value;

      if (row == -1) return const SizedBox.shrink();

      return AnimatedPositioned(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        top: row * cellSize + 30,
        left: col * cellSize + 20,
        child: SizedBox(
          width: cellSize,
          height: cellSize,
          child: Center(
            child: Image.asset(
              'assets/images/queen.png',
              fit: BoxFit.contain,
            ),
          ), // Add a chess queen image
        ),
      );
    }).toList();
  }
}
