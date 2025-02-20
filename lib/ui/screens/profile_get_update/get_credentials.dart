import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/core/functions/animated_transition.dart';
import 'package:fnrco_candidates/ui/screens/profile_add_new/credentials.dart';
import '../../../core/functions/translate.dart';
import '../../../logic/cubit/profile_get/about_me/about_me_cubit.dart';
import '../../widgets/empty_data_widget.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/profile_get/credential_card.dart';

class GetCredentialsScreen extends StatefulWidget {
  const GetCredentialsScreen({super.key});

  @override
  State<GetCredentialsScreen> createState() => _GetPersonalDetailsScreenState();
}

class _GetPersonalDetailsScreenState extends State<GetCredentialsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AboutMeCubit>().getCredentials();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutMeCubit, AboutMeState>(
      buildWhen: (previous, current) =>
          current is AboutMeGetCredentialsLoadingState ||
          current is AboutMeGetCredentialsSuccessState ||
          current is AboutMeGetCredentialsErrorState,
      builder: (context, state) {
        if (state is AboutMeGetCredentialsLoadingState) {
          return const AnimatedLoadingWidget();
        }
        if (state is AboutMeGetCredentialsErrorState) {
          return FailureWidget(
              showImage: false,
              title:
                  '${translateLang(context, "error_get_credentials")}\n${state.message}',
              onTap: () {
                context.read<AboutMeCubit>().getCredentials();
              });
        }
        if (state is AboutMeGetCredentialsSuccessState) {
          return state.credentials.isEmpty
              ? const EmptyDataWidget(
                  message: "No credentials available Yet !!!",
                )
              : Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: ListView.separated(
                    itemCount: state.credentials.length,
                    itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          animatedTransition(
                              context,
                              CredentialsScreen(
                                  credential: state.credentials[index]));
                        },
                        child: CredentialCard(
                            credential: state.credentials[index])),
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
