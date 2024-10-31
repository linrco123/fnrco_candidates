part of 'internet_bloc.dart';

@immutable
sealed class InternetState {}

final class InternetInitial extends InternetState {}

class InternetConnected extends InternetState {
  final InternetStatus internetStatus;

  InternetConnected({required this.internetStatus});
}

class InternetDisConnected extends InternetState {}
