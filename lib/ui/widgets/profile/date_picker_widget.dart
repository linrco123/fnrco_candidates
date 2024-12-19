// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fnrco_candidates/constants/app_colors.dart';

class CustomDatePicker extends StatelessWidget {
  
  final void Function()? onTap;
  final String text;

  const CustomDatePicker({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
        width: double.infinity,
        // height: 50.0,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16.0)),
        child: Row(
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const Spacer(),
            Icon(
              CupertinoIcons.calendar,
              size: 25.0,
              color: AppColors.primary,
            )
          ],
        ),
      ),
    );
  }
}
