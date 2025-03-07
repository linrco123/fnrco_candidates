import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/app_colors.dart';
import '../../../core/functions/translate.dart';
import '../../../data/api_provider/joining_date.dart';
import '../../../data/models/joining_date_model.dart';
import '../../../logic/cubit/joining_date/joining_date_cubit.dart';
import 'joining_date.dart';
import '../../widgets/empty_data_widget.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/profile_get/profile_item.dart';
import '../../widgets/return_btn.dart';
import 'package:page_transition/page_transition.dart';

class DateApplicationScreen extends StatelessWidget {
  const DateApplicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    JoiningDateProvider _joiningDateProvider = JoiningDateProvider();
    JoiningDateCubit joiningDateCubit = JoiningDateCubit(_joiningDateProvider);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return BlocProvider(
      create: (context) => joiningDateCubit..getJoiningDateInfo(),
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
        body: BlocConsumer<JoiningDateCubit, JoiningDateState>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = BlocProvider.of<JoiningDateCubit>(context);
            if (state is GetJoiningDateLoadingState) {
              return const AnimatedLoadingWidget(
                height: 150.0,
                width: 150.0,
              );
            }
            if (state is GetJoiningDateFailureState) {
              return FailureWidget(
                  showImage: true,
                  title: state.message,
                  onTap: () {
                    context.read<JoiningDateCubit>().getJoiningDateInfo();
                  });
            }

            return cubit.joiningDateApplication.isEmpty
                ? const EmptyDataWidget(
                    message: "No job applications available Yet !!!",
                  )
                : Padding(
                    padding: const EdgeInsets.only(
                        right: 15.0, left: 15.0, top: 25.0),
                    child: ListView.separated(
                        itemCount: cubit.joiningDateApplication.length,
                        itemBuilder: (BuildContext context, int index) =>
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(PageTransition(
                                    child: BlocProvider.value(
                                      value: joiningDateCubit,
                                      child: JoiningDateSCreen(
                                          joiningDateApp: cubit
                                              .joiningDateApplication[index]),
                                    ),
                                    type: PageTransitionType.fade,
                                    alignment: Alignment.centerLeft,
                                    duration: const Duration(seconds: 1)));
                              },
                              child: DateApplicationCard(
                                  application:
                                      cubit.joiningDateApplication[index]),
                            ),
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                              height: 20.0,
                            )),
                  );
          },
        ),
      ),
    );
  }
}

class DateApplicationCard extends StatelessWidget {
  final JoiningDateApplication application;
  const DateApplicationCard({
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
              offset: const Offset(0, 1))
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
