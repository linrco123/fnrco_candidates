import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_pages_names.dart';
import 'package:fnrco_candidates/constants/enums.dart';
import 'package:meta/meta.dart';

part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  final Connectivity _connectivity;
final GlobalKey<NavigatorState> navKey;
  late StreamSubscription<List<ConnectivityResult>> result;

  InternetBloc(this._connectivity,this.navKey) : super(InternetInitial()) {
    print(
        '=======================================check Connectivity=========================');
    on<InternetEvent>((event, emit) {
      print(
          '==========================on=============check Connectivity=========================');
      print(event);
      if (event is InternetConnectedEvent) {
        emit(InternetConnected(internetStatus: event.internetStatus));
         navKey.currentState!.pushNamed(AppPagesNames.INTERNET_CONNECTION);
        print(
            'InternetConnectedEvent ===================conn============>>>>>>>>');
      } else {
        emit(InternetDisConnected());
        navKey.currentState!.pop();
        print(
            'InternetConnectedEvent ================not===============>>>>>>>>');
      }
    });

    checkInternetConnectedness();
  }

  void checkInternetConnectedness() {
    result = _connectivity.onConnectivityChanged.listen((data) {
      if (data == ConnectivityResult.wifi) {
        // emitInternetConnected(InternetStatus.Wifi);
        add(InternetConnectedEvent(internetStatus: InternetStatus.Wifi));
      } else if (data == ConnectivityResult.mobile) {
        // emitInternetConnected(InternetStatus.Mobile);
        add(InternetConnectedEvent(internetStatus: InternetStatus.Mobile));
      } else if (data == ConnectivityResult.none) {
        // emitInternetDisconnected();
        add(InternetNotConnectedEvent());
      }
    });
  }

  checkConnec() async {
    print(
        '==============================checkConnec==============================');
    var result = await Connectivity().checkConnectivity();
    print(result);

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
