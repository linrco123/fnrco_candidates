import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/data/models/profile_get/keywords_model.dart';
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
  final GetReference? reference;
  const ReferencesSCreen({super.key, this.reference});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ReferencesCubit(RefencesProvider())..fillFields(reference),
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
        floatingActionButton: reference != null
            ? null
            : Builder(builder: (context) {
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.08),
                  child: FloatingActionButton(
                    onPressed: () {
                      BlocProvider.of<ReferencesCubit>(context)
                          .addNewReferences();
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
                    CustomInputField(
                      controller: cubit.nameController,
                      validate: cubit.validateName,
                      hint: translateLang(context, "full_name"),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const CustomTitle(title: "email"),
                    CustomInputField(
                      controller: cubit.emailController,
                      validate: cubit.validateEmail,
                      hint: translateLang(context, "email"),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const CustomTitle(title: "phone_number"),
                    CustomInputField(
                      controller: cubit.phoneController,
                      validate: cubit.validatePhone,
                      hint: translateLang(context, "phone_number"),
                    ),
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
