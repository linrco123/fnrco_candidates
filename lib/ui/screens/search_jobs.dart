// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/app_images_path.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';

import 'package:fnrco_candidates/data/models/home/jobs_model.dart';
import 'package:fnrco_candidates/ui/widgets/empty_data_widget.dart';
import 'package:fnrco_candidates/ui/widgets/home_page/job_home_card.dart';
import 'package:fnrco_candidates/ui/widgets/return_btn.dart';

class SearchJobsScreen extends StatelessWidget {
  final List<Job> jobs;
  const SearchJobsScreen({
    Key? key,
    required this.jobs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          translateLang(context, 'jobs'),
          style:
              TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
        ),
        leading: ReturnButton(
          color: AppColors.primary,
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
        child: jobs.isEmpty
            ? const EmptyDataWidget(
                message: "No available Data Yet !!!",
              )
            : ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 5.0),
                scrollDirection: Axis.vertical,
                itemCount: jobs.length,
                itemBuilder: (BuildContext context, int index) {
                  return JobHomeCard(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) =>
                        //         JobDetailsScreen(job: jobs[index])));
                      },
                      image: AppImages.JOB_OFFER,
                      job: jobs[index].position!,
                      company: jobs[index].erpMprItemWorkLocation!,
                      salary: jobs[index].erpMprItemSalary!);
                }),
      ),
    );
  }
}
