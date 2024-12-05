// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/models/profile_get/contacts_model.dart';
import 'package:fnrco_candidates/ui/widgets/profile/title_text.dart';

class ContactCard extends StatelessWidget {
  final GetContact contact;
  const ContactCard({
    Key? key,
    required this.contact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: AppColors.primary.withOpacity(0.1),
                blurRadius: 5.0,
                spreadRadius: 5.0,
                blurStyle: BlurStyle.outer,
                offset: Offset(0, 1))
          ],
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10.0),
          border: BorderDirectional(
              top: BorderSide(color: AppColors.primary, width: 5.0),
              bottom: BorderSide(color: AppColors.primary, width: 5.0))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                contact.personContactPrimary! == '1'
                    ? translateLang(context,'primary')
                    : translateLang(context,'not_primary'),
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTitle(
                title: "contact_type",
              ),
              Text(
                contact.personContactType!,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTitle(
                title: "contact_value",
              ),
              Expanded(
                child: Text(
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  contact.personContactValue!,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
