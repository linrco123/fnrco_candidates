import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';

class CustomItemFeature extends StatelessWidget {
  final Widget child;
  final Color color;
  final bool border;
  final String title;
  final String subTitle;
  const CustomItemFeature(
      {super.key,
      required this.child,
      required this.color,
      required this.border,
      required this.title,
      required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              color: color,
              border: border
                  ? Border.all(color: AppColors.primary, width: 1)
                  : null,
              shape: BoxShape.circle),
          child: child
        ),
        const SizedBox(
          width: 15.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                subTitle,
                style: Theme.of(context).textTheme.labelMedium
              ),
            ],
          ),
        ),
      ],
    );
  }
}
