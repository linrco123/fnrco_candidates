import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/functions/translate.dart';
import '../../../logic/cubit/profile_get/about_me/about_me_cubit.dart';
import '../../widgets/empty_data_widget.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/profile_get/note_card.dart';

class GetNotesScreen extends StatefulWidget {
  const GetNotesScreen({super.key});

  @override
  State<GetNotesScreen> createState() => _GetPersonalDetailsScreenState();
}

class _GetPersonalDetailsScreenState extends State<GetNotesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AboutMeCubit>().getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutMeCubit, AboutMeState>(
       buildWhen: (previous, current) =>
          current is AboutMeGetNotesLoadingState ||
          current is AboutMeGetNotesSuccessState ||
          current is AboutMeGetNotesErrorState,
      builder: (context, state) {
        if (state is AboutMeGetNotesLoadingState) {
          return AnimatedLoadingWidget();
        }
        if (state is AboutMeGetNotesErrorState) {
          return FailureWidget(
              showImage: false,
              title: translateLang(context, "error_get_notes"),
              onTap: () {
                context.read<AboutMeCubit>().getNotes();
              });
        }
        if (state is AboutMeGetNotesSuccessState) {
          return state.notes.isEmpty
              ? EmptyDataWidget(
                message: "No notes available Yet !!!",
              )
              : Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: ListView.separated(
                    itemCount: state.notes.length,
                    itemBuilder: (context, index) =>
                        NoteCard(note: state.notes[index]),
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      height: 16.0,
                    ),
                  ),
                );
        }
        return SizedBox.shrink();
      },
    );
  }
}
