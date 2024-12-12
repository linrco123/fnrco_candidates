import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/logic/cubit/profile_get/about_me/about_me_cubit.dart';
import 'package:fnrco_candidates/ui/widgets/empty_data_widget.dart';
import 'package:fnrco_candidates/ui/widgets/error_widget.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/profile_get/contact_card.dart';

class GetContactsScreen extends StatefulWidget {
  const GetContactsScreen({super.key});

  @override
  State<GetContactsScreen> createState() => _GetPersonalDetailsScreenState();
}

class _GetPersonalDetailsScreenState extends State<GetContactsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AboutMeCubit>().getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutMeCubit, AboutMeState>(
      builder: (context, state) {
        if (state is AboutMeGetContactsLoadingState) {
          return AnimatedLoadingWidget();
        }
        if (state is AboutMeGetContactsErrorState) {
          return FailureWidget(
              title: translateLang(context, "error_get_contacts"),
              onTap: () {
                context.read<AboutMeCubit>().getContacts();
              });
        }
      
     if(state is AboutMeGetContactsSuccessState){ 
        return state.contacts.isEmpty
            ? EmptyDataWidget()
            : Container(
                height: double.infinity,
                width: double.infinity,
                child: ListView.separated(
                  itemCount: state.contacts.length,
                  itemBuilder: (context, index) =>
                      ContactCard(contact: state.contacts[index]),
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
