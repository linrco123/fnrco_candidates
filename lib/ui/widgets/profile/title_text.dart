import 'package:flutter/material.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';

class CustomTitle extends StatelessWidget {
  final String title;
  const CustomTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          width: 10.0,
        ),
        Text(
          translateLang(context, title),
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ],
    );
  }
}
