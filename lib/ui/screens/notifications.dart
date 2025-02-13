import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/app_pages_names.dart';
import '../../core/functions/translate.dart';
import '../../logic/cubit/notifications/notifications_cubit.dart';
import '../widgets/empty_data_widget.dart';
import '../widgets/notification_card.dart';
import '../../constants/app_colors.dart';
import '../widgets/return_btn.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: Text(
            translateLang(context, "notifications"),
            style: TextStyle(color: AppColors.white),
          ),
          leading: ReturnButton(
            color: AppColors.white,
          ),
          centerTitle: true,
        ),
        body: Stack(children: [
          Stack(
            children: [
              Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),
            ],
          ),
          BlocConsumer<NotificationsCubit, NotificationsState>(
            listener: (context, state) {
              if (state is JobOfferTransitionState) {
                Navigator.of(context)
                    .pushReplacementNamed(AppPagesNames.JOB_OFFER);
              }

              if (state is JobContractTransitionState) {
                Navigator.of(context)
                    .pushReplacementNamed(AppPagesNames.JOB_CONTRACT);
              }

              if (state is VisaApprovalTransitionState) {
                Navigator.of(context)
                    .pushReplacementNamed(AppPagesNames.VISA_APPROVAL);
              }

              if (state is JoiningDateTransitionState) {
                Navigator.of(context)
                    .pushReplacementNamed(AppPagesNames.JOINING_DATE);
              }
            },
            builder: (context, state) {
              var notificationsCubit =
                  BlocProvider.of<NotificationsCubit>(context);
              if (notificationsCubit.notifications.isEmpty) {
                return EmptyDataWidget(
                  message: translateLang(context, "no_notifications"),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(top: 50),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: notificationsCubit.notifications.length,
                  itemBuilder: (context, i) {
                    final nModel = notificationsCubit.notifications[i];
                    return NotificationCard(
                      title: nModel.title,
                      body: nModel.body,
                      onTap: () {
                        notificationsCubit
                            .moveToClickedScreen(nModel.screenCode);
                      },
                    );
                  },
                ),
              );
            },
          ),
        ]));
  }
}
