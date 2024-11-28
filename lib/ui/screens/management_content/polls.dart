// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/management_contect/polls.dart';
import 'package:fnrco_candidates/logic/cubit/polls/polls_cubit.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/return_btn.dart';

class PollsScreen extends StatelessWidget {
  final PollsProvider surviesProvider = PollsProvider();
  final PollsCubit pollsCubit = PollsCubit(PollsProvider());
  PollsScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => pollsCubit..getPolls(),
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              translateLang(context,'polls'),
              style: TextStyle(color: AppColors.primary),
            ),
            centerTitle: true,
            leading: ReturnButton()),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(15.0),
          child: BlocBuilder<PollsCubit, PollsState>(
            builder: (context, state) {
              var Pollscubit = BlocProvider.of<PollsCubit>(context);
              if (state is PollsLoadingState) {
                return Center(
                  child: LoadingWidget(),
                );
              }
              if (state is PollsFailureState) {
                return Center(
                  child: Text(
                    'Some Error occurs !!!',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                );
              }

              return ListView.separated(
                itemCount: pollsCubit.polls.length,
                itemBuilder: (BuildContext context, int index) => InkWell(
                  onTap: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (Context) => BlocProvider.value(
                    //           value: pollsCubit
                    //             ..getPollView(pollsCubit.polls[index].id!),
                    //           child: PollsViewScreen(),
                    //         )));
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                        boxShadow: [
                          //   BoxShadow(
                          //   color: AppColors.primary.withOpacity(0.1),
                          //   blurRadius: 5.0,
                          //   spreadRadius: 5.0,
                          // blurStyle: BlurStyle.outer,
                          //   offset: Offset(0, 1)
                          // )
                        ],
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10.0),
                        border: BorderDirectional(
                            top: BorderSide(
                                color: AppColors.primary, width: 5.0),
                            bottom: BorderSide(
                                color: AppColors.primary, width: 5.0))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                         translateLang(context,'polls')+' '+(index+1).toString(),
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: AppColors.primary),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                pollsCubit.polls[index].pollText!,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Text(
                              'Poll By: ',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            Text(
                              pollsCubit.polls[index].pollBy!,
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
                             pollsCubit.polls[index].pollFrom!,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Text(
                                'to',
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ),
                            Text(
                             pollsCubit.polls[index].pollTo!,
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
                              pollsCubit.polls[index].pollStatus!,
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
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 10.0,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
