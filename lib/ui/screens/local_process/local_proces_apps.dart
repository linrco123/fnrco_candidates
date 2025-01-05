import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/api_provider/local_process.dart';
import '../../../data/models/local_process_model.dart';
import '../../../logic/cubit/local_process/local_process_cubit.dart';
import 'local_process.dart';
import '../../widgets/profile_get/profile_item.dart';
import '../../../constants/app_colors.dart';
import '../../../core/functions/translate.dart';
import '../../widgets/empty_data_widget.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/return_btn.dart';

class LocalProcessApplicationsScreen extends StatelessWidget {
  const LocalProcessApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LocalProcessProvider _LocalProcessProvider = LocalProcessProvider();
    LocalProcessCubit localProcessCubit =
        LocalProcessCubit(_LocalProcessProvider);
    return BlocProvider(
      create: (context) => localProcessCubit..getLocalProcessData(),
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.white,
            centerTitle: true,
            title: Text(
              translateLang(context, 'applications'),
              style: TextStyle(
                color: AppColors.primary,
              ),
            ),
            elevation: 0.0,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            leading: ReturnButton(
              color: AppColors.primary,
            )),
        body: BlocConsumer<LocalProcessCubit, LocalProcessState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is GetLocalProcessDataLoadingState) {
              return AnimatedLoadingWidget(
                height: 150.0,
                width: 150.0,
              );
            }
            if (state is GetLocalProcessDataFailureState) {
              return FailureWidget(
                  title: state.message,
                  onTap: () {
                    context.read<LocalProcessCubit>().getLocalProcessData();
                  });
            }

            if (state is GetLocalProcessDataSuccessState) {
              return state.applications.isEmpty
                  ? EmptyDataWidget(
                      message: "No job applications available Yet !!!",
                    )
                  : Padding(
                      padding: const EdgeInsets.only(
                          right: 15.0, left: 15.0, top: 25.0),
                      child: ListView.separated(
                          itemCount: state.applications.length,
                          itemBuilder: (BuildContext context, int index) =>
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => BlocProvider.value(
                                      value: localProcessCubit,
                                      child: LocalProcessScreen(
                                        localProcessPipeline:
                                            state.applications[index].pipeline!,
                                      ),
                                    ),
                                  ));
                                  context
                                      .read<LocalProcessCubit>()
                                      .storeLocalProcessAttachments(
                                          state.applications[index].pipeline!);
                                  context
                                      .read<LocalProcessCubit>()
                                      .passAppID(state.applications[index].id!);
                                },
                                child: LocalProcessApplicationCard(
                                    application: state.applications[index]),
                              ),
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(
                                height: 20.0,
                              )),
                    );
            }
            return AnimatedLoadingWidget(height: 150.0, width: 150.0);
          },
        ),
      ),
    );
  }
}

class LocalProcessApplicationCard extends StatelessWidget {
  final LocalProcessApp application;
  const LocalProcessApplicationCard({
    Key? key,
    required this.application,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: AppColors.grey,
              blurRadius: 5.0,
              spreadRadius: 5.0,
              blurStyle: BlurStyle.outer,
              offset: Offset(0, 1))
        ],
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileItem(
              kkey: "candidate_name",
              value: application.candidateName.toString()),
          ProfileItem(
              kkey: "nationality",
              value: application.candidateNationality!.toString()),
          ProfileItem(kkey: "position", value: application.position.toString()),
          ProfileItem(
              kkey: "client_name", value: application.clientName.toString()),
        ],
      ),
    );
  }
}
