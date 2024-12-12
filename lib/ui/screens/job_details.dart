// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/app_images_path.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/models/home/jobs_model.dart';
import 'package:fnrco_candidates/ui/screens/job_application.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/ui/widgets/custom_divider.dart';
import 'package:fnrco_candidates/ui/widgets/job_details/custom_app_bar.dart';
import 'package:fnrco_candidates/ui/widgets/job_details/custom_item_feature.dart';
import 'package:fnrco_candidates/ui/widgets/job_details/custom_job_header.dart';
import 'package:fnrco_candidates/ui/widgets/profile_get/profile_item.dart';

class JobDetailsScreen extends StatelessWidget {
  final Job job;
  const JobDetailsScreen({
    Key? key,
    required this.job,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      body: Container(
        color: AppColors.blurRed,
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    CustomAppBar(
                      btnColor: AppColors.grey.withOpacity(0.3),
                      arrowColor: AppColors.greyDeep,
                      icon: CupertinoIcons.bookmark,
                      title: translateLang(context, 'job_details'),
                      titleColor: AppColors.black,
                      onTap: () {},
                      startPadding: 0.0,
                    ),
                    // Row(
                    //   children: [
                    //     IconButton(
                    //         onPressed: () {
                    //           Navigator.of(context).pop();
                    //         },
                    //         icon: Container(
                    //           decoration: BoxDecoration(
                    //               color: AppColors.grey.withOpacity(0.3),
                    //               shape: BoxShape.circle),
                    //           padding: const EdgeInsets.all(10.0),
                    //           child: Icon(Icons.keyboard_backspace_rounded,
                    //               color: AppColors.grey),
                    //         )),
                    //     const SizedBox(width: 10.0),
                    //     Text(
                    //       'Details',
                    //       style: TextStyle(
                    //         color: AppColors.black,
                    //         fontSize: 20.0,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //     const Spacer(),
                    //     IconButton(
                    //       onPressed: () {},
                    //       icon: Icon(
                    //         CupertinoIcons.line_horizontal_3_decrease_circle,
                    //         color: AppColors.grey,
                    //         size: 30.0,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    CustomDivider(),
                    CustomJobHeader(
                        company: job.erpMprItemWorkLocation!,
                        companyColor: AppColors.primary,
                        job: job.position!,
                        jobColor: AppColors.black,
                        image: 'assets/images/job-offer.png'),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       flex: 2,
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text('Jakarata, Indonisa',
                    //               style: Theme.of(context).textTheme.displayMedium),
                    //           Text(
                    //             'software engineer',
                    //             style: Theme.of(context).textTheme.headlineLarge,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     // const Spacer(),
                    //     Expanded(
                    //       flex: 1,
                    //       child: Image.asset(
                    //         'assets/images/job-offer.png',
                    //         height: 80.0,
                    //         width: 80.0,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // RichText(text:  TextSpan(text:'Vacation Details',style: TextStyle(color: AppColors.primary),children: [
                    //  TextSpan()
                    // ]),),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        Text(
                          'Vacation Details : ',
                          style: TextStyle(color: AppColors.primary),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: Text(
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              job.erpMprItemVacationDetails!,
                              style: Theme.of(context).textTheme.bodyMedium),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    // Wrap(
                    //   direction: Axis.horizontal,
                    //   alignment: WrapAlignment.start,
                    //   crossAxisAlignment: WrapCrossAlignment.start,
                    //   spacing: 10.0,
                    //   runSpacing: 10.0,
                    //   children: [
                    //     ...List.generate(
                    //       stringList.length,
                    //       (index) => Container(
                    //           //width: 50.0,
                    //           // alignment: Alignment.center,
                    //           height: 40.0,
                    //           padding: const EdgeInsets.all(10.0),
                    //           decoration: BoxDecoration(
                    //               color: AppColors.white,
                    //               borderRadius: BorderRadius.circular(40.0),
                    //               border:
                    //                   Border.all(color: AppColors.primary, width: 1)),
                    //           child: Text(
                    //             stringList[index],
                    //             style: TextStyle(color: AppColors.primary),
                    //           )),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    CustomDivider(
                      hPadding: 20.0,
                      vPadding: 10.0,
                    ),
                    CustomItemFeature(
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

                    const SizedBox(height: 10.0),
                    CustomItemFeature(
                        child: Icon(
                          Icons.location_on_outlined,
                          size: 30.0,
                          color: AppColors.primary.withOpacity(0.6),
                        ),
                        color: AppColors.primary.withOpacity(0.1),
                        border: false,
                        title: translateLang(context, 'location'),
                        subTitle: job.erpMprItemWorkLocation!),
                    CustomDivider(
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
                              style: Theme.of(context).textTheme.bodyMedium),
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

                        //   ...List.generate(
                        //       6,
                        //       (int index) => CustomCheckedJobFeature(
                        //           text:
                        //               "Lorem Ipsum is simply dummy text of the printing and typesetting industry."))
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
                  IconButton(
                    onPressed: () {},
                    icon: Container(
                      padding: const EdgeInsets.all(0.0),
                      decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          shape: BoxShape.circle),
                      child: Icon(
                        CupertinoIcons.bookmark,
                        color: AppColors.grey,
                        size: 40.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                      child: CustomElevatedButton(
                    fun: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              JobApplicationScreen(jobID: job.id!)));
                    },
                    background: AppColors.primary,
                    text: 'Apply Job'.toUpperCase(),
                    textSize: 20.0,
                  ))
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}

List<String> stringList = [
  'Fulltime',
  'Remote Working',
  'Hourly',
];

String job_description =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley";
