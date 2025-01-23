import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/Constants.dart';

class LedBlinkScreen extends StatefulWidget {

  final String title;

  const LedBlinkScreen({super.key, required this.title});

  @override
  State<LedBlinkScreen> createState() => _LedBlinkScreenState();
}

class _LedBlinkScreenState extends State<LedBlinkScreen> {

  bool isLoading = false;

  Future<void> controlLed(String action) async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(Constants.BASE_URL + Constants.BLINK_LED);
    final headers = {'Content-Type': 'application/json'};
    final body = {'blink': action};

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('LED ${action == "1" ? "turned ON" : "turned OFF"}')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to control LED: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => controlLed("1"), // "1" to turn ON
              child: const Text('Turn ON LED'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => controlLed("0"), // "0" to turn OFF
              child: const Text('Turn OFF LED'),
            ),
          ],
        ),
      ),
    );
  }
}