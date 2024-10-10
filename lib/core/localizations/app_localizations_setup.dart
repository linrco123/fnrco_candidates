import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fnrco_candidates/core/localizations/app_localizations.dart';

class AppLocalizationsSetup {
  static const Iterable<Locale> supportedLocales = [
    Locale('en'),
    Locale('ar')
  ];
  
   static  Iterable<LocalizationsDelegate<dynamic>> localizationsDelegate = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetLocalization.delegate,
  ];

  static Locale localResolutionCallback(Locale locale , Iterable<Locale> supportedLocales){
    for(Locale supportedLocale in supportedLocales){
      if(supportedLocale.languageCode == locale.languageCode && supportedLocale.countryCode == locale.countryCode){
        return supportedLocale;
      }
    }
    return supportedLocales.first;
  }

}