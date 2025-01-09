import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/app_colors.dart';
import '../../../core/functions/show_toast.dart';
import '../../../core/functions/translate.dart';
import '../../../data/api_provider/profile_update/credentials.dart';
import '../../../logic/cubit/profile_update/credentials/credentials_cubit.dart';
import '../../widgets/auth/custom_elevated_btn.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/profile/custom_text_field.dart';
import '../../widgets/profile/date_picker_widget.dart';
import '../../widgets/profile/title_text.dart';
import '../../widgets/return_btn.dart';
import 'package:toastification/toastification.dart';

class CredentialsScreen extends StatelessWidget {
  const CredentialsScreen({super.key});
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CredentialsCubit(CredentialsProvider()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text(
            translateLang(context, "credentials"),
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
                BlocProvider.of<CredentialsCubit>(context).addNewCredentials();
              },
              child: Icon(CupertinoIcons.add),
            ),
          );
        }),
        body: BlocConsumer<CredentialsCubit, CredentialsState>(
          listener: (context, state) {
            if (state is CheckCredentialsEmptyFieldsState) {
              showToast(context,
                  title: translateLang(context, 'warning'),
                  desc:
                      translateLang(context, "msg_plz_chse_experience_fields"),
                  type: ToastificationType.warning);
            }
            if (state is SubmitCredentialsSuccessState) {
              showToast(context,
                  title: translateLang(context, 'success'),
                  desc: translateLang(context, "msg_experience_add_success"),
                  type: ToastificationType.success);
              Navigator.of(context).pop();
            }
            if (state is SubmitCredentialsFailureState) {
              showToast(context,
                  title: translateLang(context, 'error'),
                  desc: state.message,
                  type: ToastificationType.error);
            }
          },
          builder: (context, state) {
            CredentialsCubit cubit = BlocProvider.of(context);
            return Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: Form(
                key: cubit.formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        controller: ScrollController(initialScrollOffset: 30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10.0,
                            ),

                            CustomTitle(title: "credentials_cat"),
                            CustomInputField(
                              controller: cubit.catCntroller,
                              validate: cubit.validateCategory,
                              hint: translateLang(context, "credentials_cat"),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            CustomTitle(title: "credentials_name"),
                            CustomInputField(
                              controller: cubit.nameCntroller,
                              validate: cubit.validateName,
                              hint: translateLang(context, "credentials_name"),
                            ),

                            const SizedBox(
                              height: 10.0,
                            ),
                            CustomTitle(title: "credentials_Number"),
                            CustomInputField(
                              controller: cubit.numbCntroller,
                              validate: cubit.validateNumber,
                              inputType: TextInputType.number,
                              hint:
                                  translateLang(context, "credentials_Number"),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),

                            CustomTitle(title: "issue_date"),
                            CustomDatePicker(
                              onTap: () {
                                cubit.selectIssueDate(context);
                              },
                              text: cubit.issueDate ??
                                  translateLang(context, "issue_date"),
                            ),

                            const SizedBox(
                              height: 10.0,
                            ),

                            CustomTitle(title: "expire_date"),
                            CustomDatePicker(
                              onTap: () {
                                cubit.selectExpiryDate(context);
                              },
                              text: cubit.expireDate ??
                                  translateLang(context, "expire_date"),
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            // SizedBox(
                            //   width: MediaQuery.of(context).size.width / 2,
                            //   child: CustomElevatedButton(
                            //       fun: () {
                            //         cubit.addNewCredentials();
                            //       },
                            //       background: AppColors.black,
                            //       text: translateLang(context, "add_new_cred")),
                            // ),
                            //const Spacer(),

                            const SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    state is SubmitCredentialsLoadingState
                        ? AnimatedLoadingWidget()
                        : CustomElevatedButton(
                            fun: () {
                              cubit.submit();
                            },
                            background: AppColors.primary,
                            text: translateLang(context, 'submit')),
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
