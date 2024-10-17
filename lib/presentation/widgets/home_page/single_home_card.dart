import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';

class SingleHomeCard extends StatelessWidget {
  final IconData icon;
  final int number;
  final String text;
  final Color color;
  final double height;
  const SingleHomeCard(
      {super.key,
      required this.icon,
      required this.number,
      required this.text,
      required this.color,
      this.height = 130.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      //width: 200.0,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Icon(
              icon,
              color: AppColors.grey,
              size: 70.0,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                number.toString(),
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
