import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/app_colors.dart';
import '../../../core/functions/show_toast.dart';
import '../../../core/functions/translate.dart';
import '../../../data/api_provider/profile_update/language.dart';
import '../../../logic/cubit/profile_update/languages/languages_cubit.dart';
import '../../widgets/auth/custom_elevated_btn.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/profile/custom_text_field.dart';
import '../../widgets/profile/title_text.dart';
import '../../widgets/return_btn.dart';
import 'package:toastification/toastification.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguagesCubit(LanguageProvider()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text(
            translateLang(context, "languages"),
            style: TextStyle(
                color: AppColors.primary, fontWeight: FontWeight.bold),
          ),
          leading: ReturnButton(),
          centerTitle: true,
        ),
        body: BlocConsumer<LanguagesCubit, LanguagesState>(
          listener: (context, state) {
            if (state is SubmitLanguagesSuccessState) {
              showToast(context,
                  title: translateLang(context, 'success'),
                  desc: translateLang(context, "msg_langs_add_success"),
                  type: ToastificationType.success);
              Navigator.of(context).pop();
            }
            if (state is SubmitLanguagesErrorState) {
              showToast(context,
                  title: translateLang(context, 'error'),
                  desc: state.message,
                  type: ToastificationType.error);
            }
          },
          builder: (context, state) {
            LanguagesCubit cubit = BlocProvider.of(context);
            return Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: Form(
                key: cubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Expanded(child: SingleChildScrollView(
                     child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       const SizedBox(
                        height: 15.0,
                      ),
                      CustomTitle(title: 'language'),
                      CustomInputField(
                        controller: cubit.langCntroller,
                        validate: cubit.validateLanguage,
                        hint: translateLang(context, 'language'),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      CustomTitle(title: 'lang_test_by'),
                      CustomInputField(
                        controller: cubit.testCntroller,
                        validate: cubit.validateTestBy,
                        hint: translateLang(context, "lang_test_by"),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      CustomTitle(title: "lang_level"),
                      RadioListTile(
                        value: 1,
                        groupValue: cubit.languageLevel,
                        onChanged: (int? value) =>
                            cubit.changeLanguageLevel(value!),
                        title: Text('1',
                            style: Theme.of(context).textTheme.displayMedium),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      RadioListTile(
                        value: 2,
                        groupValue: cubit.languageLevel,
                        onChanged: (int? value) =>
                            cubit.changeLanguageLevel(value!),
                        title: Text('2',
                            style: Theme.of(context).textTheme.displayMedium),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      RadioListTile(
                        value: 3,
                        groupValue: cubit.languageLevel,
                        onChanged: (int? value) =>
                            cubit.changeLanguageLevel(value!),
                        title: Text('3',
                            style: Theme.of(context).textTheme.displayMedium),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      RadioListTile(
                        value: 4,
                        groupValue: cubit.languageLevel,
                        onChanged: (int? value) =>
                            cubit.changeLanguageLevel(value!),
                        title: Text('4',
                            style: Theme.of(context).textTheme.displayMedium),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      RadioListTile(
                        value: 5,
                        groupValue: cubit.languageLevel,
                        onChanged: (int? value) =>
                            cubit.changeLanguageLevel(value!),
                        title: Text('5',
                            style: Theme.of(context).textTheme.displayMedium),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: CustomElevatedButton(
                            fun: () {
                              cubit.addNewLanguage();
                            },
                            background: AppColors.black,
                            text: translateLang(context, 'add_new_lang')),
                      ),
                     ],),
                   )),
                    state is SubmitLanguagesLoadingState
                        ? LoadingWidget()
                        : CustomElevatedButton(
                            fun: () {
                              cubit.submitLanguages();
                            },
                            background: AppColors.primary,
                            text: translateLang(context, 'submit')),
                    const SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
