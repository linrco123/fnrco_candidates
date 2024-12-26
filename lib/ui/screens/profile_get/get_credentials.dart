import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
