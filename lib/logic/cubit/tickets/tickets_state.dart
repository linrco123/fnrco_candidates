part of 'tickets_cubit.dart';

@immutable
sealed class TicketsState {}

final class TicketsInitial extends TicketsState {}


class TicketUploadFileState extends TicketsState{}


class TicketDeletionFileState extends TicketsState{}


class SubmitTicketLoadingState extends TicketsState{}


class SubmitTicketSuccessState extends TicketsState{}

class SubmitTicketFailureState extends TicketsState{
  final String message;

  SubmitTicketFailureState({required this.message});
}
class emptyAttachmentAndRemarksState extends TicketsState{}


class TicketUIWidgetLoadingState extends    TicketsState{}  

class TicketUIWidgetSuccessState extends    TicketsState{}  

class TicketUIWidgetFailureState extends    TicketsState{
  final String message;

  TicketUIWidgetFailureState({required this.message});
  
}  