import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/constances.dart';
import 'package:fnrco_candidates/core/functions/animated_transition.dart';
import 'package:fnrco_candidates/core/functions/show_toast.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/ui/screens/profile_add_new/references.dart';
import 'package:fnrco_candidates/ui/widgets/profile_get/references_card.dart';
import 'package:toastification/toastification.dart';
import '../../../logic/cubit/profile_get/about_me/about_me_cubit.dart';
import '../../widgets/empty_data_widget.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';

class GetReferencesScreen extends StatefulWidget {
  const GetReferencesScreen({super.key});

  @override
  State<GetReferencesScreen> createState() => _GetPersonalDetailsScreenState();
}

class _GetPersonalDetailsScreenState extends State<GetReferencesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AboutMeCubit>().getReferences();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AboutMeCubit, AboutMeState>(
        buildWhen: (previous, current) =>
            current is AboutMeGetReferencesLoadingState ||
            current is AboutMeGetReferencesSuccessState ||
            current is AboutMeGetReferencesErrorState ||
            current is AboutMeDeleteLoadingState,
        listener: (context, state) {
          if (state is AboutMeDeleteSuccessState) {
            showToast(context,
                title: translateLang(context, 'success'),
                desc: 'reference is deleted successfully',
                type: ToastificationType.success);
            Navigator.of(context).pop();
          }
          if (state is AboutMeDeleteErrorState) {
            showToast(context,
                title: translateLang(context, 'error'),
                desc: 'reference is not deleted yet !!!',
                type: ToastificationType.error);
            //  Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state is AboutMeGetReferencesLoadingState ||
              state is AboutMeDeleteLoadingState) {
            return const AnimatedLoadingWidget();
          }
          if (state is AboutMeGetReferencesErrorState) {
            return FailureWidget(
                showImage: false,
                title: 'Error ocurred on getting References\n ${state.message}',
                //title: state.message,
                onTap: () {
                  context.read<AboutMeCubit>().getReferences();
                });
          }
          if (state is AboutMeGetReferencesSuccessState) {
            return state.references.isEmpty
                ? const EmptyDataWidget(
                    message: "No references available Yet !!!",
                  )
                : Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: ListView.separated(
                      itemCount: state.references.length,
                      itemBuilder: (context, index) => Dismissible(
                        key: Key("$index"),
                        onDismissed: (direction) {
                          context.read<AboutMeCubit>().deleteSectionItem(
                              REFERENCES, state.references[index].id!);
                        },
                        child: InkWell(
                            onTap: () {
                              animatedTransition(
                                  context,
                                  ReferencesSCreen(
                                    reference: state.references[index],
                                  ));
                            },
                            child: ReferencesCard(
                                reference: state.references[index])),
                      ),
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        height: 16.0,
                      ),
                    ),
                  );
          }
          return const SizedBox.shrink();
        });
  }
}
