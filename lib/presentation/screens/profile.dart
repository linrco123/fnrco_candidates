import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/logic/cubit/profile/profile_cubit.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/app_images_path.dart';
import 'package:fnrco_candidates/core/classes/cache_helper.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/presentation/screens/profile_editing.dart';
import 'package:fnrco_candidates/presentation/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/presentation/widgets/custom_divider.dart';
import 'package:fnrco_candidates/presentation/widgets/profile/info.dart';
import 'package:fnrco_candidates/presentation/widgets/profile/profile_pic.dart';

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
                    image:  CacheHelper.getImage() ?? AppImages.User,
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
                  CustomDivider(),
                  Info(
                    infoKey: translateLang(context, 'user_id'),
                    info: "@muhammed.me",
                  ),
                  Info(
                    infoKey: translateLang(context, 'location'),
                    info: "Cairo , Egypt",
                  ),
                  Info(
                    infoKey: translateLang(context, 'phone_number'),
                    info: "01153661128"//(239) 555-0108",
                   //info: CacheHelper.getPhone()?? ' ',
                  ),
                  Info(
                    infoKey: translateLang(context, 'email'),
                    info: "muhammednady49@gmail.com",
                    //info: CacheHelper.getEmail()?? ' ',
                  ),
                  const SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                        width: 160,
                        child: CustomElevatedButton(
                            fun: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const EditProfileScreen()));
                            },
                            background: AppColors.primary,
                            text: 'Edit Profile')),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
