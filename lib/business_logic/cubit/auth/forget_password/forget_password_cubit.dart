import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  final forgetPasswordController = TextEditingController();

  void verifyPhone(){
    emit(ForgetPasswordLoadingState());
    if(forgetPasswordController.text.isNotEmpty){
      
    }

  }
}
