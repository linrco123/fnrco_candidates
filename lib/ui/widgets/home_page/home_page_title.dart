import 'package:flutter/material.dart';

class CustomHomeTitle extends StatelessWidget {
  final String title;
  final Color color;
  const CustomHomeTitle({super.key, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(color: color),
      ),
    );
  }
}
