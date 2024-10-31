import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/app_router.dart';
import 'package:fnrco_candidates/constants/app_pages_names.dart';
import 'package:fnrco_candidates/constants/app_theme.dart';
import 'package:fnrco_candidates/core/classes/cache_helper.dart';
import 'package:fnrco_candidates/core/localizations/app_localizations_setup.dart';
import 'package:fnrco_candidates/logic/bloc/internet/internet_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  print('===================================platform=====================================');
  print("paltform localname"+Platform.localeName);
  print(WidgetsBinding.instance.window.locales);
  await CacheHelper.init();
  runApp(const FnrcoCandidates());
}

class FnrcoCandidates extends StatefulWidget {
  const FnrcoCandidates({super.key});

  @override
  State<FnrcoCandidates> createState() => _FnrcoCandidatesState();
}

class _FnrcoCandidatesState extends State<FnrcoCandidates> {
  final Connectivity _connectivity = Connectivity();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetBloc>(
          create: (context) =>
              InternetBloc(_connectivity)..add(CheckInternetConnectivity()),
        )
      ],
      child: MaterialApp(
        title: 'FNRCO CANDIDATES',
        locale: Locale('ar'),
        supportedLocales: AppLocalizationsSetup.supportedLocales,
        localizationsDelegates: AppLocalizationsSetup.localizationsDelegate,
        localeResolutionCallback: AppLocalizationsSetup.localResolutionCallback,
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.routeTo,
        initialRoute: AppPagesNames.INITIAL,
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //_connectivity.call();
  }
}
