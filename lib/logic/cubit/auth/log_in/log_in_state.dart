part of 'log_in_cubit.dart';

@immutable
sealed  class  LogInState {}

final   class  LogInInitialState extends LogInState {}

final class  LogInLoadingState extends LogInState{}

final class  LogInSuccessState extends LogInState{}
final class  LogInErrorState extends LogInState{
    final String message;

  LogInErrorState({required this.message});
  
}
final class  LogInChangingObsecureTextState extends LogInState{}
