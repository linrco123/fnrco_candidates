// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fnrco_candidates/constants/app_colors.dart';

class CustomDropTextField extends StatelessWidget {
  final dynamic items;
  final String text;
  final Widget icon;
  final String? desc;
  final int? value;
  final void Function(Object) onChanged;
  const CustomDropTextField(
      {super.key,
      required this.items,
      required this.text,
      required this.icon,
      this.desc,
      required this.onChanged,
      this.value});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      style: Theme.of(context)
          .textTheme
          .labelMedium!
          .copyWith(color: AppColors.greyDeep, fontWeight: FontWeight.w400),
      items: items,
      menuMaxHeight: 200.0,
      enableFeedback: true,
      borderRadius: BorderRadius.circular(16.0),
      dropdownColor: AppColors.white,

      icon: const Icon(CupertinoIcons.chevron_compact_down),
      iconEnabledColor: AppColors.grey,
      // value: signUpCubit.countryId,
      onChanged: (value) => onChanged(value!),
      hint: Text(
        text,
      ),
      decoration: InputDecoration(
        // hintText: translateLang(context, 'country'),
        prefixIconColor: AppColors.grey,
        prefix: Container(
            margin: const EdgeInsets.only(right: 20.0, top: 0.0), child: icon),

        alignLabelWithHint: true,
        isDense: true,
        helperText: desc,
        hintStyle: Theme.of(context)
            .textTheme
            .labelMedium!
            .copyWith(color: AppColors.greyDeep, fontWeight: FontWeight.w400),
        filled: true,
        fillColor: AppColors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary),
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
      ),
    );
  }
}

class CustomDropDownSearch extends StatelessWidget {
  final String selectedItem;
  final List<String> items;
  final String label;
  final bool isSearchEnabled;
  final void Function(String?)? onChanged;
  final Widget? widget;
  const CustomDropDownSearch({
    Key? key,
    required this.selectedItem,
    required this.items,
    required this.label,
    this.onChanged,
    this.isSearchEnabled = true,
     this.widget,
  }) : super(key: key);

  ///
  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      //key: dropDownKey,
      mode: Mode.form,
      suffixProps: DropdownSuffixProps(),
      selectedItem: selectedItem,
      clickProps: ClickProps(
          highlightColor: AppColors.primary,
          borderRadius: BorderRadius.circular(16.0),
          highlightShape: BoxShape.rectangle),

      items: (filter, infiniteScrollProps) => items,
      decoratorProps: DropDownDecoratorProps(
        baseStyle: Theme.of(context).textTheme.labelMedium,
        decoration: InputDecoration(
          prefixIcon: widget,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
          labelText: label,
          labelStyle: Theme.of(context).textTheme.labelMedium,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(16.0),
            gapPadding: 5.0,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(16.0),
            gapPadding: 5.0,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary),
            borderRadius: BorderRadius.circular(16.0),
            gapPadding: 5.0,
          ),
        ),
      ),
      onChanged: onChanged,
      popupProps: PopupProps.menu(
          showSelectedItems: true,
          fit: FlexFit.loose,
          constraints: BoxConstraints(),
          listViewProps: ListViewProps(clipBehavior: Clip.antiAlias),
          showSearchBox: isSearchEnabled),
    );
  }
}
