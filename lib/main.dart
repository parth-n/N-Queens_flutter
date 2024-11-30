import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/n_queens_provider.dart';
import 'screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NQueensProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'N-Queens Visualizer',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HomeScreen(),
      ),
    );
  }
}
