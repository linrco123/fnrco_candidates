import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';

class SearchFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData preIcon;
  final void Function() preFun;
  final IconData sufIcon;
  final void Function() suFun;
  final double width;
  final Color borderColor;
  final Color? fillColor;

  const SearchFormField(
      {super.key,
      required this.controller,
      required this.label,
      required this.preIcon,
      required this.preFun,
      this.width = 0,
      this.borderColor = const Color(0xFFFFFFFF),
      this.fillColor,
      required this.sufIcon,
      required this.suFun});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context)
          .textTheme
          .headlineSmall!
          .copyWith(color: AppColors.secondary), 
      controller: controller,
      onFieldSubmitted: (value) => preFun,
      keyboardType: TextInputType.text,
      maxLines: 1,
      decoration: InputDecoration(
          filled: true,
          fillColor: fillColor,
          hintStyle: Theme.of(context).textTheme.headlineSmall,
          hintText: label,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(width: width, color: borderColor)
              ),
          prefixIcon: IconButton(
              onPressed: preFun,
              icon: Icon(
                preIcon,
                color: AppColors.grey,
              )),
          suffixIcon: IconButton(
              onPressed: suFun,
              icon: Icon(
                sufIcon,
                size: 17.0,
                color: AppColors.primary,
              ))),
    );
  }
}
