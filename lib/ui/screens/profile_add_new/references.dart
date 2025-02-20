import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/ui/widgets/auth/name_email_phone_form_field.dart';
import '../../../constants/app_colors.dart';
import '../../../core/functions/show_toast.dart';
import '../../../core/functions/translate.dart';
import '../../../data/api_provider/profile_update/references.dart';
import '../../../logic/cubit/profile_update/references/references_cubit.dart';
import '../../widgets/auth/custom_elevated_btn.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/profile/custom_text_field.dart';
import '../../widgets/profile/title_text.dart';
import '../../widgets/return_btn.dart';
import 'package:toastification/toastification.dart';

class ReferencesSCreen extends StatelessWidget {
  const ReferencesSCreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReferencesCubit(RefencesProvider()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text(
            translateLang(context, 'references'),
            style: TextStyle(
                color: AppColors.primary, fontWeight: FontWeight.bold),
          ),
          leading: ReturnButton(),
          centerTitle: true,
        ),
        floatingActionButton: Builder(builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.08),
            child: FloatingActionButton(
              onPressed: () {
                BlocProvider.of<ReferencesCubit>(context).addNewReferences();
              },
              child: const Icon(CupertinoIcons.add),
            ),
          );
        }),
        body: BlocConsumer<ReferencesCubit, KeyWordsState>(
          listener: (context, state) {
            if (state is SubmitKeyWordsSuccessState) {
              showToast(context,
                  title: translateLang(context, 'success'),
                  desc: translateLang(context, "msg_keyw_add_success"),
                  type: ToastificationType.success);
              Navigator.of(context).pop();
            }
            if (state is SubmitKeyWordsFailureState) {
              showToast(context,
                  title: translateLang(context, 'error'),
                  desc: state.message,
                  type: ToastificationType.error);
            }
          },
          builder: (context, state) {
            ReferencesCubit cubit = BlocProvider.of(context);

            return Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: Form(
                key: cubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15.0,
                    ),
                    const CustomTitle(title: 'job_title'),
                    CustomInputField(
                      controller: cubit.jobTitleCntroller,
                      validate: cubit.validateJobTitle,
                      hint: translateLang(context, 'job_title'),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const CustomTitle(title: 'company_name'),
                    CustomInputField(
                      controller: cubit.companyCntroller,
                      validate: cubit.validateCompany,
                      hint: translateLang(context, 'company_name'),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const CustomTitle(title: "full_name"),
                    NameEmailPhoneFormField(
                        controller: cubit.nameController,
                        inputType: TextInputType.name,
                        prefixIcon: CupertinoIcons.person,
                        hint: translateLang(context, "full_name"),
                        validate: cubit.validateName),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const CustomTitle(title: "email"),
                    NameEmailPhoneFormField(
                        controller: cubit.emailController,
                        inputType: TextInputType.emailAddress,
                        prefixIcon: CupertinoIcons.mail,
                        hint: translateLang(context, "email"),
                        validate: cubit.validateEmail),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const CustomTitle(title: "phone_number"),
                    NameEmailPhoneFormField(
                        controller: cubit.phoneController,
                        inputType: TextInputType.phone,
                        prefixIcon: CupertinoIcons.phone,
                        hint: translateLang(context, "phone_number"),
                        validate: cubit.validatePhone),
                    const Spacer(),
                    state is SubmitKeyWordsLoadingState
                        ? const AnimatedLoadingWidget()
                        : CustomElevatedButton(
                            fun: () {
                              cubit.submit();
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
