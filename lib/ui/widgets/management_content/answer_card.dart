// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';

class AnswerCard extends StatelessWidget {
  final String answerReference;
  final String answer;
  const AnswerCard({
    Key? key,
    required this.answerReference,
    required this.answer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color:
              answerReference == answer ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 10.0,
              width: 10.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary
              ),
            ),
            const SizedBox(width: 10.0,),
            Expanded(
              child: Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                answer,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: 20.0,
                    color: answerReference == answer
                        ? AppColors.white
                        : AppColors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
