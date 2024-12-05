import 'package:flutter/material.dart';

class CustomProfileText extends StatelessWidget {
  final String text;
  const CustomProfileText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headlineLarge,
    );
  }
}
