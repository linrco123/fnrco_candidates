import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/logic/cubit/home_page/home_page_cubit.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/app_images_path.dart';
import 'package:fnrco_candidates/core/classes/cache_helper.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/ui/screens/category_details.dart';
import 'package:fnrco_candidates/ui/screens/job_details.dart';
import 'package:fnrco_candidates/ui/widgets/home_page/home_page_title.dart';
import 'package:fnrco_candidates/ui/widgets/home_page/job_home_card.dart';
import 'package:fnrco_candidates/ui/widgets/home_page/search_form_field.dart';
import 'package:fnrco_candidates/ui/widgets/home_page/single_home_card.dart';

class HomeTapScreen extends StatelessWidget {
  const HomeTapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageCubit, HomePageState>(
      builder: (context, state) {
        HomePageCubit homePageCubit = HomePageCubit.instance(context);
        return Container(
          //color: AppColors.blurGreen,
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
                              homePageCubit.greetings(context),
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(color: AppColors.white),
                            ),
                            Text(
                              CacheHelper.getName()??'Guest',
                              //'Muhammed Nady',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                        CircleAvatar(
                          radius: 27.0,
                          backgroundColor: AppColors.white,
                          child: CircleAvatar(
                              radius: 25.0,
                              backgroundImage: CacheHelper.getImage() == null
                                  ? AssetImage(AppImages.User)
                                  : FileImage(File(CacheHelper.getImage()!))),
                        )
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 70.0, left: 30.0, right: 30.0),
                      child: SearchFormField(
                          controller: homePageCubit.searchController,
                          label: 'search a job here',
                          fillColor: AppColors.white,
                          preIcon: Icons.search,
                          preFun: homePageCubit.searchAJob ,
                          sufIcon: Icons.close,
                          borderColor: AppColors.white,
                          suFun: (){},
                      )),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Expanded(
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
                              number: 29,
                              text: translateLang(context, "jobs_applied"),
                              color: AppColors.primary,
                            )),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                                child: SingleHomeCard(
                              icon: CupertinoIcons.question,
                              number: 3,
                              text: translateLang(context, "interviews"),
                              color: AppColors.secondary,
                            )),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        CustomHomeTitle(
                            title: translateLang(context, "categories"),
                            color: AppColors.primary),
                        Wrap(
                          direction: Axis.horizontal,
                          spacing: 20.0,
                          runSpacing: 10.0,
                          children: [
                            ...List.generate(
                                listIcons.length,
                                (index) => InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const CategoryDetailsScreen()));
                                      },
                                      child: Container(
                                        width: 50.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          border: Border.all(
                                              color: AppColors.primary,
                                              width: 1.0),
                                        ),
                                        child: Icon(listIcons[index]),
                                      ),
                                    )),
                          ],
                        ),
                        CustomHomeTitle(
                            title: translateLang(context, 'recommended_jobs'),
                            color: AppColors.primary),
                        SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 5.0),
                              scrollDirection: Axis.horizontal,
                              itemCount: 7,
                              itemBuilder: (BuildContext context, int index) =>
                                  JobHomeCard(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const JobDetailsScreen()));
                                      },
                                      image: AppImages.JOB_OFFER,
                                      job: 'software engineer',
                                      company: 'Jakarata, Indonisa',
                                      salary: '500 - \$2000')
                              //     GestureDetector(
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
                              ),
                        ),
                        Row(children: [
                          CustomHomeTitle(
                              title: translateLang(context, 'recent_jobs'),
                              color: AppColors.primary),
                          const Spacer(),
                          TextButton(
                              onPressed: () {
                                //TODO: GO to All Jobs screen
                              },
                              child: Text(
                                translateLang(context, 'more'),
                                style: Theme.of(context).textTheme.labelSmall,
                              ))
                        ]),
                        ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 5.0),
                            scrollDirection: Axis.vertical,
                            itemCount: 50,
                            itemBuilder: (BuildContext context, int index) =>
                                JobHomeCard(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const JobDetailsScreen()));
                                    },
                                    image: AppImages.JOB_OFFER,
                                    job: 'UI/UX designer',
                                    company: 'Jakarata, Indonisa',
                                    salary: '500 - \$2000')),
                      ]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

List<IconData> listIcons = <IconData>[
  CupertinoIcons.bolt,
  CupertinoIcons.pen,
  CupertinoIcons.archivebox,
  CupertinoIcons.arrow_branch,
  CupertinoIcons.dot_square,
  CupertinoIcons.wrench,
  CupertinoIcons.ticket,
  CupertinoIcons.table
];
