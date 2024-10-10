import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(ChangeLocaleState(locale: Locale('en')));

  toArabic() => emit(ChangeLocaleState(locale: Locale('ar')));
  toEnglish() => emit(ChangeLocaleState(locale: Locale('en')));
  void setLocale(){

  }
  void getCachedLocale(){

  }
}
