import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';

class WelcomeCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  const WelcomeCard(
      {super.key,
      required this.title,
      required this.description,
      required this.icon,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(0.0)),
      child: Row(
        children: [
          Container(
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                  color: color.withOpacity(0.1), shape: BoxShape.circle),
              child: Icon(
                icon,
                color: color,
              )),
          const SizedBox(
            width: 15.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: AppColors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(description, style: Theme.of(context).textTheme.titleSmall),
            ],
          ),
        ],
      ),
    );
  }
}
