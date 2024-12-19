import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/functions/show_toast.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/profile_update/notes.dart';
import 'package:fnrco_candidates/logic/cubit/profile_update/notes/notes_cubit.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/profile/custom_text_field.dart';
import 'package:fnrco_candidates/ui/widgets/profile/title_text.dart';
import 'package:fnrco_candidates/ui/widgets/return_btn.dart';
import 'package:toastification/toastification.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesCubit(NotesProvider()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text(
            translateLang(context, 'notes'),
            style: TextStyle(
                color: AppColors.primary, fontWeight: FontWeight.bold),
          ),
          leading: ReturnButton(),
          centerTitle: true,
        ),
        body: BlocConsumer<NotesCubit, NotesState>(
          listener: (context, state) {
            if (state is SubmitNotesSuccessState) {
              showToast(context,
                  title: translateLang(context, 'success'),
                  desc: translateLang(context, "msg_notes_add_success"),
                  type: ToastificationType.success);
              Navigator.of(context).pop();
            }
            if (state is SubmitNotesFailureState) {
              showToast(context,
                  title: translateLang(context, 'error'),
                  desc: state.message,
                  type: ToastificationType.error);
            }
          },
          builder: (context, state) {
            NotesCubit cubit = BlocProvider.of(context);

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
                    
                    CustomTitle(title: 'note'),
                    CustomInputField(
                      controller: cubit.notCntroller,
                      validate: cubit.validateNotes,
                      linesNum: 10,
                      hint: translateLang(context, 'enter_notes'),
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
                            cubit.addNewNotes();
                          },
                          background: AppColors.black,
                          text: translateLang(context, 'add_new_note')),
                    ),
                    const Spacer(),
                    state is SubmitNotesLoadingState
                        ? LoadingWidget()
                        : CustomElevatedButton(
                            fun: () {
                              cubit.submitNotes();
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
