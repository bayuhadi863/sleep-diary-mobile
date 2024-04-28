import 'package:flutter/material.dart';

class StatistikPage extends StatefulWidget {
  const StatistikPage({super.key});

  @override
  State<StatistikPage> createState() => _StatistikPageState();
}

class _StatistikPageState extends State<StatistikPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(8, 10, 35, 1),
      body: Center(
        child: Text('Halaman Statistik User'),
      ),
    );
  }
}
