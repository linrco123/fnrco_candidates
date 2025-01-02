part of 'local_process_cubit.dart';

@immutable
sealed class LocalProcessState {}

final class LocalProcessInitial extends LocalProcessState {}


final class GetLocalProcessDataLoadingState extends LocalProcessState {}        

 class GetLocalProcessDataSuccessState extends LocalProcessState {
  final List<String> data;

  GetLocalProcessDataSuccessState({required this.data});
}        

final class GetLocalProcessDataFailureState extends LocalProcessState {
  final String message;

  GetLocalProcessDataFailureState({required this.message});
}        