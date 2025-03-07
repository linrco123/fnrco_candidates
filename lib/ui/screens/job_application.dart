import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/functions/show_toast.dart';
import '../../data/api_provider/job_application.dart';
import '../../logic/cubit/job_application/job_application_cubit.dart';
import '../../constants/app_colors.dart';
import '../../core/classes/dotted_border.dart';
import '../../core/functions/translate.dart';
import 'company_info.dart';
import '../widgets/auth/custom_elevated_btn.dart';
import '../widgets/auth/name_email_phone_form_field.dart';
import '../widgets/job_details/back_btn.dart';
import '../widgets/job_details/custom_job_header.dart';
import '../widgets/loading_widget.dart';
import 'package:toastification/toastification.dart';

class JobApplicationScreen extends StatelessWidget {
  final int jobID;
  const JobApplicationScreen({super.key, required this.jobID});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return BlocProvider(
      create: (context) => JobApplicationCubit(JobApplicationProvider()),
      child: Scaffold(
        body: BlocConsumer<JobApplicationCubit, JobApplicationState>(
          listener: (context, state) {
            if (state is JobApplicationSuccessState) {
              showToast(context,
                  title: translateLang(context, 'success'),
                  desc: 'Job applied successfully',
                  type: ToastificationType.success);

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const CompanyInfoScreen()));
            }
            if (state is JobApplicationFailureState) {
              showToast(context,
                  title: translateLang(context, 'error'),
                  desc: state.error.toString(),
                  type: ToastificationType.success);
            }
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
                      color: AppColors.screenColor,
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
                            painter: DottedBorderPainter(
                                ),
                            child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    enableFeedback: true,
                                    maximumSize: const Size(double.infinity, 48),
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
                                    Expanded(
                                      child: Text(
                                        jobApplicationCubit.fileName.isEmpty
                                            ? translateLang(
                                                context, "upload_resume")
                                            : jobApplicationCubit.fileName,
                                        style: TextStyle(
                                            color: AppColors.grey,
                                            fontSize: 14.0),
                                      ),
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
                                              size: 25.0,
                                            ))
                                  ],
                                )),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          NameEmailPhoneFormField(
                              controller: jobApplicationCubit.nameController,
                              inputType: TextInputType.name,
                              prefixIcon: CupertinoIcons.person,
                              hint: translateLang(context, "full_name"),
                              validate: jobApplicationCubit.validateFullName),
                          const SizedBox(
                            height: 16.0,
                          ),
                          NameEmailPhoneFormField(
                              controller: jobApplicationCubit.emailController,
                              inputType: TextInputType.emailAddress,
                              prefixIcon: CupertinoIcons.mail,
                              hint: translateLang(context, "email"),
                              validate: jobApplicationCubit.validateEmail),
                          const SizedBox(
                            height: 16.0,
                          ),
                          NameEmailPhoneFormField(
                              controller: jobApplicationCubit.phoneController,
                              inputType: TextInputType.phone,
                              prefixIcon: CupertinoIcons.phone,
                              hint: translateLang(context, "phone_number"),
                              validate: jobApplicationCubit.validatePhone),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 4.5,
                          ),
                          // const Spacer(),
                          state is JobApplicationLoadingState
                              ? const AnimatedLoadingWidget()
                              : CustomElevatedButton(
                                  fun: () {
                                    context
                                        .read<JobApplicationCubit>()
                                        .applyJob(jobID);
                                  },
                                  background: AppColors.primary,
                                  textSize: 20.0,
                                  text: translateLang(context, "apply_job")
                                      .toUpperCase(),
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
