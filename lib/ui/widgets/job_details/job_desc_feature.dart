import 'package:flutter/material.dart';
import '../../../constants/app_images_path.dart';

class CustomCheckedJobFeature extends StatelessWidget {
  final String text;
  const CustomCheckedJobFeature({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Row(
        children: [
          Image.asset(AppImages.CHECKED, height: 15.0, width: 15.0),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text,
                style: Theme.of(context).textTheme.bodyMedium),
          )
        ],
      ),
    );
  }
}
