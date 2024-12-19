import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/data/models/management_content/faqs_model.dart';

class FAQCard extends StatefulWidget {
  final FAQ faq;
  const FAQCard({
    Key? key,
    required this.faq,
  }) : super(key: key);

  @override
  State<FAQCard> createState() => _FAQCardState();
}

class _FAQCardState extends State<FAQCard> {
  bool containsShowed = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          containsShowed = !containsShowed;
        });
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => FAQDetails(faq: widget.faq)));
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: AppColors.white,
                blurRadius: 5.0,
                spreadRadius: 5.0,
                blurStyle: BlurStyle.outer,
                offset: Offset(0, 1))
          ],
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10.0),
          // border: BorderDirectional(
          //     top: BorderSide(color: AppColors.primary, width: 5.0),
          // bottom: BorderSide(color: AppColors.primary, width: 5.0))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    widget.faq.title!,
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(color: AppColors.black),
                  ),
                ),
                const SizedBox(
                  width: 30.0,
                ),
                !containsShowed
                    ? Icon(Icons.keyboard_arrow_down)
                    : Icon(Icons.arrow_forward_ios,size: 17,)
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Visibility(
              visible: containsShowed,
              child: HtmlWidget(
                widget.faq.desc!,
                enableCaching: true,
                buildAsync: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
