import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/functions/show_toast.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/profile_update/keywords.dart';
import 'package:fnrco_candidates/logic/cubit/profile_update/key_words/key_words_cubit.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/profile/custom_text_field.dart';
import 'package:fnrco_candidates/ui/widgets/return_btn.dart';
import 'package:toastification/toastification.dart';

class KeyWordsSCreen extends StatelessWidget {
  const KeyWordsSCreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => KeyWordsCubit(KeywordsProvider()),
      child: Scaffold(
        appBar: AppBar(
          //backgroundColor: AppColors.white,
          title: Text(
            translateLang(context, 'keywords'),
            style: TextStyle(
                color: AppColors.primary, fontWeight: FontWeight.bold),
          ),
          leading: ReturnButton(),
          centerTitle: true,
        ),
        body: BlocConsumer<KeyWordsCubit,KeyWordsState>(
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
            KeyWordsCubit cubit = BlocProvider.of(context);

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
                    Text(
                      translateLang(context, 'keyword'),
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    CustomInputField(
                      controller: cubit.keyWCntroller,
                      validate: cubit.validateKeyWord,
                      linesNum: 3,
                      hint: translateLang(context, 'keyword'),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: CustomElevatedButton(
                          fun: () {
                            cubit.addNewKeyword();
                          },
                          background: AppColors.black,
                          text: translateLang(context, 'add_new_keyw')),
                    ),
                    const Spacer(),
                    state is SubmitKeyWordsLoadingState
                        ? LoadingWidget()
                        : CustomElevatedButton(
                            fun: () {
                              cubit.submitKeyWords();
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
