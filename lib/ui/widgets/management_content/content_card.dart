// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/data/models/management_content/contents_model.dart';


 class ContentCard extends StatelessWidget {
  final DataContent content;
  const ContentCard
({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //       color: AppColors.primary.withOpacity(0.1),
          //       blurRadius: 5.0,
          //       spreadRadius: 5.0,
          //       blurStyle: BlurStyle.outer,
          //       offset: Offset(0, 1))
          // ],
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10.0),
          // border: BorderDirectional(
          //     top: BorderSide(color: AppColors.primary, width: 5.0),
          //     bottom: BorderSide(color: AppColors.primary, width: 5.0))
          ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            content.contentText!,
            style: Theme.of(context)
                .textTheme
                .headlineLarge,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              Icon(
                Icons.calendar_month,
                color: AppColors.primary,
                size: 20.0,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Text(
               content.contentFrom!.split(' ').first,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  'to',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              Text(
               content.contentTo!.split(' ').first,
                style: Theme.of(context).textTheme.labelMedium,
              )
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          const SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }
}
