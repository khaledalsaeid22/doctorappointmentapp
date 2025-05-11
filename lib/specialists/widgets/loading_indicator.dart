import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final String? text;

  const LoadingIndicator({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          if (text != null && text!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(text!),
            ),
        ],
      ),
    );
  }
}
