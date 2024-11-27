import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/app_images_path.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/ui/widgets/company_info/company_info_header.dart';
import 'package:fnrco_candidates/ui/widgets/job_details/custom_app_bar.dart';
import 'package:fnrco_candidates/ui/widgets/job_details/custom_item_feature.dart';

class CompanyInfoScreen extends StatelessWidget {
  const CompanyInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      extendBody: true,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(270.0),
          child: Container(
            color: AppColors.blurRed,
            child: Stack(
              children: [
                Container(
                  height: 250.0,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            AppImages.COMPANY,
                          ),
                          fit: BoxFit.cover)),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomAppBar(
                      title: 'Company Details',
                      arrowColor: AppColors.white,
                      btnColor: AppColors.white.withOpacity(0.3),
                      icon: CupertinoIcons.ellipsis_vertical,
                      titleColor: AppColors.white,
                      startPadding: 60.0,
                      onTap: () {},
                    ),
                    // Row(
                    //   children: [
                    //     const Spacer(),
                    //     IconButton(
                    //         onPressed: () {
                    //           Navigator.of(context).pop();
                    //         },
                    //         icon: Container(
                    //           decoration: BoxDecoration(
                    //               color: AppColors.white.withOpacity(0.3),
                    //               shape: BoxShape.circle),
                    //           padding: const EdgeInsets.all(10.0),
                    //           child: Icon(Icons.keyboard_backspace_rounded,
                    //               color: AppColors.white),
                    //         )),
                    //     const SizedBox(width: 10.0),
                    //     Text(
                    //       'Company Details',
                    //       style: TextStyle(
                    //         color: AppColors.white,
                    //         fontSize: 20.0,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //     const SizedBox(
                    //       width: 30.0,
                    //     ),
                    //     IconButton(
                    //       onPressed: () {},
                    //       icon: Icon(
                    //         CupertinoIcons.ellipsis_vertical,
                    //         color: AppColors.white,
                    //         size: 30.0,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
                const Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/company-logo1.jpg'),
                          radius: 50.0,
                        )))
              ],
            ),
          )),
      body: Container(
        color: AppColors.blurRed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 15.0),
                    child: CompanyInfoHeader(
                        company: 'HighSpeed Studios',
                        location: 'United Kingdom , London',
                        rateIcon: Icons.star,
                        ratevalue: 4.5)),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    child: CustomItemFeature(
                        child: Icon(
                          CupertinoIcons.phone_fill,
                          color: AppColors.primary,
                          size: 30.0,
                        ),
                        color: AppColors.white,
                        border: true,
                        title: translateLang(context, 'telephone'),
                        subTitle: '+51 546 768 652')
                    //  Row(
                    //   children: [
                    //     Container(
                    //       padding: const EdgeInsets.all(15.0),
                    //       decoration: BoxDecoration(
                    //         color: AppColors.white,
                    //         shape: BoxShape.circle,
                    //         border:
                    //             Border.all(color: AppColors.primary, width: 1.0),
                    //       ),
                    //       child: Icon(
                    //         CupertinoIcons.phone_fill,
                    //         color: AppColors.primary,
                    //         size: 30.0,
                    //       ),
                    //     ),
                    //     const SizedBox(
                    //       width: 15.0,
                    //     ),
                    //     Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Text(
                    //           'Telephone',
                    //           style: TextStyle(
                    //               color: AppColors.grey, fontSize: 15.0),
                    //         ),
                    //         const SizedBox(
                    //           height: 5.0,
                    //         ),
                    //         Text(
                    //           '+51 546 768 652',
                    //           style: TextStyle(
                    //             fontSize: 18.0,
                    //             color: AppColors.black,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ],
                    // ),
                    ),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    child: CustomItemFeature(
                        child: Icon(
                          CupertinoIcons.mail_solid,
                          color: AppColors.primary,
                          size: 30.0,
                        ),
                        color: AppColors.white,
                        border: true,
                        title: translateLang(context, 'email'),
                        subTitle: 'eclisespeedst56@mail.com')),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    child: CustomItemFeature(
                        child: Icon(
                          CupertinoIcons.location_fill,
                          color: AppColors.primary,
                          size: 30.0,
                        ),
                        color: AppColors.white,
                        border: true,
                        title: translateLang(context, 'website'),
                        subTitle: 'speedloading.studio')),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Text(
                      translateLang(context, "about_company"),
                      style: Theme.of(context).textTheme.bodyLarge
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        about_company,
                        style: Theme.of(context).textTheme.bodySmall
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 48),
                    shape: const StadiumBorder(),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '21 available jobs',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 17.0,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.white,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String about_company =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley";
