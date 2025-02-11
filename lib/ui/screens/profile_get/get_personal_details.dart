import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/functions/translate.dart';
import '../../../logic/cubit/profile_get/about_me/about_me_cubit.dart';
import '../../widgets/empty_data_widget.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/profile_get/personal_data_card.dart';

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
       buildWhen: (previous, current) =>
          current is AboutMeGetPersonalDataLoadingState ||
          current is AboutMeGetPersonalDataSuccessState ||
          current is AboutMeGetPersonalDataErrorState,
      builder: (context, state) {
        if (state is AboutMeGetPersonalDataLoadingState) {
          return AnimatedLoadingWidget();
        }
        if (state is AboutMeGetPersonalDataErrorState) {
          return FailureWidget(showImage: false,
              title: translateLang(context, "error_get_person_data"),
              onTap: () {
                context.read<AboutMeCubit>().getPersonalData();
              });
        }
        if (state is AboutMeGetPersonalDataSuccessState) {
          return state.pData.isEmpty
              ? EmptyDataWidget(
                message: "No personal data available Yet !!!",
              )
              : Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: ListView.separated(
                    itemCount: state.pData.length,
                    itemBuilder: (context, index) =>
                        PersonalDataCard(pData: state.pData[index]),
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      height: 16.0,
                    ),
                  ));
        }
        return SizedBox.shrink();
      },
    );
  }
}
