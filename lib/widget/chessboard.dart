import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/n_queens_provider.dart';

class ChessBoard extends StatelessWidget {
  const ChessBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'N-Queens Visualization',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 156, 129, 204),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Expanded(
            child: Consumer<NQueensProvider>(
              builder: (context, provider, _) {
                final boardSize = MediaQuery.of(context).size.width * 0.9;
                return Center(
                  child: Container(
                    width: boardSize,
                    height: boardSize,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.deepPurple, width: 3),
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                        colors: [Colors.deepPurple, Colors.purpleAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Stack(
                      children: [
                        _buildGrid(provider.n, boardSize),
                        ..._buildQueens(provider, boardSize),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          _buildStatusBar(context),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildGrid(int n, double boardSize) {
    final cellSize = boardSize / n;

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: n,
      ),
      itemCount: n * n,
      itemBuilder: (context, index) {
        final row = index ~/ n;
        final col = index % n;
        final isBlack = (row + col) % 2 == 1;

        return Container(
          decoration: BoxDecoration(
            color: isBlack ? Colors.black : Colors.white,
          ),
        );
      },
    );
  }

  List<Widget> _buildQueens(NQueensProvider provider, double boardSize) {
    final cellSize = boardSize / provider.n;

    return provider.solution.asMap().entries.map((entry) {
      final col = entry.key;
      final row = entry.value;

      if (row == -1) return const SizedBox.shrink();

      return AnimatedPositioned(
        duration: const Duration(milliseconds: 500),
        top: row * cellSize,
        left: col * cellSize,
        child: SizedBox(
          width: cellSize,
          height: cellSize,
          child: Center(
            child: Icon(
              Icons.star,
              color: Colors.redAccent,
              size: cellSize * 0.7,
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildStatusBar(BuildContext context) {
    final provider = Provider.of<NQueensProvider>(context, listen: true);
    final solved = provider.solution.where((pos) => pos != -1).length;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Queens Placed: $solved / ${provider.n}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 16),
        solved == provider.n
            ? const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 24,
              )
            : const CircularProgressIndicator(),
      ],
    );
  }
}
