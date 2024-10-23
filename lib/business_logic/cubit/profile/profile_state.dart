part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}


final class ProfileLoadingGettingDataState extends ProfileState {}
final class ProfileSuccessGettingDataState extends ProfileState {}
final class ProfileFailureGettingDataState extends ProfileState {}





final class ProfileLoadingChangeImageState extends ProfileState {}
final class ProfileSuccessChangeImageState extends ProfileState {}
final class ProfileFailureChangeImageState extends ProfileState {}


final class ProfileChangingObsecureTextState extends ProfileState{}