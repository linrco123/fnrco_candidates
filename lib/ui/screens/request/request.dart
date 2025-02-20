import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/api_provider/request.dart';
import '../../../data/models/request_model.dart';
import '../../../logic/cubit/request/request_cubit.dart';
import 'request_reply.dart';
import '../../widgets/empty_data_widget.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/profile_get/profile_item.dart';
import 'package:page_transition/page_transition.dart';
import '../../../constants/app_colors.dart';
import '../../../core/functions/translate.dart';
import '../../widgets/loading_widget.dart';

import '../../widgets/return_btn.dart';

class RequestScreen extends StatelessWidget {
  const RequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RequestProvider requestProvider = RequestProvider();
    final requestCubit = RequestCubit(requestProvider);
    return BlocProvider(
      create: (context) => requestCubit..getRequestData(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text(
            translateLang(context, 'requests'),
            style: TextStyle(
                color: AppColors.primary, fontWeight: FontWeight.bold),
          ),
          leading: ReturnButton(
            color: AppColors.primary,
          ),
          centerTitle: true,
        ),
        backgroundColor: AppColors.white,
        body: LayoutBuilder(builder: (context, constraints) {
          return BlocConsumer<RequestCubit, RequestState>(
            listener: (context, state) {},
            builder: (context, state) {
              final cubit = BlocProvider.of<RequestCubit>(context);
              if (state is GetRequestDataLoadingState) {
                return const AnimatedLoadingWidget(
                  height: 150.0,
                  width: 150.0,
                );
              }
              if (state is GetRequestDataFailureState) {
                return FailureWidget(
                    title: 'Some error ocurred !!!\n try again ',
                    showImage: true,
                    onTap: () {
                      context.read<RequestCubit>().getRequestData();
                    });
              }
            
                return cubit.requests.isEmpty
                    ? const EmptyDataWidget(
                        message: 'No requests available yet !!!',
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16.0),
                        color: AppColors.white,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10.0,
                            ),
                            Expanded(
                                child: ListView.separated(
                              itemCount: cubit.requests.length,
                              separatorBuilder: (context, index) => const SizedBox(
                                height: 20.0,
                              ),
                              itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            child: BlocProvider.value(
                                              value: requestCubit,
                                              child: RequestReplyScreen(
                                                  request:
                                                      cubit.requests[index]),
                                            ),
                                            type: PageTransitionType.fade,
                                            alignment: Alignment.centerLeft,
                                            duration:
                                                const Duration(seconds: 1)));
                                  },
                                  child: RequestTypeCard(
                                      request: cubit.requests[index])),
                            )),
                          ],
                        ),
                      );
          
              // return Center(
              //   child: Text(
              //     'Unknown Error !!!!!',
              //     style: Theme.of(context).textTheme.labelMedium,
              //   ),
              // );
            },
          );
        }),
      ),
    );
  }
}

class RequestTypeCard extends StatelessWidget {
  final RequestData request;
  const RequestTypeCard({
    Key? key,
    required this.request,
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
              kkey: "document_type", value: request.documentType.toString()),
          ProfileItem(
              kkey: "request_type", value: request.requestType.toString()),
          ProfileItem(kkey: "request_to", value: request.requestTo.toString()),
          ProfileItem(kkey: "title", value: request.title.toString()),
          ProfileItem(kkey: "remark", value: request.remarks.toString()),
        ],
      ),
    );
  }
}
