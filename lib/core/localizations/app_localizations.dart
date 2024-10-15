import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fnrco_candidates/core/localizations/app_localizations_delegate.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations({required this.locale});
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = AppLocalizationsDelegate();
  Map<String, String> _localizedStrings = {};

  Future<void> load() async {
    String jsonString =
        await rootBundle.loadString("lang/${locale.languageCode}.json");
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings =
        jsonMap.map<String, String>((key, value) => MapEntry(key, value));
  }

  String translate(String key) => _localizedStrings[key] ?? " ";
  bool get isEnLocale => locale.languageCode == 'en';
}
