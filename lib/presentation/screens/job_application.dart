import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/business_logic/cubit/job_application/job_application_cubit.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/classes/dotted_border.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/presentation/screens/company_info.dart';
import 'package:fnrco_candidates/presentation/widgets/job_details/back_btn.dart';
import 'package:fnrco_candidates/presentation/widgets/job_details/custom_job_header.dart';

class JobApplicationScreen extends StatelessWidget {
  const JobApplicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarColor: AppColors.primary));
    return BlocProvider(
      create: (context) => JobApplicationCubit(),
      child: Scaffold(
        body: BlocConsumer<JobApplicationCubit, JobApplicationState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            var jobApplicationCubit =
                BlocProvider.of<JobApplicationCubit>(context);
            return Stack(children: [
              Container(
                color: AppColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                height: MediaQuery.of(context).size.height / 3,
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomJobHeader(
                        company: 'Jakarata, Indonisa',
                        companyColor: AppColors.white,
                        job: 'software engineer',
                        jobColor: AppColors.white,
                        image: 'assets/images/job-offer.png'),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       flex: 2,
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text('Jakarata, Indonisa',
                    //               style: TextStyle(
                    //                 fontSize: 17.0,
                    //                 color: AppColors.white,
                    //               )),
                    //           Text(
                    //             'software engineer',
                    //             style: TextStyle(
                    //               fontSize: 22.0,
                    //               color: AppColors.white,
                    //               fontWeight: FontWeight.bold,
                    //             ),
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
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 3.5),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: const BorderRadiusDirectional.only(
                          topStart: Radius.circular(30.0),
                          topEnd: Radius.circular(30.0))),
                  child: Form(
                    key: jobApplicationCubit.formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 30.0,
                                ),
                                CustomBackBTN(
                                    btnColor: AppColors.grey.withOpacity(0.3),
                                    arrowColor: AppColors.grey),
                                const SizedBox(
                                  width: 30.0,
                                ),
                                Text(
                                    translateLang(context, "apply_form")
                                        .toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge),
                              ],
                            ),
                          ),
                          CustomPaint(
                            painter: DottedBorderPainter(),
                            child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    enableFeedback: true,
                                    maximumSize: Size(double.infinity, 48),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 15.0),
                                    iconColor: AppColors.primary,
                                    visualDensity: VisualDensity.comfortable,
                                    // textStyle:TextStyle(color: AppColors.grey, fontSize: 17.0) ,
                                    side: BorderSide.none),
                                onPressed: () {
                                  jobApplicationCubit.uploadResume();
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      jobApplicationCubit.fileName.isEmpty
                                          ? translateLang(
                                              context, "upload_resume")
                                          : jobApplicationCubit.fileName,
                                      style: TextStyle(
                                          color: AppColors.grey, fontSize: 14.0),
                                    ),
                                    const Spacer(),
                                    jobApplicationCubit.fileName.isEmpty
                                        ? Icon(
                                            Icons.upload_file_rounded,
                                            color: AppColors.primary,
                                          )
                                        : InkWell(
                                            onTap: () {
                                              jobApplicationCubit.deleteCVPDF();
                                            },
                                            child: Icon(
                                              CupertinoIcons.delete_simple,
                                              color: AppColors.primary,
                                            ))
                                  ],
                                )),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            controller: jobApplicationCubit.nameController,
                            validator: (value) => jobApplicationCubit
                                .validateFullName(context, value!),
                            decoration: InputDecoration(
                              
                              prefixIcon: Icon(CupertinoIcons.person),
                              prefixIconColor: AppColors.grey,
                              hintText: translateLang(context, "full_name"),
                              hintStyle:
                                  Theme.of(context).textTheme.headlineMedium,
                              filled: true,
                              fillColor: AppColors.blurGreen,
                              contentPadding: const EdgeInsets.symmetric(
                                   horizontal: 20.0, vertical: 5.0),
                            
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                            ),
                            keyboardType: TextInputType.name,
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          TextFormField(
                            controller: jobApplicationCubit.emailController,
                            validator: (value) => jobApplicationCubit
                                .validateEmail(context, value!),
                            decoration: InputDecoration(
                              prefixIcon: Icon(CupertinoIcons.mail),
                              prefixIconColor: AppColors.grey,
                              hintText: translateLang(context, "email"),
                              hintStyle:
                                  Theme.of(context).textTheme.headlineMedium,
                              filled: true,
                              fillColor: AppColors.blurGreen,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 0.0 , vertical: 0.0),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                            ),
                            keyboardType: TextInputType.name,
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          TextFormField(
                            controller: jobApplicationCubit.phoneController,
                            validator: (value) => jobApplicationCubit
                                .validatePhone(context, value!),
                            decoration: InputDecoration(
                              prefixIcon: Icon(CupertinoIcons.phone),
                              prefixIconColor: AppColors.grey,
                              hintText: translateLang(context, "phone_number"),
                              hintStyle:
                                  Theme.of(context).textTheme.headlineMedium,
                              filled: true,
                              fillColor: AppColors.blurGreen,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 15.0 , vertical: 5.0),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                            ),
                            keyboardType: TextInputType.phone,
                            // onSaved: (phone) {
                            //   // Save it
                            // },
                          ),
                            SizedBox(height: MediaQuery.of(context).size.height/4.5,),
                          // const Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const CompanyInfoScreen()));
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 48),
                              shape: const StadiumBorder(),
                            ),
                            child: Text(
                              'Apply Job'.toUpperCase(),
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ]);
          },
        ),
      ),
    );
  }
}
