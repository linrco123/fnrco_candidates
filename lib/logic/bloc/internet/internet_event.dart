part of 'internet_bloc.dart';

@immutable
sealed class InternetEvent {}

class CheckInternetConnectivity extends InternetEvent{}
