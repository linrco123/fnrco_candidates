part of 'announcement_cubit.dart';

@immutable
sealed class AnnouncementState {}

final class AnnouncementInitial extends AnnouncementState {}



final class AnnouncementLoadingState extends AnnouncementState {}

final class AnnouncementSuccessState extends AnnouncementState {
  final List<Announcement> announcements;

  AnnouncementSuccessState({required this.announcements});
}

final class AnnouncementFailureState extends AnnouncementState {
  final String message;

  AnnouncementFailureState({required this.message});
}