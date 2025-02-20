import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/core/functions/animated_transition.dart';
import 'package:fnrco_candidates/ui/screens/profile_add_new/contacts.dart';
import '../../../core/functions/translate.dart';
import '../../../logic/cubit/profile_get/about_me/about_me_cubit.dart';
import '../../widgets/empty_data_widget.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/profile_get/contact_card.dart';

class GetContactsScreen extends StatefulWidget {
  const GetContactsScreen({super.key});

  @override
  State<GetContactsScreen> createState() => _GetPersonalDetailsScreenState();
}

class _GetPersonalDetailsScreenState extends State<GetContactsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AboutMeCubit>().getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutMeCubit, AboutMeState>(
      buildWhen: (previous, current) =>
          current is AboutMeGetContactsLoadingState ||
          current is AboutMeGetContactsSuccessState ||
          current is AboutMeGetContactsErrorState,
      builder: (context, state) {
        if (state is AboutMeGetContactsLoadingState) {
          return const AnimatedLoadingWidget();
        }
        if (state is AboutMeGetContactsErrorState) {
          return FailureWidget(
              showImage: false,
              title:
                  '${translateLang(context, "error_get_contacts")}\n${state.message}',
              onTap: () {
                context.read<AboutMeCubit>().getContacts();
              });
        }

        if (state is AboutMeGetContactsSuccessState) {
          return state.contacts.isEmpty
              ? const EmptyDataWidget(
                  message: "No contacts available Yet !!!",
                )
              : Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: ListView.separated(
                    itemCount: state.contacts.length,
                    itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          animatedTransition(
                              context,
                              ContactsScreen(
                                contact: state.contacts[index],
                              ));
                        },
                        child: ContactCard(contact: state.contacts[index])),
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
