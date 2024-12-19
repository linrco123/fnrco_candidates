import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/app_pages_names.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/home/home_tap_provider.dart';
import 'package:fnrco_candidates/logic/cubit/unregistered/unregistered_cubit.dart';
import 'package:fnrco_candidates/ui/screens/search_jobs.dart';
import 'package:fnrco_candidates/ui/widgets/logo.dart';
import 'package:fnrco_candidates/ui/widgets/sloped_container.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/ui/widgets/home_page/search_form_field.dart';

class UnregisteredScreen extends StatelessWidget {
  const UnregisteredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UnregisteredCubit(HomePageProvider())..getJobs(),
      child: Scaffold(
        body: SafeArea(
            child: BlocConsumer<UnregisteredCubit, UnregisteredState>(
          listener: (context, state) {
            if (state is SearchJobsSuccessState) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SearchJobsScreen(jobs: state.jobs),
              ));
            }
          },
          builder: (context, state) {
            var cubit = context.read<UnregisteredCubit>();
            return Stack(
              children: [
                WavyContainer(
                    widget: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20.0),
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Container(
                      //   color: AppColors.white,
                      //   child: Image.asset(AppImages.LOGO,height: 100,width: 100,)),

                      Center(
                        child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(16.0)),
                            child: const LOGO()),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        translateLang(context, "find_jobs"),
                        style: TextStyle(
                            fontSize: 40.0,
                            color: AppColors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 0.0,
                      ),
                      Text(
                        translateLang(context, "any_time_where"),
                        style: TextStyle(
                            fontSize: 25.0,
                            color: AppColors.white,
                            fontWeight: FontWeight.w300),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      SearchFormField(
                          controller: cubit.searchController,
                          label: translateLang(context, "search_by_t_s_c"),
                          fillColor: AppColors.white,
                          preIcon: Icons.search,
                          vPadding: 20.0,
                          preFun: (value) {},
                          sufIcon: Icons.close,
                          borderColor: AppColors.white,
                          suFun: () {}),
                      const SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: CustomElevatedButton(
                            fun: cubit.searchAJob,
                            background: AppColors.white,
                            text: translateLang(context, "find_jobs"),
                            foreground: AppColors.primary,
                          ))
                    ],
                  ),
                )),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.6,
                      left: 70.0,
                      right: 70.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        translateLang(context, "msg_create_professional_cv"),
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      //const SizedBox(height: 20.0,),
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: CustomElevatedButton(
                              fun: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    AppPagesNames.SIGNUP, (predicate) => false);
                              },
                              background: AppColors.primary,
                              text:
                                  translateLang(context, "create_an_account"))),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              AppPagesNames.LOGIN, (p) => false);
                        },
                        child: Text.rich(
                            TextSpan(
                              text: translateLang(
                                  context, "already_have_an_account"),
                              style: Theme.of(context).textTheme.headlineMedium,
                              children: [
                                TextSpan(text: ' '),
                                TextSpan(
                                  text: translateLang(context, "sign_in"),
                                  style: TextStyle(color: AppColors.primary),
                                ),
                              ],
                            ),
                            style: Theme.of(context).textTheme.headlineSmall),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        )),
      ),
    );
  }
}
