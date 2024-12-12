import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/logic/cubit/profile_get/about_me/about_me_cubit.dart';
import 'package:fnrco_candidates/ui/widgets/empty_data_widget.dart';
import 'package:fnrco_candidates/ui/widgets/error_widget.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/profile_get/credential_card.dart';

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
      builder: (context, state) {
        if (state is AboutMeGetCredentialsLoadingState) {
          return AnimatedLoadingWidget();
        }
        if (state is AboutMeGetCredentialsErrorState) {
          return FailureWidget(
              title: translateLang(context, "error_get_credentials"),
              onTap: () {
                context.read<AboutMeCubit>().getCredentials();
              });
        }
        if(state is AboutMeGetCredentialsSuccessState){
        return state.credentials.isEmpty
            ? EmptyDataWidget()
            : Container(
                height: double.infinity,
                width: double.infinity,
                child: ListView.separated(
                  itemCount: state.credentials.length,
                  itemBuilder: (context, index) =>
                      CredentialCard(credential: state.credentials[index]),
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
