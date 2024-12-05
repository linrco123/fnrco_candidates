import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/logic/cubit/profile_get/about_me/about_me_cubit.dart';
import 'package:fnrco_candidates/ui/widgets/empty_data_widget.dart';
import 'package:fnrco_candidates/ui/widgets/error_widget.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/profile_get/personal_data_card.dart';

class GetPersonalDetailsScreen extends StatefulWidget {
  const GetPersonalDetailsScreen({super.key});

  @override
  State<GetPersonalDetailsScreen> createState() =>
      _GetPersonalDetailsScreenState();
}

class _GetPersonalDetailsScreenState extends State<GetPersonalDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AboutMeCubit>().getPersonalData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutMeCubit, AboutMeState>(
      builder: (context, state) {
        if (state is AboutMeGetPersonalDataLoadingState) {
          return AnimatedLoadingWidget();
        }
        if (state is AboutMeGetPersonalDataErrorState) {
          return FailureWidget(
              title: 'Error ocurred on getting PersonalData',
              onTap: () {
                context.read<AboutMeCubit>().getPersonalData();
              });
        }
        if (state is AboutMeGetPersonalDataSuccessState) {
          return state.pData.isEmpty
              ? EmptyDataWidget()
              : Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: ListView.separated(
                    itemCount: state.pData.length,
                    itemBuilder: (context, index) =>
                        PersonalDataCard(pData: state.pData[index]),
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      height: 10.0,
                    ),
                  ));
        }
        return SizedBox.shrink();
      },
    );
  }
}
