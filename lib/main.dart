import 'package:flutter/material.dart';
import 'package:fnrco_candidates/app_router.dart';
import 'package:fnrco_candidates/constants/app_pages_names.dart';
import 'package:fnrco_candidates/constants/app_theme.dart';
import 'package:fnrco_candidates/core/classes/cache_helper.dart';
import 'package:fnrco_candidates/core/localizations/app_localizations_setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  await CacheHelper.init();
  runApp(const FnrcoCandidates());
}

class FnrcoCandidates extends StatelessWidget {
  const FnrcoCandidates({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FNRCO CANDIDATES',
      locale: Locale('en'),
      supportedLocales: AppLocalizationsSetup.supportedLocales,
      localizationsDelegates: AppLocalizationsSetup.localizationsDelegate,
      localeResolutionCallback: AppLocalizationsSetup.localResolutionCallback,
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.routeTo,
      initialRoute: AppPagesNames.INITIAL,
    );
  }
}
