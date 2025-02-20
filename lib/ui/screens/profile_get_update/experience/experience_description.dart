// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/ui/widgets/return_btn.dart';

class ExperienceDescriptionScreen extends StatelessWidget {
  final String description;
  const ExperienceDescriptionScreen({
    Key? key,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          translateLang(context, "exper_desc"),
          style: TextStyle(
            color: AppColors.primary,
          ),
        ),
        centerTitle: true,
        leading: ReturnButton(),
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: HtmlWidget(description),
    );
  }
}
