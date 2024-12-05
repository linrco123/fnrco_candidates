import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/data/models/management_content/faqs_model.dart';
import 'package:fnrco_candidates/ui/widgets/management_content/faq_details.dart';
import 'package:html/parser.dart' as html_parser;
class FAQCard extends StatelessWidget {
  final FAQ faq;
  const FAQCard({
    Key? key,
    required this.faq,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FAQDetails(faq:faq)));
      },
      child: Container(
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
              children: [
                Expanded(
                  child: Text(
                    faq.title!,
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(color: AppColors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    html_parser
                        .parse(faq.desc!)
                        .body!
                        .text,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],),
      
            // HtmlWidget(
            //   faq.desc!,
            //   enableCaching: true,
            //   buildAsync: true,
              
             
            // ),
            const SizedBox(height: 10.0,),
            Row(
              children: [
                Text(
                  'Status: ',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                Text(
                  faq.status!,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}

