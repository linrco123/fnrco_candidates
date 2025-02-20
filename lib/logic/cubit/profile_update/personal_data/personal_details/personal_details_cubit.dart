import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio2/dio2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../../../../data/models/profile_get/personal_data_model.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import '../../../../../core/classes/cache_helper.dart';
import '../../../../../core/functions/show_toast.dart';
import '../../../../../core/functions/translate.dart';
import '../../../../../data/api_provider/profile_update/personal_details.dart';
import '../../../../../data/models/auth/sign_up/countries_model.dart';
import '../../../../../data/models/auth/sign_up/gender_model.dart';
import '../../../../../data/models/auth/sign_up/marital_status_model.dart';
import '../../../../../data/models/auth/sign_up/positions_model.dart';
import '../../../../../data/models/auth/sign_up/religion_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toastification/toastification.dart';
import 'package:path_provider/path_provider.dart';
part 'personal_details_state.dart';

class PersonalDetailsCubit extends Cubit<PersonalDetailsState> {
  PersonalDetailsProvider personalDetailsProvider;
  PersonalDetailsCubit({required this.personalDetailsProvider})
      : super(PersonalDetailsInitial());

  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final surNameController = TextEditingController();
  final emailController = TextEditingController();

  String countryId = 'Country';
  String residence = 'Residence';
  int Id = 0;
  String genderId = 'Gender';
  String religionId = 'Religion';
  String maritalStatusId = 'Marital Status';
  String? birthDate;

  void selectDateOfBirth(context) async {
    DateTime? birthofDate = await showDatePicker(
        initialEntryMode: DatePickerEntryMode.calendar,
        context: context,
        firstDate: DateTime(1950),
        lastDate: DateTime.now());
    birthDate =
        "${birthofDate!.year.toString()}-${birthofDate.month.toString().padLeft(2, '0')}-${birthofDate.day.toString().padLeft(2, '0')}";
    emit(PersonalDetailsPickingUpDate());
  }

  void selectCountry(String value) {
    countryId = value;

    emit(PersonalDetailsChoosingCountryState());
  }

  void selectResidence(String value) {
    residence = value;

    emit(PersonalDetailsChoosingCountryState());
  }

  void selectGender(String value) {
    genderId = value;

    emit(PersonalDetailsChoosingGenderState());
  }

  void selectReligion(String value) {
    religionId = value;

    emit(PersonalDetailsChoosingReligionState());
  }

  void selectMaritalStatus(String value) {
    maritalStatusId = value;

    emit(PersonalDetailsChoosingReligionState());
  }

