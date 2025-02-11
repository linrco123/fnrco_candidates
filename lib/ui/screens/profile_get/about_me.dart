import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/app_colors.dart';
import '../../../data/api_provider/profile_get/about_me_provider.dart';
import '../../../logic/cubit/profile_get/about_me/about_me_cubit.dart';
import '../../widgets/auth/custom_elevated_btn.dart';
import '../../widgets/return_btn.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AboutMeCubit(aboutMeProvider: AboutMeProvider()),
      child: Scaffold(
        appBar: AppBar(
          //backgroundColor: AppColors.white,
          title: Text(
            'About Me',
            style: TextStyle(
                color: AppColors.primary, fontWeight: FontWeight.bold),
          ),
          leading: ReturnButton(),
          centerTitle: true,
        ),
        body: BlocConsumer<AboutMeCubit, AboutMeState>(
          listener: (context, state) {},
          builder: (context, state) {
            AboutMeCubit cubit = BlocProvider.of(context);
            //var sections = cubit.sections;
            return Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 15.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 60.0,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => SizedBox(
                                width: 150,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.0),
                                      border: Border.fromBorderSide(BorderSide(
                                          width: 1.0, color: cubit.sections[index].index ==
                                              cubit.section
                                          ? AppColors.white
                                          : AppColors.black,))),
                                  child: CustomElevatedButton(
                                      fun: () {
                                        cubit.changeSection(
                                            cubit.sections[index].index);
                                      },
                                      background: cubit.sections[index].index ==
                                              cubit.section
                                          ? AppColors.primary
                                          : AppColors.white,
                                      foreground: cubit.sections[index].index ==
                                              cubit.section
                                          ? AppColors.white
                                          : AppColors.black,
                                      text: cubit.sections[index].section),
                                ),
                              ),
                          separatorBuilder: (context, index) => const SizedBox(
                                width: 10.0,
                              ),
                          itemCount: cubit.sections.length),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Expanded(child: cubit.getBodyWidget()),
                  ],
                ));
          },
        ),
      ),
    );
  }
}
