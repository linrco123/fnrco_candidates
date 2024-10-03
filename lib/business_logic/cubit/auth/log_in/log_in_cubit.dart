import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/data/repositories/auth/log_in.dart';
import 'package:meta/meta.dart';

import '../../../../constants/app_pages_names.dart';

part 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  final LogInRepository logInRepository;
  LogInCubit({required this.logInRepository}) : super(LogInInitialState());
 static LogInCubit instance(context)=> BlocProvider.of(context);
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();


void logIn(context){
  if (formKey.currentState!.validate()) {
    formKey.currentState!.save();
    // Navigate to the main screen
    logInRepository.logInWebServices.postLogIn('').then((value){
      
    });
    Navigator.of(context).pushReplacementNamed(AppPagesNames.HOMEPAGE);
  }
}









}
