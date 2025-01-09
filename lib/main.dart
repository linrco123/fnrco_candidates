import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ui/screens/internet_connection.dart';
import 'app_router.dart';
import 'constants/app_pages_names.dart';
import 'constants/app_theme.dart';
import 'core/classes/cache_helper.dart';
import 'core/classes/dio_helper.dart';
import 'core/classes/red_exception_handler.dart';
import 'core/localizations/app_localizations_setup.dart';
import 'logic/bloc/internet/internet_bloc.dart';
import 'logic/cubit/settings/settings_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  RedExceptionHandler.handleFlutterError;
  await CacheHelper.init();
  await DioHelper.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((value) {
    runApp(const FnrcoCandidates());
  });
  
}

class AppRouteObserver extends RouteObserver<PageRoute>{}

class FnrcoCandidates extends StatefulWidget {
  const FnrcoCandidates({super.key});

  @override
  State<FnrcoCandidates> createState() => _FnrcoCandidatesState();
}

class _FnrcoCandidatesState extends State<FnrcoCandidates> {
  final Connectivity _connectivity = Connectivity();
  final nav_Key = GlobalKey<NavigatorState>();
  //final  navigatorRoute = RouteObserver<PageRoute>();

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => InternetBloc(_connectivity, nav_Key),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => SettingsCubit(),
        ),
      ],
      child: Builder(builder: (context) {
        SettingsCubit settingsCubit = context.watch<SettingsCubit>();

        return MaterialApp(
          navigatorKey: nav_Key,
          navigatorObservers: [AppRouteObserver()],
          theme: appTheme,
          // darkTheme: darkAppTheme,
          // themeMode: settingsCubit.brightnessMode == DARK_MODE
          //     ? ThemeMode.dark
          //     : ThemeMode.light,
          title: 'FNRCO CANDIDATES',
          locale: Locale(CacheHelper.getLang()),
          supportedLocales: AppLocalizationsSetup.supportedLocales,
          localizationsDelegates: AppLocalizationsSetup.localizationsDelegate,
          localeResolutionCallback:
              AppLocalizationsSetup.localResolutionCallback,
          themeAnimationCurve: Curves.bounceInOut,
          debugShowCheckedModeBanner: false,
          routes: {'/internetConnect': (context) => InternetConnectionScreen()},
          onGenerateRoute: AppRouter.routeTo,
          initialRoute: AppPagesNames.ANIMATED_SPLASH,
        );
      }),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //_connectivity.call();
  }
}
