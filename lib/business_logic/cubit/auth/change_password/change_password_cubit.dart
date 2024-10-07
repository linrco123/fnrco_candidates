import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());

   final PasswordController = TextEditingController();
   final ConfirmPasswordController = TextEditingController();


     void changePassword(){
    emit(ChangePasswordLoadingState());
    // if(c.text.isNotEmpty){
      
    // }

  }

}
