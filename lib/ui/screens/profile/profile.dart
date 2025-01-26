import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/cubit/profile_update/profile/profile_cubit.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_images_path.dart';
import '../../../core/classes/cache_helper.dart';
import '../../../core/functions/translate.dart';
import 'achievements.dart';
import 'contacts.dart';
import 'credentials.dart';
import 'education_qualification.dart';
import 'key_words.dart';
import 'language.dart';
import 'notes.dart';
import 'personal_details.dart';
import 'skills.dart';
import 'work_experience.dart';
import '../profile_get/about_me.dart';
import '../../widgets/custom_divider.dart';
import '../../widgets/profile/profile_pic.dart';
import '../../widgets/return_btn.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        appBar: AppBar(
            backgroundColor: AppColors.primary,
            title: Text(
              translateLang(context, 'profile'),
              style: TextStyle(color: AppColors.white),
            ),
            centerTitle: true,
            leading: ReturnButton(
              color: AppColors.white,
            )),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            var cubit = BlocProvider.of<ProfileCubit>(context);
            return Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ProfilePic(
                      file: CacheHelper.getImage() == null ? false : true,
                      image: CacheHelper.getImage() ?? AppImages.User,
                      imageUploadBtnPress: cubit.changeProfileImage,
                    ),
                    Text(CacheHelper.getName() ?? 'Guest ',
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  color: AppColors.white,
                                )),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 70.0,
                          width: 70.0,
                          child: CircularProgressIndicator(
                            semanticsLabel: 'ddddd',
                            semanticsValue: 'sssss',
                            strokeAlign: BorderSide.strokeAlignCenter,
                            strokeCap: StrokeCap.round,
                            value: 50.0 / 100,
                            color: AppColors.success,
                            backgroundColor: Colors.grey.shade100,
                            strokeWidth: 8.0,
                          ),
                        ),
                        Text(
                          '50%',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(color: AppColors.black),
                        )
                      ],
                    ),
                    CustomDivider(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.34),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _addSettingItem(
                                context: context,
                                icon: Icons.data_exploration_sharp,
                                text: 'About Me',
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => AboutMe()));
                                }),
                            _divider(),
                            _addSettingItem(
                                context: context,
                                icon: Icons.person,
                                text: 'Personal Data',
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          PersonalDetailsScreen()));
                                }),
                            _divider(),
                            _addSettingItem(
                                context: context,
                                icon: Icons.work,
                                text: 'Work Experience',
                                onTap: () {
                                  //  Navigator.of(context).pushNamed(AppPagesNames.EXPERIENCES);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          ExperienceScreen()));
                                }),
                            _divider(),
                            _addSettingItem(
                                context: context,
                                icon: Icons.logo_dev,
                                text: 'Education',
                                onTap: () {
                                  // Navigator.of(context).pushNamed(AppPagesNames.EDUCATION);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          EducationAndQualificationScreen()));
                                }),
                            _divider(),

                            //languages-notes-achievements
                            _addSettingItem(
                                context: context,
                                icon: Icons.bookmark,
                                text: 'Credentials',
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CredentialsScreen(),
                                  ));
                                  // Navigator.of(context)
                                  //     .pushNamed(AppPagesNames.CREDENTIALS);
                                }),
                            _divider(),
                            _addSettingItem(
                                context: context,
                                icon: Icons.phone_in_talk,
                                text: 'Contacts',
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ContactsScreen(),
                                  ));
                                  // Navigator.of(context)
                                  //     .pushNamed(AppPagesNames.CONTACT_TYPE);
                                }),
                            _divider(),
                            _addSettingItem(
                                context: context,
                                icon: Icons.waves,
                                text: 'Skills',
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SkillsSCreen(),
                                  ));
                                  // Navigator.of(context)
                                  //     .pushNamed(AppPagesNames.SKILLS);
                                }),
                            _divider(),

                            _addSettingItem(
                                context: context,
                                icon: Icons.language,
                                text: 'Language',
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LanguageScreen(),
                                  ));
                                  // Navigator.of(context)
                                  //     .pushNamed(AppPagesNames.LANGUAGE);
                                }),
                            _divider(),
                            _addSettingItem(
                                context: context,
                                icon: Icons.note,
                                text: 'Notes',
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => NotesScreen(),
                                  ));
                                  // Navigator.of(context)
                                  //     .pushNamed(AppPagesNames.NOTES);
                                }),
                            _divider(),
                            _addSettingItem(
                                context: context,
                                icon: Icons.work,
                                text: 'Achievements',
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AchievementsSCreen(),
                                  ));
                                  // Navigator.of(context)
                                  //     .pushNamed(AppPagesNames.ACHIEVEMENTS);
                                }),
                            _divider(),
                            _addSettingItem(
                                context: context,
                                icon: Icons.work,
                                text: 'KeyWords',
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => KeyWordsSCreen(),
                                  ));
                                  // Navigator.of(context)
                                  //     .pushNamed(AppPagesNames.KEYWORDS);
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

Widget _addSettingItem(
    {required BuildContext context,
    required IconData icon,
    required String text,
    required void Function() onTap}) {
  return InkWell(
    onTap: onTap,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 15),
          child: Row(
            children: [
              Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      shape: BoxShape.circle),
                  child: Icon(
                    icon,
                    color: AppColors.black,
                  )),
              const SizedBox(
                width: 15,
              ),
              Text(
                text,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5, right: 30),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.primary,
                  size: 25.0,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

_divider() {
  return Padding(
    padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
    child: Divider(
      color: AppColors.primary,
      thickness: 0.1,
    ),
  );
}
