// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/app_images_path.dart';
import 'package:fnrco_candidates/core/functions/show_toast.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/job_application.dart';
import 'package:fnrco_candidates/data/models/home/jobs_model.dart';
import 'package:fnrco_candidates/logic/cubit/job_application/job_application_cubit.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/ui/widgets/custom_divider.dart';
import 'package:fnrco_candidates/ui/widgets/job_details/custom_item_feature.dart';
import 'package:fnrco_candidates/ui/widgets/job_details/custom_job_header.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/profile_get/profile_item.dart';
import 'package:fnrco_candidates/ui/widgets/return_btn.dart';
import 'package:toastification/toastification.dart';

class JobDetailsScreen extends StatelessWidget {
  final Job job;
  const JobDetailsScreen({
    Key? key,
    required this.job,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return BlocProvider(
      create: (context) => JobApplicationCubit(JobApplicationProvider()),
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.white,
            centerTitle: true,
            title: Text(
              translateLang(context, 'job_details'),
              style: TextStyle(
                color: AppColors.primary,
              ),
            ),
            elevation: 0.0,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            leading: ReturnButton(
              color: AppColors.primary,
            )),
        body: Container(
          color: AppColors.white,
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: BlocConsumer<JobApplicationCubit, JobApplicationState>(
              listener: (context, state) {
                if (state is JobApplicationSuccessState) {
                  showToast(context,
                      title: translateLang(context, 'success'),
                      desc: translateLang(context, "job_submit_succ"),
                      type: ToastificationType.success);

                  Navigator.of(context).pop();
                }
                if (state is JobApplicationFailureState) {
                  showToast(context,
                      title: translateLang(context, 'error'),
                      desc: state.error.toString(),
                      type: ToastificationType.success);
                }
              },
              builder: (context, state) {
                var cubit = BlocProvider.of<JobApplicationCubit>(context);
                return Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          // CustomAppBar(
                          //   btnColor: AppColors.grey.withOpacity(0.3),
                          //   arrowColor: AppColors.greyDeep,
                          //   icon: CupertinoIcons.bookmark,
                          //   title: translateLang(context, 'job_details'),
                          //   titleColor: AppColors.black,
                          //   onTap: () {},
                          //   startPadding: 0.0,
                          // ),
                          // CustomDivider(),
                          Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CustomJobHeader(
                                  company: job.erpMprItemWorkLocation!,
                                  companyColor: AppColors.primary,
                                  job: job.position!,
                                  jobColor: AppColors.black,
                                  image: 'assets/images/job-offer.png'),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const CustomDivider(
                            hPadding: 20.0,
                            vPadding: 10.0,
                          ),
                          Card(
                            color: AppColors.white,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: CustomItemFeature(
                                      child: Image.asset(
                                        AppImages.SALARY,
                                        height: 30.0,
                                        width: 30.0,
                                        color: AppColors.primary,
                                      ),
                                      color: AppColors.primary.withOpacity(0.1),
                                      border: false,
                                      title: translateLang(context, 'salary'),
                                      subTitle: job.erpMprItemSalary!),
                                ),
                                const SizedBox(height: 10.0),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: CustomItemFeature(
                                      child: Icon(
                                        Icons.location_on_outlined,
                                        size: 30.0,
                                        color:
                                            AppColors.primary.withOpacity(0.6),
                                      ),
                                      color: AppColors.primary.withOpacity(0.1),
                                      border: false,
                                      title: translateLang(context, 'location'),
                                      subTitle: job.erpMprItemWorkLocation!),
                                ),
                              ],
                            ),
                          ),
                          const CustomDivider(
                            hPadding: 20.0,
                            vPadding: 10.0,
                          ),
                          Row(
                            children: [
                              Text(translateLang(context, 'job_desc'),
                                  style: Theme.of(context).textTheme.bodyLarge),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    job.erpMprItemRemarks!,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Column(
                            children: [
                              ProfileItem(
                                  kkey: 'gender',
                                  value: job.erpMprItemPositionGender!),
                              ProfileItem(
                                  kkey: 'category',
                                  value: job.erpMprItemWorkforceCategory!),
                              ProfileItem(
                                  kkey: 'job_details',
                                  value: job.erpMprItemVacationDetails!),
                              ProfileItem(
                                  kkey: 'status', value: job.erpMprItemStatus!),
                            ],
                          ),
                          const SizedBox(
                            height: 50.0,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        // IconButton(
                        //   onPressed: () {},
                        //   icon: Container(
                        //     padding: const EdgeInsets.all(0.0),
                        //     decoration: BoxDecoration(
                        //         color: AppColors.primary.withOpacity(0.1),
                        //         shape: BoxShape.circle),
                        //     child: Icon(
                        //       CupertinoIcons.bookmark,
                        //       color: AppColors.grey,
                        //       size: 40.0,
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   width: 5.0,
                        // ),
                        Expanded(
                            child: state is JobApplicationLoadingState
                                ? const AnimatedLoadingWidget()
                                : CustomElevatedButton(
                                    fun: () {
                                      cubit.applyJob(job.id!);
                                    },
                                    background: AppColors.primary,
                                    text: 'Apply Job'.toUpperCase(),
                                    textSize: 20.0,
                                  ))
                      ],
                    )
                  ],
                );
              },
            ),
          )),
        ),
      ),
    );
  }
}
