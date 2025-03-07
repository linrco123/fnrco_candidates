import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app_localizations.dart';

class AppLocalizationsSetup {
  static const Iterable<Locale> supportedLocales = [
    Locale('en'),
    Locale('ar')
  ];
  
   static  Iterable<LocalizationsDelegate<dynamic>> localizationsDelegate = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate
  ];

  static Locale localResolutionCallback(Locale? locale , Iterable<Locale> supportedLocales){
    for(Locale supportedLocale in supportedLocales){
      if(supportedLocale.languageCode == locale!.languageCode && supportedLocale.countryCode == locale.countryCode){
        return supportedLocale;
      }
    }
    return supportedLocales.first;
  }

}