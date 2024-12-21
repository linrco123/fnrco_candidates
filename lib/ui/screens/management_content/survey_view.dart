// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/functions/show_toast.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/management_content/surveys.dart';
import 'package:fnrco_candidates/logic/cubit/management_content/survies/surveys_cubit.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/ui/widgets/custom_divider.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/management_content/answer_card.dart';
import 'package:fnrco_candidates/ui/widgets/profile/custom_text_field.dart';
import 'package:fnrco_candidates/ui/widgets/return_btn.dart';
import 'package:toastification/toastification.dart';

class SurveyViewScreen extends StatelessWidget {
  final SurveysProvider surviesProvider = SurveysProvider();
  SurveyViewScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text(
            'Survey View',
            style: TextStyle(color: AppColors.primary),
          ),
          centerTitle: true,
          leading: ReturnButton()),
      body: AnimatedSwitcher(
        duration: const Duration(seconds: 3),
        reverseDuration: const Duration(seconds: 2),
        switchInCurve: Curves.bounceIn,
        switchOutCurve: Curves.bounceInOut,
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(15.0),
          child: BlocConsumer<SurveysCubit, SurveysState>(
            listener: (context, state) {
              if (state is PickSurveyAnswerState) {
                showToast(context,
                    title: translateLang(context, 'warning'),
                    desc: "Please , choose an expressible answer",
                    type: ToastificationType.warning);
              }
              if (state is SubmitSurveyViewSuccessState) {
                Navigator.of(context).pop();
                showToast(context,
                    title: translateLang(context, 'success'),
                    desc: translateLang(context, "msg_survey_success"),
                    type: ToastificationType.success);
              }
              if (state is SubmitSurveyViewFailureState) {
                showToast(context,
                    title: translateLang(context, 'error'),
                    desc: translateLang(context, "msg_request_failure"),
                    type: ToastificationType.error);
              }
            },
            builder: (context, state) {
              var surveysCubit = BlocProvider.of<SurveysCubit>(context);
              if (state is SurveysViewLoadingState) {
                return Center(
                  child: AnimatedLoadingWidget(),
                );
              }
              if (state is SurveysViewFailureState) {
                return Center(
                  child: Text('Some Error occurs'),
                );
              }

              return Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              surveysCubit
                                  .surveyViewQuestions[
                                      surveysCubit.question_number]
                                  .surveyQuestionText!,
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                          ),
                        ],
                      ),
                      CustomDivider(),
                      const SizedBox(
                        height: 15.0,
                      ),
                      if (surveysCubit
                              .surveyViewQuestions[surveysCubit.question_number]
                              .surveyQuestionType ==
                          'text')
                        CustomInputField(
                            hint: translateLang(context, "enter_answer"),
                            linesNum: 7,
                            controller: surveysCubit.answerCntroller,
                            inputType: TextInputType.text,
                            validate: (context, value) => ''),
                      if (surveysCubit
                              .surveyViewQuestions[surveysCubit.question_number]
                              .surveyQuestionType ==
                          'option')
                        ...List.generate(
                          surveysCubit
                              .surveyViewQuestions[surveysCubit.question_number]
                              .options!
                              .length,
                          (int index) => InkWell(
                              onTap: () {
                                surveysCubit.chooseAnswer(surveysCubit
                                    .surveyViewQuestions[
                                        surveysCubit.question_number]
                                    .options![index]
                                    .surveyQuestionOptText!);
                              },
                              child: AnswerCard(
                                  answerReference: surveysCubit.answer,
                                  answer: surveysCubit
                                      .surveyViewQuestions[
                                          surveysCubit.question_number]
                                      .options![index]
                                      .surveyQuestionOptText!)),
                        ),
                      const Spacer(),
                      CustomElevatedButton(
                          fun: () {
                            surveysCubit.submitSurveyViewQuestion(surveysCubit
                                .surveyViewQuestions[
                                    surveysCubit.question_number]
                                .id!);
                          },
                          background: AppColors.primary,
                          text: translateLang(
                              context,
                              surveysCubit.question_number ==
                                      surveysCubit.surveyViewQuestions.length -
                                          1
                                  ? "submit"
                                  : 'next'))
                    ],
                  ),
                  if (state is SubmitSurveyViewLoadingState)
                    AnimatedLoadingWidget()
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
