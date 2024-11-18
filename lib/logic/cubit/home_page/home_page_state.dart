part of 'home_page_cubit.dart';

@immutable
sealed class HomePageState {}

final class HomePageInitial extends HomePageState {}
final class HomePageChangeState extends HomePageState {}


final class LogoutLoadingState extends HomePageState{}
final class LogoutSuccessState extends HomePageState{}
final class LogoutFailureState extends HomePageState{
  final String error;

  LogoutFailureState({required this.error});
}



