part of 'notifications_cubit.dart';

@immutable
sealed class NotificationsState {}

final class NotificationsInitial extends NotificationsState {}

final class JobOfferTransitionState extends NotificationsState {}


final class JobContractTransitionState extends NotificationsState {}

final class VisaApprovalTransitionState extends NotificationsState {}

final class JoiningDateTransitionState extends NotificationsState {}


