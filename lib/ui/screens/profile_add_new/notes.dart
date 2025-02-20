
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/app_colors.dart';
import '../../../core/functions/show_toast.dart';
import '../../../core/functions/translate.dart';
import '../../../data/api_provider/profile_update/notes.dart';
import '../../../logic/cubit/profile_update/notes/notes_cubit.dart';
import '../../widgets/auth/custom_elevated_btn.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/profile/custom_text_field.dart';
import '../../widgets/profile/title_text.dart';
import '../../widgets/return_btn.dart';
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
        floatingActionButton: Builder(builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.08),
            child: FloatingActionButton(
              onPressed: () {
                BlocProvider.of<NotesCubit>(context).addNewNotes();
              },
              child: const Icon(CupertinoIcons.add),
            ),
          );
        }),
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

                    const CustomTitle(title: 'note'),
                    CustomInputField(
                      controller: cubit.notCntroller,
                      validate: cubit.validateNotes,
                      linesNum: 10,
                      hint: translateLang(context, 'enter_notes'),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    // TextButton(
                    //   style: ButtonStyle(shape:WidgetStateProperty.all<OutlinedBorder>(ContinuousRectangleBorder()) ),
                      
                    //   onPressed: () {}, child: Text('text')),
                    // SizedBox(
                    //   width: MediaQuery.of(context).size.width / 2,
                    //   child: CustomElevatedButton(
                    //       fun: () {
                    //         cubit.addNewNotes();
                    //       },
                    //       background: AppColors.black,
                    //       text: translateLang(context, 'add_new_note')),
                    // ),
                    const Spacer(),
                    state is SubmitNotesLoadingState
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
