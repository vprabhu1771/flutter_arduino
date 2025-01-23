import 'package:flutter/material.dart';

class LedBlinkScreen extends StatefulWidget {

  final String title;

  const LedBlinkScreen({super.key, required this.title});

  @override
  State<LedBlinkScreen> createState() => _LedBlinkScreenState();
}

class _LedBlinkScreenState extends State<LedBlinkScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(widget.title),
      ),
    );
  }
}
