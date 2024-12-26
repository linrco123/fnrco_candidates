// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/data/models/management_content/survies_model.dart';
//import 'package:html/parser.dart' as html_parser;
class SurveyCard extends StatelessWidget {
  final Survey survey;
  const SurveyCard({
    Key? key,
    required this.survey,
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
          color:Colors.grey.shade100,
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
            survey.surveyName!,
            style: Theme.of(context)
                .textTheme
                .headlineLarge
          ),
          const SizedBox(
            height: 10.0,
          ),
          // Row(
          //   children: [
          //     Expanded(
          //       child: Text(
          //         textAlign: TextAlign.justify,
          //         overflow: TextOverflow.ellipsis,
          //         maxLines: 3,
          //         html_parser
          //             .parse(survey.surveyDesc!)
          //             .body!
          //             .text,
          //         style: Theme.of(context).textTheme.bodySmall,
          //       ),
          //     ),
          //   ],),

          HtmlWidget(
            survey.surveyDesc!,
            enableCaching: true,
            buildAsync: true,
            onTapImage: (image){
              //print('===============iamge meta data ============');
            },
          ),

          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              Text(
                'Survey By: ',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Text(
                survey.surveyBy!,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
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
                survey.surveyFrom!,
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
                survey.surveyTo!,
                style: Theme.of(context).textTheme.labelMedium,
              )
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              Text(
                'Status: ',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Text(
                survey.surveyStatus!,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }
}
