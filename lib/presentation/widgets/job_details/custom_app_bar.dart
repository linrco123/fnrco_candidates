import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/presentation/widgets/job_details/back_btn.dart';

class CustomAppBar extends StatelessWidget {
  final Color btnColor;
  final Color arrowColor;
  final String title;
  final IconData icon;
  final Color titleColor;
  final void Function()? onTap;
  
  final double startPadding ;
  CustomAppBar(
      {super.key,
      required this.title,
      this.onTap,
      this.startPadding = 0.0,
      required this.arrowColor,
      required this.btnColor,
      required this.icon,
      required this.titleColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: startPadding,),
        CustomBackBTN(
          btnColor: btnColor,
          arrowColor: arrowColor,
        ),
        const SizedBox(width: 10.0),
        Text(title,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: titleColor)),
        const Spacer(),
        IconButton(
          onPressed: onTap,
          icon: Icon(
          icon,
            color: arrowColor,
            size: 25.0,
          ),
        ),
      ],
    );
  }
}
