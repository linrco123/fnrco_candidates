part of 'tickets_cubit.dart';

@immutable
sealed   class  TicketsState {}

final   class  TicketsInitial extends TicketsState {}


final class  TicketUploadFileState extends TicketsState{}


final class  TicketDeletionFileState extends TicketsState{}


final class  SubmitTicketLoadingState extends TicketsState{}


final class  SubmitTicketSuccessState extends TicketsState{}

final class  SubmitTicketFailureState extends TicketsState{
  final String message;

  SubmitTicketFailureState({required this.message});
}
final class  emptyAttachmentAndRemarksState extends TicketsState{}


final class  TicketUIWidgetLoadingState extends    TicketsState{}  

final class  TicketUIWidgetSuccessState extends    TicketsState{}  

final class  TicketUIWidgetFailureState extends    TicketsState{
  final String message;

  TicketUIWidgetFailureState({required this.message});
  
}  