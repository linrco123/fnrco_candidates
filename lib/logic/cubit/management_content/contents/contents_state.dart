part of 'contents_cubit.dart';
@immutable
sealed class ContentsState {}

final class ContentsInitial extends ContentsState {}


final class ContentsLoadingState extends ContentsState {}

final class ContentsSuccessState extends ContentsState {
  final List<ContentData> contents;

  ContentsSuccessState({required this.contents});
}

final class ContentsFailureState extends ContentsState {
  final String message;

  ContentsFailureState({required this.message});
}