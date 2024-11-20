// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/management_contect/surveys.dart';
import 'package:fnrco_candidates/logic/cubit/survies/surveys_cubit.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';

class SurveyViewScreen extends StatelessWidget {
  final SurveysProvider surviesProvider = SurveysProvider();
  SurveyViewScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          'Survey View',
          style: TextStyle(color: AppColors.primary),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.primary,
            )),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(15.0),
        child: BlocBuilder<SurveysCubit, SurveysState>(
          builder: (context, state) {
            var surveysCubit = BlocProvider.of<SurveysCubit>(context);
            if (state is SurveysViewLoadingState) {
              return Center(
                child: LoadingWidget(),
              );
            }
            if (state is SurveysViewFailureState) {
              return Center(
                child: Text('Some Error occurs'),
              );
            }
            if (state is SurveysViewSuccessState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          surveysCubit
                              .surveyViewQuestions[surveysCubit.question_number]
                              .surveyQuestionText!,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  ...List.generate(
                    surveysCubit
                        .surveyViewQuestions[surveysCubit.question_number]
                        .options!
                        .length,
                    (int index) => InkWell(
                      onTap: () {

                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 5.0),
                        child: Row(
                          children: [
                            Text(
                              surveysCubit
                                  .surveyViewQuestions[
                                      surveysCubit.question_number]
                                  .options![index]
                                  .surveyQuestionOptText!,
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Text(
                  //   surveysCubit
                  //       .surveyViewQuestions[surveysCubit.question_number]
                  //       .options![0]
                  //       .surveyQuestionOptText!,
                  //   style: Theme.of(context).textTheme.headlineLarge,
                  // ),
                  // const SizedBox(
                  //   height: 10.0,
                  // ),
                  // Text(
                  //   surveysCubit
                  //       .surveyViewQuestions[surveysCubit.question_number]
                  //       .options![1]
                  //       .surveyQuestionOptText!,
                  //   style: Theme.of(context).textTheme.headlineLarge,
                  // ),
                  // const SizedBox(
                  //   height: 10.0,
                  // ),
                  // Text(
                  //   surveysCubit
                  //       .surveyViewQuestions[surveysCubit.question_number]
                  //       .options![2]
                  //       .surveyQuestionOptText!,
                  //   style: Theme.of(context).textTheme.headlineLarge,
                  // ),
                  // const SizedBox(
                  //   height: 10.0,
                  // ),
                  // Text(
                  //   surveysCubit
                  //       .surveyViewQuestions[surveysCubit.question_number]
                  //       .options![3]
                  //       .surveyQuestionOptText!,
                  //   style: Theme.of(context).textTheme.headlineLarge,
                  // ),
                  const Spacer(),
                  CustomElevatedButton(
                      fun: () {},
                      background: AppColors.primary,
                      text: translateLang(context, 'next'))
                ],
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
