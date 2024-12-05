


// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/data/models/management_content/faqs_model.dart';
import 'package:fnrco_candidates/ui/widgets/return_btn.dart';

class FAQDetails extends StatelessWidget {
  final FAQ faq;
  FAQDetails({
    Key? key,
    required this.faq,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'FAQ Details',
            style: TextStyle(color: AppColors.primary),
          ),
          centerTitle: true,
          leading: ReturnButton()),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding:  const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(16.0)
                ),
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        textAlign: TextAlign.justify,
                        faq.title!,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(color: AppColors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
             
              HtmlWidget(
                faq.desc!,
                enableCaching: true,
                buildAsync: true,
                
               
              ),
              const SizedBox(height: 10.0,),
              
             
            ],
          ),
        ),
      )
    );
  }
}
