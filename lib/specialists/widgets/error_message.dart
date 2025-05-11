import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String message;

  const ErrorMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 64.0),
            const SizedBox(height: 16.0),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16.0, color: Colors.redAccent),
            ),
          ],
        ),
      ),
    );
  }
}
