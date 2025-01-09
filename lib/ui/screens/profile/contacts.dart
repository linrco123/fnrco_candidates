import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/app_colors.dart';
import '../../../core/functions/show_toast.dart';
import '../../../core/functions/translate.dart';
import '../../../data/api_provider/profile_update/contact.dart';
import '../../../logic/cubit/profile_update/contacts/contacts_type_cubit.dart';
import '../../../logic/cubit/profile_update/experience/experience_cubit.dart';
import '../../widgets/auth/custom_drop_text_field.dart';
import '../../widgets/auth/custom_elevated_btn.dart';
import '../../widgets/auth/signup/signup_loading_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/profile/custom_text_field.dart';
import '../../widgets/profile/title_text.dart';
import '../../widgets/return_btn.dart';
import 'package:toastification/toastification.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactsTypeCubit(ContactsProvider())..getContacts(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text(
            translateLang(context, "contact_type"),
            style: TextStyle(
                color: AppColors.primary, fontWeight: FontWeight.bold),
          ),
          leading: ReturnButton(),
          centerTitle: true,
        ),
         floatingActionButton: Builder(builder: (context) {
          return Padding(
            padding:  EdgeInsets.only(bottom:MediaQuery.of(context).size.height*0.08),
            child: FloatingActionButton(
              onPressed: () {
                BlocProvider.of<ContactsTypeCubit>(context).addNewContact();
              },
              child: Icon(CupertinoIcons.add),
            ),
          );
        }),
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
                        ? ItemLoadingWidget()
                        : CustomDropDownSearch(
                            selectedItem:
                                translateLang(context, "contact_type"),
                            items: cubit.contactsType
                                .map((contact) => contact.metaDataText!)
                                .toList(),
                            label: translateLang(context, "contact_type"),
                            onChanged: (value) =>
                                cubit.selectContactType(value!),
                          ),

                    // CustomDropTextField(
                    //     items: cubit.contactsType
                    //         .map((contact) => DropdownMenuItem<int>(
                    //               //alignment: Alignment.center,
                    //               child: Text('${contact.metaDataText}'),
                    //               value: contact.id,
                    //             ))
                    //         .toList(),
                    //     text: translateLang(context, "contact_type"),
                    //     icon: Icon(
                    //       CupertinoIcons.phone_fill_badge_plus,
                    //       color: AppColors.grey,
                    //     ),
                    //     onChanged: (contact) => cubit.selectContactType(
                    //         int.parse(contact.toString()))),
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
                      onChanged: (int? value) =>
                          cubit.changeContactImportance(value!),
                      title: Text('Primary',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    RadioListTile(
                        value: 0,
                        groupValue: cubit.contactImportance,
                        onChanged: (int? value) =>
                            cubit.changeContactImportance(value!),
                        title: Text('Not Primary',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(fontWeight: FontWeight.bold))),
                    const SizedBox(
                      height: 15.0,
                    ),
                    // SizedBox(
                    //   width: MediaQuery.of(context).size.width / 2,
                    //   child: CustomElevatedButton(
                    //       fun: () {
                    //         cubit.addNewContact();
                    //       },
                    //       background: AppColors.black,
                    //       text: translateLang(context, "add_n_contact")),
                    // ),
                    const Spacer(),
                    state is SubmitContactsTypeLoadingState
                        ? AnimatedLoadingWidget()
                        : CustomElevatedButton(
                            fun: () {
                              cubit.submit();
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
