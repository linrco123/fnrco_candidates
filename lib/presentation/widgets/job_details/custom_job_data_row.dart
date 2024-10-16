import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';

class CustomJobDataRow extends StatelessWidget {
  final Widget child;
  final Color color;
  final bool border;
  final String title;
  final String subTitle;
  const CustomJobDataRow(
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              subTitle,
              style: Theme.of(context).textTheme.labelMedium
            ),
          ],
        ),
      ],
    );
  }
}
