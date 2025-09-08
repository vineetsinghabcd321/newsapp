import 'package:flutter/material.dart';
import 'package:newsapp/Pages/landing_page.dart';

void main() {
  runApp(const newsapp());
}

class newsapp extends StatefulWidget {
  const newsapp({super.key});

  @override
  State<newsapp> createState() => _newsappState();
}

class _newsappState extends State<newsapp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blue),

      home: const LandingPage(),
    );
  }
}
