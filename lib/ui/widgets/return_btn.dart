import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class ReturnButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final void Function()? onPressed;
  ReturnButton(
      {super.key,
      this.icon = Icons.arrow_back_ios_new_outlined,
      this.color = const Color(0xFFae1f23),
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed ??
            () {
              Navigator.of(context).pop();
            },
        icon: Icon(
          icon,
          color: color,
        ));
  }
}

class CounterButton extends StatelessWidget {
  final String text;
  final void Function() onTap;
  const CounterButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.0,
        width: 40.0,
        color: AppColors.grey.withOpacity(0.1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25.0, color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}
