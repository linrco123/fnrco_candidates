import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/functions/translate.dart';
import '../../../logic/cubit/profile_get/about_me/about_me_cubit.dart';
import '../../widgets/empty_data_widget.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/profile_get/language_card.dart';

class GetLanguagesScreen extends StatefulWidget {
  const GetLanguagesScreen({super.key});

  @override
  State<GetLanguagesScreen> createState() => _GetPersonalDetailsScreenState();
}

class _GetPersonalDetailsScreenState extends State<GetLanguagesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AboutMeCubit>().getLanguages();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutMeCubit, AboutMeState>(
      builder: (context, state) {
        if (state is AboutMeGetLanguagesLoadingState) {
          return AnimatedLoadingWidget();
        }
        if (state is AboutMeGetLanguagesErrorState) {
          return FailureWidget(showImage: false,
              title: translateLang(context, "error_get_languages"),
              onTap: () {
                context.read<AboutMeCubit>().getLanguages();
              });
        }
       if(state is AboutMeGetLanguagesSuccessState){
        return state.languages.isEmpty
            ? EmptyDataWidget(
              message: "No languages available Yet !!!",
            )
            : Container(
                height: double.infinity,
                width: double.infinity,
                child: ListView.separated(
                  itemCount: state.languages.length,
                  itemBuilder: (context, index) =>
                      LanguageCard(language: state.languages[index]),
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