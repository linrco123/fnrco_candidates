import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

showSuccessSnackBar(context, {required String text}) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 5.0,
      content: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .headlineMedium!
            .copyWith(color: AppColors.white),
      ),
      backgroundColor: AppColors.success,
    ));

showErrorSnackBar(context, {required String text}) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 5.0,
      content: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .headlineMedium!
            .copyWith(color: AppColors.white),
      ),
      backgroundColor: AppColors.danger,
    ));

showGeneralSnackBar(context, {required Widget widget,   Color color = Colors.black}) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 5.0,
      content: widget,
      backgroundColor: color,
    ));
