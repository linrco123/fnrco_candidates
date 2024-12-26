import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_pages_names.dart';
import '../../../../core/classes/cache_helper.dart';
import '../../../../core/functions/translate.dart';
import 'package:permission_handler/permission_handler.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController(); 
 
  bool obscureText1 = true;
  bool obscureText2 = true;

  void toggleObscureText1() {
    obscureText1 = !obscureText1;
    emit(ProfileChangingObsecureTextState());
  }

  Icon getIcon1() {
    return Icon(
      obscureText1 ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye,
      color: AppColors.primary,
    );
  }

  void toggleObscureText2() {
    obscureText2 = !obscureText2;
    emit(ProfileChangingObsecureTextState());
  }

  Icon getIcon2() {
    return Icon(
      obscureText2 ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye,
      color: AppColors.primary,
    );
  }

  String? validateFullName(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_full_name");
    } else if (value.length < 6) {
      return translateLang(context, "msg_plz_name_should_be_more_than_6_char");
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

  String? validateAddress(context, String? value) {
     if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_email");
    }  
    return null;
  }


  String? validatePhone(context, String? value) {
    final regExp = RegExp(
      'Constance.phoneRegExp',
      caseSensitive: false,
      multiLine: false,
    );

    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_phone");
    } else if (!regExp.hasMatch(value)) {
      return translateLang(context, "msg_plz_enter_correct_phone");
    }
    return null;
  }

  String? validatePassword(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_password");
    } else if (value.length < 6) {
      return translateLang(context, "msg_plz_enter_at_least_6_char");
    }
    return null;
  }


  void getUserData() {}
   void requestPermissionforImage()async{
    final PermissionStatus result = await Permission.storage.request();
    if(result == PermissionStatus.granted){
      changeProfileImage();
    }else if(result == PermissionStatus.denied){

      print('give permission for app to accesss local storage');

    }else if(result == PermissionStatus.permanentlyDenied){
        // access settings to grant app permission 
    }
  }

  void changeProfileImage() async {
    await FilePicker.platform.clearTemporaryFiles();
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      CacheHelper.storeUserImage(result.files.first.path!);
      emit(ProfileSuccessChangeImageState());
    }
  }

  void goToEditScreen(context){
    Navigator.of(context).pushNamed(AppPagesNames.PROFILE_EDITING);
  }
}
