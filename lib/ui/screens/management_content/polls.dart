// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/management_content/polls.dart';
import 'package:fnrco_candidates/logic/cubit/management_content/polls/polls_cubit.dart';
import 'package:fnrco_candidates/ui/screens/management_content/poll_view.dart';
import 'package:fnrco_candidates/ui/widgets/empty_data_widget.dart';
import 'package:fnrco_candidates/ui/widgets/error_widget.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/management_content/poll_card.dart';
import 'package:fnrco_candidates/ui/widgets/return_btn.dart';

class PollsScreen extends StatelessWidget {
  final PollsProvider pollsProvider = PollsProvider();
  final PollsCubit pollsCubit = PollsCubit(PollsProvider());
  PollsScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => pollsCubit..getPolls(),
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.white,
            title: Text(
              translateLang(context, 'polls'),
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
              BlocProvider.of<PollsCubit>(context);
              if (state is PollsLoadingState) {
                return Center(
                  child: AnimatedLoadingWidget(
                    height: 150.0,
                    width: 150.0,
                  ),
                );
              }
              if (state is PollsFailureState) {
                return FailureWidget(
                    showImage: true,
                    title:
                        "Some Error ocurrs when getting Polls !!!\n try again",
                    onTap: () {
                      pollsCubit.getPolls();
                    });
              }

              return pollsCubit.polls.isEmpty
                  ? EmptyDataWidget(
                      message: "No polls available Yet !!!",
                    )
                  : ListView.separated(
                      itemCount: pollsCubit.polls.length,
                      itemBuilder: (BuildContext context, int index) => InkWell(
                          onTap: () {
                            // pollsCubit.pollViewID = pollsCubit.polls[index].id!;
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (Context) => BlocProvider.value(
                                      value: pollsCubit
                                        ..getPollView(
                                            pollsCubit.polls[index].id!),
                                      child: PollsViewScreen(),
                                    )));
                          },
                          child: PollCard(
                              poll: pollsCubit.polls[index], index: index)),
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
