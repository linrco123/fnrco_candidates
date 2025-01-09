// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/management_content/announcement.dart';
import 'package:fnrco_candidates/logic/cubit/management_content/announcement/announcement_cubit.dart';
import 'package:fnrco_candidates/ui/widgets/empty_data_widget.dart';
import 'package:fnrco_candidates/ui/widgets/error_widget.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/management_content/announcement_card.dart';

class AnnouncementScreen extends StatelessWidget {
  AnnouncementScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AnnouncementCubit(AnnouncementProvider())..getAnnouncements(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text(
            translateLang(context, 'annnouncements'),
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
          child: BlocBuilder<AnnouncementCubit, AnnouncementState>(
            builder: (context, state) {
              var cubit = BlocProvider.of<AnnouncementCubit>(context);
              if (state is AnnouncementLoadingState) {
                return AnimatedLoadingWidget(
                  height: 150,
                  width: 150,
                );
              }
              if (state is AnnouncementFailureState) {
                return FailureWidget(
                    showImage: true,
                    title:
                        'Some Error occured when getting announcements!!!\n try again',
                    onTap: () {
                      cubit.getAnnouncements();
                    });
              }
              return (state as AnnouncementSuccessState).announcements.isEmpty
                  ? EmptyDataWidget(
                      message: "No Announcements available Yet!!!",
                    )
                  : ListView.separated(
                      itemCount: state.announcements.length,
                      itemBuilder: (BuildContext context, int index) => InkWell(
                          onTap: () {},
                          child: AnnouncementCard(
                              annnouncement: state.announcements[index])),
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
