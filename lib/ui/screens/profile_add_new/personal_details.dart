import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_images_path.dart';
import '../../../core/classes/cache_helper.dart';
import '../../../core/functions/show_toast.dart';
import '../../../core/functions/translate.dart';
import '../../../data/api_provider/profile_update/personal_details.dart';
import '../../../logic/cubit/profile_update/personal_data/personal_details/personal_details_cubit.dart';
import '../../widgets/auth/custom_drop_text_field.dart';
import '../../widgets/auth/custom_elevated_btn.dart';
import '../../widgets/auth/signup/signup_loading_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/profile/custom_text_field.dart';
import '../../widgets/profile/date_picker_widget.dart';
import '../../widgets/profile/profile_pic.dart';
import '../../widgets/profile/title_text.dart';
import '../../widgets/return_btn.dart';
import 'package:toastification/toastification.dart';

class PersonalDetailsScreen extends StatelessWidget {
  const PersonalDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PersonalDetailsCubit(
          personalDetailsProvider: PersonalDetailsProvider())
        ..getCountries()
        ..getGenders()
        ..getReligions()
        ..getMaritalStatus()
        ..getPersonalData(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text(
            translateLang(context, 'personal_details'),
            style: TextStyle(
                color: AppColors.primary, fontWeight: FontWeight.bold),
          ),
          leading: ReturnButton(),
          centerTitle: true,
        ),
        backgroundColor: AppColors.white,
        body: LayoutBuilder(builder: (context, constraints) {
          return BlocConsumer<PersonalDetailsCubit, PersonalDetailsState>(
            listener: (context, state) {
              if (state is PersonalDetailsSuccessState) {
                showToast(context,
                    title: translateLang(context, 'success'),
                    desc: translateLang(context, 'msg_p_Dets_sav_success'),
                    type: ToastificationType.success);
                Navigator.of(context).pop();
              }
              if (state is PersonalDetailsErrorState) {
                showToast(context,
                    title: translateLang(context, 'error'),
                    desc: state.message,
                    type: ToastificationType.error);
              }
            },
            builder: (context, state) {
              final PersonalDetailsCubit personalDetailsCubit =
                  BlocProvider.of(context);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    SizedBox(height: constraints.maxHeight * 0.04),
                    ProfilePic(
                      file: CacheHelper.getImage() == null ? false : true,
                      image: CacheHelper.getImage() ?? AppImages.User,
                      imageUploadBtnPress:
                          personalDetailsCubit.changeProfileImage,
                    ),
                    SizedBox(height: constraints.maxHeight * 0.02),
                    Form(
                      key: personalDetailsCubit.formKey,
                      child: Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 16.0,
                              ),
                              const CustomTitle(
                                title: "resume_attch",
                                frontP: 10.0,
                              ),
                              Container(
                                width: double.infinity / 2,
                                height: personalDetailsCubit.fileName.isEmpty
                                    ? 103
                                    : 300,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    personalDetailsCubit.pickFile();
                                  },
                                  borderRadius: BorderRadius.circular(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      personalDetailsCubit.fileName.isEmpty
                                          ? Icon(
                                              Icons.attach_file,
                                              color: AppColors.primary,
                                            )
                                          : Stack(
                                              children: [
                                                SizedBox(
                                                  width: double.infinity / 2,
                                                  height: 300,
                                                  child: PDFView(
                                                    filePath:
                                                        personalDetailsCubit
                                                            .pdfFile!.path,
                                                    enableSwipe: true,
                                                    swipeHorizontal: true,
                                                    autoSpacing: false,
                                                    pageFling: true,
                                                    pageSnap: true,
                                                    fitEachPage: true,
                                                    defaultPage: 1,
                                                    fitPolicy: FitPolicy.BOTH,
                                                    preventLinkNavigation:
                                                        false,
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 0.0,
                                                  right: 0.0,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: AppColors.black),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        personalDetailsCubit
                                                            .removeFile();
                                                      },
                                                      child: Icon(
                                                        Icons.close,
                                                        color: AppColors.white,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                      if (personalDetailsCubit.fileName.isEmpty)
                                        const SizedBox(height: 10),
                                      personalDetailsCubit.fileName.isEmpty
                                          ? Text(
                                              translateLang(
                                                  context, 'upload_file'),
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            )
                                          : const SizedBox.shrink()
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              const CustomTitle(
                                title: "first_name",
                              ),
                              CustomInputField(
                                  controller:
                                      personalDetailsCubit.firstNameController,
                                  validate:
                                      personalDetailsCubit.validateFirstName,
                                  inputType: TextInputType.name,
                                  hint: translateLang(context, "first_name")),
                              const SizedBox(
                                height: 16.0,
                              ),
                              const CustomTitle(
                                title: "second_name",
                              ),
                              CustomInputField(
                                  controller:
                                      personalDetailsCubit.secondNameController,
                                  validate:
                                      personalDetailsCubit.validateSecondName,
                                  inputType: TextInputType.name,
                                  hint: translateLang(context, "second_name")),
                              const SizedBox(
                                height: 16.0,
                              ),
                              const CustomTitle(
                                title: "last_name",
                              ),
                              CustomInputField(
                                  controller:
                                      personalDetailsCubit.lastNameController,
                                  validate:
                                      personalDetailsCubit.validateLastName,
                                  inputType: TextInputType.name,
                                  hint: translateLang(context, "last_name")),
                              const SizedBox(
                                height: 16.0,
                              ),
                              const CustomTitle(
                                title: "sur_name",
                              ),
                              CustomInputField(
                                  controller:
                                      personalDetailsCubit.surNameController,
                                  validate:
                                      personalDetailsCubit.validateSurName,
                                  inputType: TextInputType.name,
                                  hint: translateLang(context, "sur_name")),
                              const SizedBox(
                                height: 16.0,
                              ),
                              const CustomTitle(
                                title: "email",
                              ),
                              CustomInputField(
                                  controller:
                                      personalDetailsCubit.emailController,
                                  validate: personalDetailsCubit.validateEmail,
                                  inputType: TextInputType.emailAddress,
                                  hint: translateLang(context, "email")),
                              const SizedBox(
                                height: 16.0,
                              ),
                              // const CustomTitle(
                              //   title: "residence",
                              // ),
                              personalDetailsCubit.countries.isEmpty
                                  ? const ItemLoadingWidget()
                                  : CustomDropDownSearch(
                                      label: translateLang(
                                          context, 'select_residence'),
                                      items: personalDetailsCubit.countries
                                          .map(
                                              (country) => country.countryName!)
                                          .toList(),
                                      selectedItem:
                                          personalDetailsCubit.residence,
                                      onChanged: (value) => personalDetailsCubit
                                          .selectResidence(value!),
                                    ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              CustomDatePicker(
                                  onTap: () {
                                    personalDetailsCubit
                                        .selectDateOfBirth(context);
                                  },
                                  text: personalDetailsCubit.birthDate ??
                                      translateLang(context, 'date_birth')),
                              const SizedBox(
                                height: 16.0,
                              ),
                              // SfDateRangePicker(
                              //   onSelectionChanged:(dateRangePickerSelectionChangedArgs) {

                              //   },
                              //   selectionMode:
                              //       DateRangePickerSelectionMode.range,
                              //   initialSelectedRange: PickerDateRange(
                              //       DateTime.now()
                              //           .subtract(const Duration(days: 4)),
                              //       DateTime.now()
                              //           .add(const Duration(days: 3))),

                              // ),
                              personalDetailsCubit.countries.isEmpty
                                  ? const ItemLoadingWidget()
                                  : CustomDropDownSearch(
                                      label: translateLang(
                                          context, 'select_country'),
                                      items: personalDetailsCubit.countries
                                          .map(
                                              (country) => country.countryName!)
                                          .toList(),
                                      selectedItem:
                                          personalDetailsCubit.countryId,
                                      onChanged: (value) => personalDetailsCubit
                                          .selectCountry(value!),
                                    ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              personalDetailsCubit.genders.isEmpty
                                  ? const ItemLoadingWidget()
                                  : CustomDropDownSearch(
                                      isSearchEnabled: false,
                                      label: translateLang(
                                          context, 'select_gender'),
                                      items: personalDetailsCubit.genders
                                          .map((gender) => gender.metaDataText!)
                                          .toList(),
                                      selectedItem:
                                          personalDetailsCubit.genderId,
                                      onChanged: (value) => personalDetailsCubit
                                          .selectGender(value!),
                                    ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              // personalDetailsCubit.religions.isEmpty
                              //     ? const ItemLoadingWidget()
                              //     : CustomDropDownSearch(
                              //         label: translateLang(
                              //             context, 'select_religion'),
                              //         items: personalDetailsCubit.religions
                              //             .map((religion) =>
                              //                 religion.religionName!)
                              //             .toList(),
                              //         selectedItem:
                              //             personalDetailsCubit.religionId,
                              //         onChanged: (value) => personalDetailsCubit
                              //             .selectReligion(value!),
                              //       ),
                              // const SizedBox(
                              //   height: 16.0,
                              // ),
                              personalDetailsCubit.maritalStatus.isEmpty
                                  ? const ItemLoadingWidget()
                                  : CustomDropDownSearch(
                                      label: translateLang(
                                          context, 'select_marital_status'),
                                      items: personalDetailsCubit.maritalStatus
                                          .map((marital) =>
                                              marital.metaDataText!)
                                          .toList(),
                                      selectedItem:
                                          personalDetailsCubit.maritalStatusId,
                                      onChanged: (value) => personalDetailsCubit
                                          .selectMaritalStatus(value!),
                                    ),
                              const SizedBox(
                                height: 16.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    state is PersonalDetailsLoadingState
                        ? const AnimatedLoadingWidget()
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: CustomElevatedButton(
                                fun: () {
                                  personalDetailsCubit
                                      .submitPersonalData(context);
                                },
                                background: AppColors.primary,
                                text: translateLang(context, 'save'))),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
    ;
  }
}
