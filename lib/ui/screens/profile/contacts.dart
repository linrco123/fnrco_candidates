import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/functions/show_toast.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/profile_update/contact.dart';
import 'package:fnrco_candidates/logic/cubit/profile_update/contacts/contacts_type_cubit.dart';
import 'package:fnrco_candidates/logic/cubit/profile_update/experience/experience_cubit.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_drop_text_field.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/ui/widgets/auth/signup/signup_loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/profile/custom_text_field.dart';
import 'package:fnrco_candidates/ui/widgets/profile/title_text.dart';
import 'package:fnrco_candidates/ui/widgets/return_btn.dart';
import 'package:toastification/toastification.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactsTypeCubit(ContactsProvider())..getContacts(),
      child: Scaffold(
        appBar: AppBar(
          //backgroundColor: AppColors.white,
          title: Text(
            translateLang(context, "contact_type"),
            style: TextStyle(
                color: AppColors.primary, fontWeight: FontWeight.bold),
          ),
          leading: ReturnButton(),
          centerTitle: true,
        ),
        body: BlocConsumer<ContactsTypeCubit, ContactsTypeState>(
          listener: (context, state) {
            if (state is CheckExperienceEmptyFieldsState) {
              showToast(context,
                  title: translateLang(context, 'warning'),
                  desc:
                      translateLang(context, "msg_plz_chse_experience_fields"),
                  type: ToastificationType.warning);
            }
            if (state is SubmitContactsTypeSuccessState) {
              showToast(context,
                  title: translateLang(context, 'success'),
                  desc: translateLang(context, "msg_contacts_add_success"),
                  type: ToastificationType.success);
              Navigator.of(context).pop();
            }
            if (state is SubmitContactsTypeFailureState) {
              showToast(context,
                  title: translateLang(context, 'error'),
                  desc: state.message,
                  type: ToastificationType.error);
            }
          },
          builder: (context, state) {
            ContactsTypeCubit cubit = BlocProvider.of(context);

            if (state is ContactsGettingContactTypeLoadingState)
              return AnimatedLoadingWidget();
            return Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: Form(
                key: cubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    state is ContactsGettingContactTypeLoadingState
                        ? SignUpLoadingWidget()
                        : CustomDropTextField(
                            items: cubit.contactsType
                                .map((contact) => DropdownMenuItem<int>(
                                      //alignment: Alignment.center,
                                      child: Text('${contact.metaDataText}'),
                                      value: contact.id,
                                    ))
                                .toList(),
                            text: translateLang(context, "contact_type"),
                            icon: Icon(
                              CupertinoIcons.phone_fill_badge_plus,
                              color: AppColors.grey,
                            ),
                            onChanged: (contact) => cubit.selectContactType(
                                int.parse(contact.toString()))),
                    const SizedBox(
                      height: 16.0,
                    ),
                   
                    CustomTitle(title: 'contact_value'),
                    CustomInputField(
                      controller: cubit.cntCntroller,
                      validate: cubit.validateContactType,
                      hint: translateLang(context, 'contact_value'),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    RadioListTile(
                      value: 1,
                      groupValue: cubit.contactImportance,
                      onChanged: (int? value)=> cubit.changeContactImportance(value!),
                      title: Text('Primary',
                          style: Theme.of(context).textTheme.displayMedium),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    RadioListTile(
                        value: 0,
                        groupValue: cubit.contactImportance,
                        onChanged: (int? value)=> cubit.changeContactImportance(value!),
                        title: Text('Not Primary',
                            style: Theme.of(context).textTheme.displayMedium)),
                    const SizedBox(
                      height: 15.0,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: CustomElevatedButton(
                          fun: () {
                            cubit.addNewContact();
                          },
                          background: AppColors.black,
                          text: 'add New Contact'),
                    ),
                    const Spacer(),
                    state is SubmitContactsTypeLoadingState
                        ? LoadingWidget()
                        : CustomElevatedButton(
                            fun: () {
                              cubit.submitContactsType();
                            },
                            background: AppColors.primary,
                            text: translateLang(context, 'submit')),
                    const SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
