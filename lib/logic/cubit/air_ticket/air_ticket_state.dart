part of 'air_ticket_cubit.dart';

@immutable
sealed  class  AirTicketState {}

 final class  AirTicketInitial extends AirTicketState {}

 final class  GetAirTicketInfoLoadingState extends AirTicketState{}


 final class  GetAirTicketInfoSuccessState extends AirTicketState{
  final List<AirTicketApplication> applications;

  GetAirTicketInfoSuccessState({required this.applications});
}



final class  GetAirTicketInfoFailureState extends AirTicketState{
  final String message;

  GetAirTicketInfoFailureState({required this.message});
}


final class   DeparturePickingUpDateState extends AirTicketState{}
final class  ArrivalPickingUpDateState extends AirTicketState{}
final class  DeparturePickingUpTimeState extends AirTicketState{}
final class  ArrivalTimingPickingUpTimeState extends AirTicketState{}
final class  ArrivalAtTimingPickingUpTimeState extends AirTicketState{}


final class  PickUpDepartureDateState extends AirTicketState{}
final class  PickUpArrivalDateState extends AirTicketState{}
final class  PickUpArrivalTimeState extends AirTicketState{}
final class  PickUpDepartureTimeState extends AirTicketState{}
final class  PickUpArrivalAtState extends AirTicketState{}


final class  submitAirTicketInfoLoadingState extends AirTicketState{}
final class  submitAirTicketInfoSuccesState extends AirTicketState{

}
final class  submitAirTicketInfoFailureState extends AirTicketState{
  final String message;

  submitAirTicketInfoFailureState({required this.message});
}


final class  AirTicketUploadAttachmentState extends AirTicketState{}
final class  AirTicketDeleteAttachmentState extends AirTicketState{}


final class  PickUpTicketUpAttachmentState extends AirTicketState{}

