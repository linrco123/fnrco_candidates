import 'package:flutter/material.dart';
import 'package:fnrco_candidates/core/localizations/app_localizations.dart';

class AppLocalizationsDelegate  extends LocalizationsDelegate<AppLocalizations>{
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en' , 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
   AppLocalizations appLocalizations =  AppLocalizations(locale: locale);
   await appLocalizations.load();
   return appLocalizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) => false;
}