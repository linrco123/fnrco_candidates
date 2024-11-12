import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/logic/cubit/profile/profile_cubit.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/app_images_path.dart';
import 'package:fnrco_candidates/core/classes/cache_helper.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/ui/screens/profile_editing.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/ui/widgets/custom_divider.dart';
import 'package:fnrco_candidates/ui/widgets/profile/info.dart';
import 'package:fnrco_candidates/ui/widgets/profile/profile_pic.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(translateLang(context, 'profile')),
          centerTitle: true,
          leading: BackButton(
            color: AppColors.primary,
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              var cubit = BlocProvider.of<ProfileCubit>(context);
              return Column(
                children: [
                  ProfilePic(
                    file: CacheHelper.getImage() == null ? false : true,
                    image: CacheHelper.getImage() ?? AppImages.User,
                    imageUploadBtnPress: cubit.changeProfileImage,
                  ),
                  Text(
                    "Muhammed Nady",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  // Text(
                  //   CacheHelper.getName() ?? ' ',
                  //  // style: Theme.of(context).textTheme.titleLarge,
                  // ),
                  new CircularPercentIndicator(
                  radius: 40.0,
                  lineWidth: 7.0,
                  percent: 0.5,
                  center: new Text("50%"),
                  progressColor: Colors.green,

                ),
                  CustomDivider(),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 70.0,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) => Container(
                        width: 150.0,
                        child: CustomElevatedButton(
                            fun: () {},
                            background: AppColors.primary,
                            foreground: AppColors.black,
                            text: 'Personal Data'),
                      ),
                      separatorBuilder: (context, index) => SizedBox(width: 10.0,),
                    ),
                  ),
                  // Info(
                  //   infoKey: translateLang(context, 'user_id'),
                  //   info: "@muhammed.me",
                  // ),
                  // Info(
                  //   infoKey: translateLang(context, 'location'),
                  //   info: "Cairo , Egypt",
                  // ),
                  // Info(
                  //   infoKey: translateLang(context, 'phone_number'),
                  //   info: "01153661128"//(239) 555-0108",
                  //  //info: CacheHelper.getPhone()?? ' ',
                  // ),
                  // Info(
                  //   infoKey: translateLang(context, 'email'),
                  //   info: "muhammednady49@gmail.com",
                  //   //info: CacheHelper.getEmail()?? ' ',
                  // ),
                  const SizedBox(height: 16.0),
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: SizedBox(
                  //       width: 160,
                  //       child: CustomElevatedButton(
                  //           fun: () {
                  //             Navigator.of(context).push(MaterialPageRoute(
                  //                 builder: (context) =>
                  //                     const EditProfileScreen()));
                  //           },
                  //           background: AppColors.primary,
                  //           text: 'Edit Profile')),
                  // ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
