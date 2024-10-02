part of 'log_in_cubit.dart';

@immutable
sealed class LogInState {}

final class LogInInitialState extends LogInState {}

class LogInLoadingState extends LogInState{}

class LogInSuccessState extends LogInState{}
class LogInErrorState extends LogInState{}
