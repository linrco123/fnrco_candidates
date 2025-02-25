import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/constances.dart';
import 'package:fnrco_candidates/core/functions/animated_transition.dart';
import 'package:fnrco_candidates/core/functions/show_toast.dart';
import 'package:fnrco_candidates/ui/screens/profile_add_new/language.dart';
import 'package:toastification/toastification.dart';
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
    return BlocConsumer<AboutMeCubit, AboutMeState>(
      buildWhen: (previous, current) =>
          current is AboutMeGetLanguagesLoadingState ||
          current is AboutMeGetLanguagesSuccessState ||
          current is AboutMeGetLanguagesErrorState ||
          current is AboutMeDeleteLoadingState,
      listener: (context, state) {
        if (state is AboutMeDeleteSuccessState) {
          showToast(context,
              title: translateLang(context, 'success'),
              desc: 'Language is deleted successfully',
              type: ToastificationType.success);
          Navigator.of(context).pop();
        }
        if (state is AboutMeDeleteErrorState) {
          showToast(context,
              title: translateLang(context, 'error'),
              desc: 'Language is not deleted yet !!!',
              type: ToastificationType.error);
          //  Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        if (state is AboutMeGetLanguagesLoadingState ||
            state is AboutMeDeleteLoadingState) {
          return const AnimatedLoadingWidget();
        }
        if (state is AboutMeGetLanguagesErrorState) {
          return FailureWidget(
              showImage: false,
              title:
                  '${translateLang(context, "error_get_languages")}\n${state.message}',
              onTap: () {
                context.read<AboutMeCubit>().getLanguages();
              });
        }
        if (state is AboutMeGetLanguagesSuccessState) {
          return state.languages.isEmpty
              ? const EmptyDataWidget(
                  message: "No languages available Yet !!!",
                )
              : Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: ListView.separated(
                    itemCount: state.languages.length,
                    itemBuilder: (context, index) => Dismissible(
                      key: Key("$index"),
                      onDismissed: (direction) {
                        context.read<AboutMeCubit>().deleteSectionItem(
                            LANGUAGES, state.languages[index].id!);
                      },
                      child: InkWell(
                          onTap: () {
                            animatedTransition(
                                context,
                                LanguageScreen(
                                    language: state.languages[index]));
                          },
                          child:
                              LanguageCard(language: state.languages[index])),
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      height: 16.0,
                    ),
                  ),
                );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
