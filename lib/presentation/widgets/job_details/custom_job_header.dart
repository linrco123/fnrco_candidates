import 'package:flutter/material.dart';

class CustomJobHeader extends StatelessWidget {
  final String company;
  final Color companyColor;
  final String job;
  final Color jobColor;
  final String image;
  const CustomJobHeader(
      {super.key,
      required this.company,
      required this.companyColor,
      required this.job,
      required this.jobColor,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(company,
                  style: TextStyle(
                    fontSize: 17.0,
                    color: companyColor,
                  )),
              Text(
                job,
                style: TextStyle(
                  fontSize: 22.0,
                  color: jobColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        // const Spacer(),
        Expanded(
          flex: 1,
          child: Image.asset(
            image,
            height: 80.0,
            width: 80.0,
          ),
        ),
      ],
    );
  }
}
