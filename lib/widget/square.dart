import 'package:flutter/material.dart';

class Square extends StatelessWidget {
  final int row;
  final int col;

  const Square({required this.row, required this.col, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: (row + col) % 2 == 0 ? Colors.white : Colors.black,
    );
  }
}
