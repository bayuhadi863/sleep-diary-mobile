import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        const SizedBox(
          height: 22,
        ),
        _greetings(),
        const SizedBox(
          height: 17,
        ),
        _header()
      ],
    )));
  }

  AspectRatio _header() {
    return AspectRatio(
      aspectRatio: 336 / 135,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(255, 121, 60, 60),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: const Text("Halo", style: TextStyle(),)),
            Image.asset('assets/images/bulan.png'),
            
          ],
        ),
      ),
    );  
  }

  Padding _greetings() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Hello, Argya!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
          IconButton(onPressed: () {}, icon: const Icon(FeatherIcons.user)),
        ],
      ),
    );
  }
}
