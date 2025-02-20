// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/app_pages_names.dart';
import 'package:fnrco_candidates/logic/cubit/management_content/polls/polls_cubit.dart';
import 'package:fnrco_candidates/ui/widgets/custom_divider.dart';
import 'package:fnrco_candidates/ui/widgets/empty_data_widget.dart';
import 'package:fnrco_candidates/ui/widgets/management_content/answer_card.dart';
import 'package:toastification/toastification.dart';

import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/functions/show_toast.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/management_content/surveys.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/return_btn.dart';

class PollsViewScreen extends StatelessWidget {
  final SurveysProvider surviesProvider = SurveysProvider();
  PollsViewScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text(
            'Poll View',
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
          child: BlocConsumer<PollsCubit, PollsState>(
            listener: (context, state) {
              if (state is PickPollAnswerState) {
                showToast(context,
                    title: translateLang(context, 'warning'),
                    desc: "Please , choose an expressible answer",
                    type: ToastificationType.warning);
              }

              if (state is SubmitPollViewSuccessState) {
                showToast(context,
                    title: translateLang(context, 'success'),
                    desc: translateLang(context, "msg_poll_success"),
                    type: ToastificationType.success);

                Navigator.of(context).pushNamed(
                  AppPagesNames.percentage,
                  arguments: {
                    'percentage':state.votePercentages,
                    'question':state.question
                  }
                );
                
              }
              if (state is SubmitPollViewFailureState) {
                showToast(context,
                    title: translateLang(context, 'error'),
                    desc: translateLang(context, "msg_request_failure"),
                    type: ToastificationType.error);
              }
            },
            builder: (context, state) {
              var pollCubit = BlocProvider.of<PollsCubit>(context);
              if (state is PollsViewLoadingState) {
                return const AnimatedLoadingWidget();
              }
              if (state is PollsViewFailureState) {
                return const EmptyDataWidget(
                  message: 'No poll View contents Yet !!!',
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
                              textAlign: TextAlign.justify,
                              pollCubit
                                  .pollViewQuestions[pollCubit.question_number],
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                          ),
                        ],
                      ),
                      const CustomDivider(),
                      const SizedBox(
                        height: 15.0,
                      ),
                      ...List.generate(
                        pollCubit.pollView!.options!.length,
                        (int index) => InkWell(
                            onTap: () {
                              pollCubit.chooseAnswer(pollCubit
                                  .pollView!.options![index].pollOptText!);
                            },
                            child: AnswerCard(
                                answerReference: pollCubit.answer,
                                answer: pollCubit
                                    .pollView!.options![index].pollOptText!)),
                      ),
                      const Spacer(),
                      CustomElevatedButton(
                        fun: () {
                          pollCubit.submitPollViewQuestion(pollCubit
                              .pollViewQuestions[pollCubit.question_number]);
                        },
                        background: AppColors.primary,
                        text: translateLang(
                            context,
                            pollCubit.question_number ==
                                    pollCubit.pollViewQuestions.length - 1
                                ? "submit"
                                : 'next'),
                      )
                    ],
                  ),
                  if (state is SubmitPollViewLoadingState)
                    const AnimatedLoadingWidget()
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
