import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/logic/cubit/profile/profile/profile_cubit.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/app_images_path.dart';
import 'package:fnrco_candidates/constants/app_pages_names.dart';
import 'package:fnrco_candidates/core/classes/cache_helper.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/ui/widgets/auth/name_email_phone_form_field.dart';
import 'package:fnrco_candidates/ui/widgets/auth/password_form_field.dart';
import 'package:fnrco_candidates/ui/widgets/custom_divider.dart';
import 'package:fnrco_candidates/ui/widgets/profile/profile_pic.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          //backgroundColor: AppColors.primary,
          title: Text(translateLang(context, 'edit_profile'),
              style: Theme.of(context).textTheme.headlineLarge),
          leading: BackButton(
            color: AppColors.primary,
          ),
        ),
        body: Container(
          //color: AppColors.primary.withOpacity(0.1),
          child: BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              var cubit = BlocProvider.of<ProfileCubit>(context);
              var _controller = TextEditingController()..text = 'Muhammed nady';
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    ProfilePic(
                      file: CacheHelper.getImage() == null ? false : true,
                      image: CacheHelper.getImage() ?? AppImages.User,
                      imageUploadBtnPress: cubit.changeProfileImage,
                    ),
                    const CustomDivider(),
                    Form(
                      key: cubit.formKey,
                      child: Column(
                        children: [
                          UserInfoEditField(
                            text: translateLang(context, 'full_name'),
                            child: NameEmailPhoneFormField(
                                controller: cubit.nameController..text='Muhammed Nady',
                                inputType: TextInputType.name,
                                validate: cubit.validateFullName),
                          ),
                          UserInfoEditField(
                              text: translateLang(context, 'email'),
                              child: NameEmailPhoneFormField(
                                  controller: cubit.emailController..text='muhammednady49@gmail.com',
                                  inputType: TextInputType.emailAddress,
                                  validate: cubit.validateEmail)),
                          UserInfoEditField(
                              text: translateLang(context, 'phone_number'),
                              child: NameEmailPhoneFormField(
                                  controller: cubit.phoneController..text='01153661128',
                                  inputType: TextInputType.phone,
                                  validate: cubit.validatePhone)),
                          UserInfoEditField(
                              text: translateLang(context, 'location'),
                              child: NameEmailPhoneFormField(
                                  controller: cubit.addressController..text='Cairo , Egypt',
                                  inputType: TextInputType.text,
                                  validate: cubit.validateAddress)),
                          UserInfoEditField(
                            text: translateLang(context, "old_password"),
                            child: PasswordFormField(
                                controller: cubit.oldPasswordController..text='12345678',
                                obscureText: cubit.obscureText1,
                                toggleObscureText: cubit.toggleObscureText1,
                                visibleIcon: cubit.getIcon1(),
                                validate: cubit.validatePassword,
                                hint: "Old Password"),
                          ),
                          UserInfoEditField(
                            text: translateLang(context, "new_password"),
                            child: PasswordFormField(
                                controller: cubit.newPasswordController,
                                obscureText: cubit.obscureText2,
                                toggleObscureText: cubit.toggleObscureText2,
                                visibleIcon: cubit.getIcon2(),
                                validate: cubit.validatePassword,
                                hint: translateLang(context, "new_password")),
                          ),
                          // UserInfoEditField(
                          //   text: "New Password",
                          //   child: TextFormField(
                          //     decoration: InputDecoration(
                          //       hintText: "New Password",
                          //       filled: true,
                          //       fillColor:
                          //           const Color(0xFF00BF6D).withOpacity(0.05),
                          //       contentPadding: const EdgeInsets.symmetric(
                          //           horizontal: 16.0 * 1.5, vertical: 16.0),
                          //       border: const OutlineInputBorder(
                          //         borderSide: BorderSide.none,
                          //         borderRadius:
                          //             BorderRadius.all(Radius.circular(50)),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                            width: 120,
                            child: CustomElevatedButton(
                                fun: () {
                                  Navigator.of(context).pop();
                                },
                                background: AppColors.secondary,
                                text: translateLang(context, 'cancel'))),
                        const SizedBox(width: 16.0),
                        SizedBox(
                            width: 160,
                            child: CustomElevatedButton(
                                fun: () {
                                  Navigator.of(context).pushNamed(AppPagesNames.HOMEPAGE);
                                },
                                background: AppColors.primary,
                                text: translateLang(context, 'save_updates'))),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class UserInfoEditField extends StatelessWidget {
  const UserInfoEditField({
    super.key,
    required this.text,
    required this.child,
  });

  final String text;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0 / 2),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(text),
          ),
          Expanded(
            flex: 3,
            child: child,
          ),
        ],
      ),
    );
  }
}
