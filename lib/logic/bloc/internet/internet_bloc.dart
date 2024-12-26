import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../../../constants/app_pages_names.dart';
import '../../../constants/enums.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';

part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  final Connectivity _connectivity;
  final GlobalKey<NavigatorState> navKey;
  late StreamSubscription<List<ConnectivityResult>> result;
  int isFirstRun = 0;
  InternetBloc(this._connectivity, this.navKey) : super(InternetInitial()) {
    on<InternetEvent>((event, emit) async {
      print(event);
      if (event is InternetConnectedEvent) {
        if (isFirstRun == 1) {
          navKey.currentState!.pop();
          emit(InternetConnected(internetStatus: event.internetStatus));
        }
      }
      if (event is InternetNotConnectedEvent) {
        isFirstRun = 1;
        navKey.currentState!.pushNamed(AppPagesNames.INTERNET_CONNECTION);
        await Future.delayed(const Duration(seconds: 1)).then((value) {
          emit(InternetDisConnected());
        });
      }
    });

    checkInternetConnectedness();
  }

  void checkInternetConnectedness() {
    result = _connectivity.onConnectivityChanged.listen((data) {
      if (data.first == ConnectivityResult.wifi) {
        add(InternetConnectedEvent(internetStatus: InternetStatus.Wifi));
      } else if (data.first == ConnectivityResult.mobile) {
        add(InternetConnectedEvent(internetStatus: InternetStatus.Mobile));
      } else if (data.first == ConnectivityResult.none) {
        add(InternetNotConnectedEvent());
      }
    });
  }

  String? getCurrentRoute() {
    final currentRoute = navKey.currentState?.context;

    if (currentRoute != null) {
      return ModalRoute.of(currentRoute)?.settings.name;
    }
    return null;
  }

  checkConnec() async {
    var result = await Connectivity().checkConnectivity();
    logger.d(result);

    if (result == ConnectivityResult.wifi) {
      add(InternetConnectedEvent(internetStatus: InternetStatus.Wifi));
    } else if (result == ConnectivityResult.mobile) {
      add(InternetConnectedEvent(internetStatus: InternetStatus.Mobile));
    } else if (result == ConnectivityResult.none) {
      add(InternetNotConnectedEvent());
    }
  }

  void emitInternetConnected(InternetStatus internetStatus) =>
      // ignore: invalid_use_of_visible_for_testing_member
      emit(InternetConnected(internetStatus: internetStatus));

  void emitInternetDisconnected() =>
      // ignore: invalid_use_of_visible_for_testing_member
      emit(InternetDisConnected());

  @override
  Future<void> close() {
    result.cancel();
    // TODO: implement close
    return super.close();
  }
}
