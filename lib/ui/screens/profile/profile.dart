import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/logic/cubit/profile/profile/profile_cubit.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/app_images_path.dart';
import 'package:fnrco_candidates/core/classes/cache_helper.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/ui/screens/profile/achievements.dart';
import 'package:fnrco_candidates/ui/screens/profile/contacts.dart';
import 'package:fnrco_candidates/ui/screens/profile/credentials.dart';
import 'package:fnrco_candidates/ui/screens/profile/education_qualification.dart';
import 'package:fnrco_candidates/ui/screens/profile/key_words.dart';
import 'package:fnrco_candidates/ui/screens/profile/language.dart';
import 'package:fnrco_candidates/ui/screens/profile/notes.dart';
import 'package:fnrco_candidates/ui/screens/profile/personal_details.dart';
import 'package:fnrco_candidates/ui/screens/profile/skills.dart';
import 'package:fnrco_candidates/ui/screens/profile/work_experience.dart';
import 'package:fnrco_candidates/ui/widgets/custom_divider.dart';
import 'package:fnrco_candidates/ui/widgets/profile/profile_pic.dart';
import 'package:fnrco_candidates/ui/widgets/return_btn.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

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
          leading: ReturnButton(color: AppColors.white,)
        ),
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
                    CircularPercentIndicator(
                      radius: 40.0,
                      lineWidth: 7.0,
                      percent: 0.5,
                      center: new Text(
                        "50%",
                        style: TextStyle(color: AppColors.white),
                      ),
                      progressColor: AppColors.success,
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
