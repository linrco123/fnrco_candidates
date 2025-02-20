import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(ChangeLocaleState(locale: const Locale('en')));

  toArabic() => emit(ChangeLocaleState(locale: const Locale('ar')));
  toEnglish() => emit(ChangeLocaleState(locale: const Locale('en')));
  void setLocale(){

  }
  void getCachedLocale(){

  }
}
