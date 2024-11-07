import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';

class CustomDropTextField extends StatelessWidget {
  final dynamic items;
  final String text;
  final Widget icon;
  final String? desc;
  final void Function(Object) onChanged;
  const CustomDropTextField(
      {super.key,
      required this.items,
      required this.text,
      required this.icon,
      this.desc,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      
      style: TextStyle(
          color: AppColors.secondary,
          fontWeight: FontWeight.bold,
          fontSize: 13.0),
      items: items,
      menuMaxHeight: 200.0,
      enableFeedback: true,
      borderRadius: BorderRadius.circular(20.0),
      dropdownColor: AppColors.primary,
      icon: const Icon(CupertinoIcons.chevron_compact_down),
      iconEnabledColor: AppColors.grey,
      // value: signUpCubit.countryId,
      onChanged: (value) => onChanged(value!),
      hint: Text(
        text,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      decoration: InputDecoration(
        // hintText: translateLang(context, 'country'),
        prefixIconColor: AppColors.grey,
        prefix:
            Container(margin: const EdgeInsets.only(right: 20.0,top: 0.0), child: icon),

        alignLabelWithHint: true,
        isDense: true,
        helperText: desc,
        helperStyle: Theme.of(context).textTheme.headlineMedium,
        hintStyle: Theme.of(context).textTheme.headlineSmall,
        filled: true,
        fillColor: AppColors.blurGreen,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
      ),
    );
  }
}
