import 'package:flutter/material.dart';
import 'package:utility_widgets/utility_widgets.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
              child: ElevatedButton(
            child: const Text('スナックバーを表示'),
            onPressed: () {
              showCustomSnackbar(context, 'スナックバーを表示しました');
            },
          )),
        ],
      ),
    );
  }
}
