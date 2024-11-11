part of 'internet_bloc.dart';

@immutable
sealed class InternetEvent {}

///class CheckInternetConnectivity extends InternetEvent{}


class InternetConnectedEvent extends InternetEvent{
  final InternetStatus internetStatus;

  InternetConnectedEvent({required this.internetStatus});
}


class InternetNotConnectedEvent extends InternetEvent{}
