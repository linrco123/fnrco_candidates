

import 'package:flutter/material.dart';
import 'package:fnrco_candidates/core/localizations/app_localizations.dart';

String translateLang(BuildContext context , String key){
 return  AppLocalizations.of(context)!.translate(key);
}