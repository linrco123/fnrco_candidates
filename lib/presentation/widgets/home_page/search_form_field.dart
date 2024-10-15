import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';

class SearchFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final void Function() fun;

  const SearchFormField(
      {super.key,
      required this.controller,
      required this.label,
      required this.icon,
      required this.fun});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onFieldSubmitted: (value)=>fun,
      keyboardType: TextInputType.text,
      maxLines: 1,
      decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.white,
          hintStyle: Theme.of(context).textTheme.headlineSmall,
          hintText: label,
          
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              )),
          prefixIcon: IconButton(
              onPressed: fun,
              icon: Icon(
                icon,
                color: AppColors.grey,
              ))),
    );
  }
}
