// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'overview_cubit.dart';

@immutable
sealed class OverviewState {}

final class OverviewInitial extends OverviewState {}


class GetOverviewDataLoadingState extends OverviewState{}

class GetOverviewDataSuccessState extends OverviewState {
  final OverviewData overviewData;
  GetOverviewDataSuccessState({
    required this.overviewData,
  });
}

class GetOverviewDataFailureState extends OverviewState{
  final String message;

  GetOverviewDataFailureState({required this.message});
}
