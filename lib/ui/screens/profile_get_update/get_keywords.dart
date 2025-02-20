import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/ui/widgets/profile_get/references_card.dart';
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
    return BlocBuilder<AboutMeCubit, AboutMeState>(
        buildWhen: (previous, current) =>
            current is AboutMeGetReferencesLoadingState ||
            current is AboutMeGetReferencesSuccessState ||
            current is AboutMeGetReferencesErrorState,
        builder: (context, state) {
          if (state is AboutMeGetReferencesLoadingState) {
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
                      itemBuilder: (context, index) =>
                          ReferencesCard(reference: state.references[index]),
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
