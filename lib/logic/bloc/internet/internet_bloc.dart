import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/enums.dart';
import 'package:meta/meta.dart';

part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  final Connectivity _connectivity;
  late StreamSubscription<List<ConnectivityResult>> result;
  
  InternetBloc(this._connectivity) : super(InternetInitial()) {
    on<InternetEvent>((event, emit) {
      checkInternetConnectedness();
    });
  }

  void checkInternetConnectedness() {
    result = Connectivity().onConnectivityChanged.listen((data) {
      if (data == ConnectivityResult.wifi) {
        emitInternetConnected(InternetStatus.Wifi);
      } else if (data == ConnectivityResult.mobile) {
        emitInternetConnected(InternetStatus.Mobile);
      } else if (data == ConnectivityResult.none) {
        emitInternetDisconnected();
      }
    });
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