  String? validateFirstName(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_first_name");
    }
    return null;
  }

  String? validateSecondName(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_second_name");
    }
    return null;
  }

  String? validateLastName(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_last_name");
    }
    return null;
  }

  String? validateEmail(context, String? value) {
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_email");
    } else if (!regex.hasMatch(value)) {
      return translateLang(context, "msg_plz_enter_correct_email");
    }
    return null;
  }

  String? validateResidence(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_residence");
    }
    return null;
  }

  String? validateSurName(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_surname");
    }
    return null;
  }

  void requestPermissionforImage() async {
    final PermissionStatus result = await Permission.storage.request();
    if (result == PermissionStatus.granted) {
      changeProfileImage();
    } else if (result == PermissionStatus.denied) {
      print('give permission for app to accesss local storage');
    } else if (result == PermissionStatus.permanentlyDenied) {
      // access settings to grant app permission
    }
  }

  File? fileImage;

  void changeProfileImage() async {
    await FilePicker.platform.clearTemporaryFiles();
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      fileImage = File(result.files.first.path!);
      //await createImageFile(fileImage!.path);
      CacheHelper.storeUserImage(result.files.first.path!);
      emit(PersonalDetailsSuccessChangeImageState());
    }
  }

  String fileName = '';
  File? pdfFile;

  void pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
      if (result != null) {
        //PlatformFile file = result.files.first;
        File file = File(result.files.first.path!);
        fileName = result.files.first.name;
        // file.identifier;
        if (await file.existsSync()) {
          logger.e('=====================File Exists ===================');
          logger.e(fileName.isEmpty);

          final Directory dirPAth = await getApplicationDocumentsDirectory();
          final String newPath =
              '${dirPAth.path}/${fileName.substring(fileName.lastIndexOf('/') + 1)}';

          file.copy(newPath);

          pdfFile = File(
              '${dirPAth.path}/${fileName.substring(fileName.lastIndexOf('/') + 1)}');
        }
        emit(ResumePickAttachmentFileState());
      }
    } catch (e) {
      print('exception :::::::::::::::::::::::::::::::::::: $e');
    }
  }

  void removeFile() {
    pdfFile = null;
    fileName = '';
    emit(ResumePickAttachmentFileState());
  }

  Future<void> submitPersonalData(context) async {
    try {
      if (countryId == 'Country') {
        showToast(context,
            title: translateLang(context, 'warning'),
            desc: translateLang(context, "choose_nationality"),
            type: ToastificationType.warning);
      } else if (residence == 'Residence') {
        showToast(context,
            title: translateLang(context, 'warning'),
            desc: translateLang(context, "choose_residence"),
            type: ToastificationType.warning);
      } else if (genderId == 'Gender') {
        showToast(context,
            title: translateLang(context, 'warning'),
            desc: translateLang(context, "choose_gender"),
            type: ToastificationType.warning);
      }
      // else if (religionId == 'Religion') {
      //   showToast(context,
      //       title: translateLang(context, 'warning'),
      //       desc: translateLang(context, "choose_religion"),
      //       type: ToastificationType.warning);
      // }
      else if (maritalStatusId == 'Marital Status') {
        showToast(context,
            title: translateLang(context, 'warning'),
            desc: translateLang(context, "choose_marital"),
            type: ToastificationType.warning);
      }
      //  else if (fileImage == null) {
      //   showToast(context,
      //       title: translateLang(context, 'warning'),
      //       desc: translateLang(context, "choose_image"),
      //       type: ToastificationType.warning);
      // }
      else {
        if (formKey.currentState!.validate()) {
          emit(PersonalDetailsLoadingState());
          FormData formData = FormData.fromMap({
            "person_nationality": countries
                .where((country) => country.countryName == countryId)
                .toList()
                .first
                .id,
            "person_sur_name": surNameController.text,
            "person_first_name": firstNameController.text,
            "person_second_name": secondNameController.text,
            "person_third_name": lastNameController.text,
            "person_gender": genderId,
            "person_martial_status": maritalStatusId,
            "person_country_residence": countries
                .where((country) => country.countryName == residence)
                .toList()
                .first
                .id,
            "person_height": "150",
            "person_height_unit": "meter",
            "person_weight": "100",
            "person_weight_unit": "kg",
            "email": emailController.text,
            "references": "references",
            "person_dob": birthDate,
            //"_method": "PUT"
          });

          //logger.e(await pdfFile!.exists());

          //Add person image to form data
          if (fileImage != null && await fileImage!.exists()) {
            formData.files.add(MapEntry(
                "person_image",
                await MultipartFile.fromFile(fileImage!.path,
                    filename: fileImage!.path.split('/').last)));
          }

          // Add person cv  to form data
          if (pdfFile != null && await pdfFile!.exists()) {
            formData.files.add(MapEntry(
                "person_original_cv",
                await MultipartFile.fromFile(pdfFile!.path,
                    filename: pdfFile!.path.split('/').last)));
          }

          logger.e('=============== personal Data =====================');
          personalDetailsProvider.submitPersonalData(formData).then((value) {
            emit(PersonalDetailsSuccessState());
          }).catchError((error) {
            emit(PersonalDetailsErrorState(message: error.failure.message));
          });
        }
      }
    } catch (e) {
      logger.e('===========================Error====================');
      logger.e(e);
    }
  }

  getPersonalData() {
    emit(GetPersonalDataLoadingState());
    personalDetailsProvider.getPersonalData().then((value) {
      fillPersonalData(value.personalData!.first);
      emit(GetPersonalDataSuccessState());
    }).catchError((error) {
      emit(GetPersonalDataErrorState());
    });
  }

  void fillPersonalData(GetPData data) {
    firstNameController.text = data.personFirstName!;
    secondNameController.text = data.personSecondName!;
    lastNameController.text = data.personThirdName!;
    surNameController.text = data.personSurName!;
    emailController.text = data.email!.email!;
    residence = data.personCountryResidency!;
    birthDate = data.personDob!;
    countryId = data.personNationality!;
    genderId = data.personGender!.isEmpty ? 'Gender' : data.personGender!;
    maritalStatusId = data.personMartialStatus!.isEmpty
        ? 'Marital Status'
        : data.personMartialStatus!;
  }

  var countries = List<Country>.empty(growable: true);
  void getCountries() {
    emit(PersonalDetailsGettingCountriesLoadingState());
    countries.clear();
    personalDetailsProvider.getCountries().then((value) {
      for (var country in value.data as List) countries.add(country);
      emit(PersonalDetailsGettingCountriesSuccessState(countries: countries));
    }).catchError((error) {
      emit(PersonalDetailsGettingCountriesFailureState());
    });
  }

  var positions = List<Position>.empty(growable: true);
  void getPositions() {
    emit(PersonalDetailsGettingPositionsLoadingState());
    positions.clear();
    personalDetailsProvider.getPositions().then((value) {
      for (var position in value.positions as List) positions.add(position);
      print(
          '=========================positions===============================');
      print(positions.length);
      emit(PersonalDetailsGettingPositionsSuccessState(countries: positions));
    }).catchError((error) {
      emit(PersonalDetailsGettingPositionsFailureState());
    });
  }

  var genders = List<Gender>.empty(growable: true);
  void getGenders() {
    emit(PersonalDetailsGettingGenderLoadingState());
    genders.clear();
    personalDetailsProvider.getGenders().then((value) {
      for (var gender in value.genders as List) genders.add(gender);
      emit(PersonalDetailsGettingGenderSuccessState());
    }).catchError((error) {
      emit(PersonalDetailsGettingGenderFailureState());
    });
  }

  var religions = List<Religion>.empty(growable: true);
  void getReligions() {
    emit(PersonalDetailsGettingReligionLoadingState());
    religions.clear();
    personalDetailsProvider.getReligions().then((value) {
      for (var religion in value.data as List) religions.add(religion);
      emit(PersonalDetailsGettingReligionsSuccessState());
    }).catchError((error) {
      emit(PersonalDetailsGettingReligionFailureState());
    });
  }

  var maritalStatus = List<MaritalStatus>.empty(growable: true);
  void getMaritalStatus() {
    emit(PersonalDetailsGettingMaritalStatusLoadingState());
    maritalStatus.clear();
    personalDetailsProvider.getMaritalStatus().then((value) {
      for (var marital in value.data as List) maritalStatus.add(marital);
      emit(PersonalDetailsGettingMaritalStatusSuccessState());
    }).catchError((error) {
      emit(PersonalDetailsGettingMaritalStatusFailureState());
    });
  }

  @override
  Future<void> close() {
    // firstNameController.dispose();
    // firstNameController.dispose();
    // secondNameController.dispose();
    // lastNameController.dispose();
    // surNameController.dispose();
    // emailController.dispose();
    // TODO: implement close
    return super.close();
  }
}
