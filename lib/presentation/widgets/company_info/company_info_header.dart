import 'package:flutter/material.dart';

class CompanyInfoHeader extends StatelessWidget {
  final String company;
  final String location;
  final IconData rateIcon;
  final double ratevalue;
  final Color color;
  const CompanyInfoHeader(
      {super.key,
      required this.company,
      required this.location,
      required this.rateIcon,
      required this.ratevalue,
      this.color = Colors.amber});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // const SizedBox(width: 5.0),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(company, style: Theme.of(context).textTheme.headlineLarge),
          const SizedBox(
            height: 5.0,
          ),
          Text(location, style: Theme.of(context).textTheme.titleSmall),
        ]),
        const Spacer(),
        Column(
          children: [
            Icon(
              rateIcon,
              color: color,
              size: 30.0,
            ),
            Text(
              ratevalue.toString(),
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: color),
            )
          ],
        ),
      ],
    );
  }
}
