import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/logic/cubit/profile_get/about_me/about_me_cubit.dart';
import 'package:fnrco_candidates/ui/widgets/empty_data_widget.dart';
import 'package:fnrco_candidates/ui/widgets/error_widget.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/profile_get/note_card.dart';

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
      builder: (context, state) {
        if (state is AboutMeGetNotesLoadingState) {
          return AnimatedLoadingWidget();
        }
        if (state is AboutMeGetNotesErrorState) {
          return FailureWidget(
              title: 'Error ocurred on getting Achievements',
              onTap: () {
                context.read<AboutMeCubit>().getNotes();
              });
        }
       if(state is AboutMeGetNotesSuccessState){
return state.notes.isEmpty
            ? EmptyDataWidget()
            : Container(
                height: double.infinity,
                width: double.infinity,
                child: ListView.separated(
                  itemCount: state.notes.length,
                  itemBuilder: (context, index) =>
                      NoteCard(note: state.notes[index]),
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    height: 10.0,
                  ),
                ),
              );
       }
       return SizedBox.shrink();
        
      },
    );
  }
}