 import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';

class SocialMediaButton extends StatelessWidget {
  final String image;
  final double dimension;
  final void Function()? onPressed;

  const SocialMediaButton({super.key, required this.image, this.onPressed, required this.dimension});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      elevation: 5.0,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        child: Image.asset(
          image,
          height: dimension,
          width: dimension,
        ),
      ),
    );

  }
}
