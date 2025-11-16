import 'package:flutter/material.dart';

class TextError extends StatelessWidget {
  const TextError({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {

    return Text(text, style: TextStyle(color: Colors.red, fontSize: 16));
  }
}
