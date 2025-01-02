import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/app_pages_names.dart';
import '../../../data/models/home/jobs_model.dart';
import '../../../logic/cubit/home_page/home_page_cubit.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_images_path.dart';
import '../../../core/classes/cache_helper.dart';
import '../../../core/functions/translate.dart';
import '../job_details.dart';
import '../../widgets/home_page/home_loading_widgets.dart';
import '../../widgets/home_page/job_home_card.dart';
import '../../widgets/home_page/search_form_field.dart';
import '../../widgets/home_page/single_home_card.dart';

class HomeTapScreen extends StatelessWidget {
  const HomeTapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: AppColors.blurRed,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 100.0,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: const BorderRadiusDirectional.only(
                      bottomStart: Radius.circular(20.0),
                      bottomEnd: Radius.circular(20.0)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.read<HomePageCubit>().greetings(context),
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(color: AppColors.white),
                        ),
                        Text(
                          CacheHelper.getName() ?? 'Guest',
                          //'Muhammed Nady',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(AppPagesNames.PROFILE);
                      },
                      child: CircleAvatar(
                        radius: 27.0,
                        backgroundColor: AppColors.white,
                        child: CircleAvatar(
                            radius: 25.0,
                            backgroundImage: CacheHelper.getImage() == null
                                ? AssetImage(AppImages.User)
                                : FileImage(File(CacheHelper.getImage()!))),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.only(top: 70.0, left: 30.0, right: 30.0),
                  child: SearchFormField(
                    controller: context.read<HomePageCubit>().searchController,
                    label: translateLang(context, 'search_job_here'),
                    fillColor: AppColors.white,
                    preIcon: Icons.search,
                    preFun: context.read<HomePageCubit>().searchAJob,
                    sufIcon: Icons.close,
                    borderColor: AppColors.white,
                    suFun: () {},
                  )),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          BlocBuilder<HomePageCubit, HomePageState>(
            builder: (context, state) {
              var homePageCubit = BlocProvider.of<HomePageCubit>(context);
              if (state is GetJobsLoadingState) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(child: LoadingSingleHomeCard()),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Expanded(child: LoadingSingleHomeCard())
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Expanded(
                            child: ListView.separated(
                          itemCount: 10,
                          itemBuilder: (context, index) => LoadingJobCardHome(),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 10.0,
                          ),
                        ))
                      ],
                    ),
                  ),
                );
              }
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ListView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                                child: SingleHomeCard(
                              icon: CupertinoIcons.checkmark_circle,
                              number: homePageCubit.appliedJobs.length,
                              text: translateLang(context, "jobs_applied"),
                              color: AppColors.primary,
                            )),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                                child: SingleHomeCard(
                              icon: CupertinoIcons.question,
                              number: 0,
                              text: translateLang(context, "interviews"),
                              color: Colors.grey.shade700,
                            )),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        // CustomHomeTitle(
                        //     title: translateLang(context, "categories"),
                        //     color: AppColors.primary),
                        // Wrap(
                        //   direction: Axis.horizontal,
                        //   spacing: 20.0,
                        //   runSpacing: 10.0,
                        //   children: [
                        //     ...List.generate(
                        //         listIcons.length,
                        //         (index) => InkWell(
                        //               onTap: () {
                        //                 // Navigator.of(context).push(
                        //                 //     MaterialPageRoute(
                        //                 //         builder: (context) =>
                        //                 //             const CategoryDetailsScreen()));
                        //               },
                        //               child: Container(
                        //                 width: 50.0,
                        //                 height: 50.0,
                        //                 decoration: BoxDecoration(
                        //                   color: AppColors.white,
                        //                   borderRadius:
                        //                       BorderRadius.circular(10.0),
                        //                   border: Border.all(
                        //                       color: AppColors.primary,
                        //                       width: 1.0),
                        //                 ),
                        //                 child: Icon(listIcons[index]),
                        //               ),
                        //             )),
                        //   ],
                        // ),
                        // CustomHomeTitle(
                        //     title: translateLang(context, 'recommended_jobs'),
                        //     color: AppColors.primary),
                        // SizedBox(
                        //   height: 100,
                        //   width: double.infinity,
                        //   child: ListView.separated(
                        //       separatorBuilder: (context, index) =>
                        //           const SizedBox(width: 5.0),
                        //       scrollDirection: Axis.horizontal,
                        //       itemCount: homePageCubit.jobs.length,
                        //       itemBuilder: (BuildContext context, int index) =>
                        //           JobHomeCard(
                        //               onTap: () {
                        //                 // Navigator.of(context).pushNamed(
                        //                 //     AppPagesNames.JOB_DETAILS,
                        //                 //     arguments: {
                        //                 //       'job': homePageCubit.jobs[index]
                        //                 //     });
                        //                 Navigator.of(context).push(
                        //                     MaterialPageRoute(
                        //                         builder: (context) =>
                        //                             JobDetailsScreen(
                        //                               job: homePageCubit
                        //                                   .jobs[index],
                        //                             )));
                        //               },
                        //               image: AppImages.JOB_OFFER,
                        //               job: homePageCubit.jobs[index].position!,
                        //               company: homePageCubit
                        //                   .jobs[index].erpMprItemWorkLocation!,
                        //               salary: homePageCubit
                        //                   .jobs[index].erpMprItemSalary!)
                        //       //     GestureDetector(
                        //   onTap: () {
                        //     Navigator.of(context).push(MaterialPageRoute(
                        //         builder: (context) =>
                        //             const JobDetailsScreen()));
                        //   },
                        //   child: Container(
                        //     height: 95.0,
                        //     //width: 100.0,
                        //     padding: const EdgeInsets.all(10.0),
                        //     decoration: BoxDecoration(
                        //       color: AppColors.white,
                        //       borderRadius: BorderRadius.circular(20.0),
                        //     ),
                        //     child: Row(
                        //       children: [
                        //         Image.asset(
                        //           'assets/images/job-offer.png',
                        //           height: 60.0,
                        //           width: 60.0,
                        //         ),
                        //         const SizedBox(width: 10.0),
                        //         Column(
                        //           crossAxisAlignment:
                        //               CrossAxisAlignment.start,
                        //           children: [
                        //             Text(
                        //               'software engineer',
                        //               style: TextStyle(
                        //                 fontSize: 14.0,
                        //                 color: AppColors.black,
                        //                 fontWeight: FontWeight.bold,
                        //               ),
                        //             ),
                        //             Text('Jakarata, Indonisa',
                        //                 style: TextStyle(fontSize: 14.0,
                        //                   color: AppColors.black,
                        //                 )),
                        //             const Spacer(),
                        //             Row(
                        //               children: [
                        //                 Image.asset(
                        //                   AppImages.SALARY,
                        //                   height: 30.0,
                        //                   width: 30.0,
                        //                   color: AppColors.primary,
                        //                 ),
                        //                 const SizedBox(
                        //                   width: 5.0,
                        //                 ),
                        //                 Text(
                        //                   '\$500 - \$2000',
                        //                   style: TextStyle(
                        //                     color: AppColors.primary,
                        //                     fontWeight: FontWeight.bold,
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           ],
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // ),
                        // ),
                        // Row(children: [
                        //   CustomHomeTitle(
                        //       title: translateLang(context, 'recent_jobs'),
                        //       color: AppColors.primary),
                        //   const Spacer(),
                        //   TextButton(
                        //       onPressed: () {
                        //         //TODO: GO to All Jobs screen
                        //       },
                        //       child: Text(
                        //         translateLang(context, 'more'),
                        //         style: Theme.of(context).textTheme.labelSmall,
                        //       ))
                        // ]),

                        ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 5.0),
                            scrollDirection: Axis.vertical,
                            itemCount: homePageCubit.searchedJobs.isEmpty
                                ? homePageCubit.jobs.length
                                : homePageCubit.searchedJobs.length,
                            itemBuilder: (BuildContext context, int index) {
                              List<Job> jobsList =
                                  homePageCubit.searchedJobs.isEmpty
                                      ? homePageCubit.jobs
                                      : homePageCubit.searchedJobs;
                              return JobHomeCard(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                JobDetailsScreen(
                                                    job: homePageCubit
                                                        .jobs[index])));
                                  },
                                  image: AppImages.JOB_OFFER,
                                  job: jobsList[index].position!,
                                  company:
                                      jobsList[index].erpMprItemWorkLocation!,
                                  salary: jobsList[index].erpMprItemSalary!);
                            }),
                      ]),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
