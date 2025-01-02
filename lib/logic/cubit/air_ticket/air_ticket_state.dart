part of 'air_ticket_cubit.dart';

@immutable
sealed class AirTicketState {}

final class AirTicketInitial extends AirTicketState {}

class GetAirTicketInfoLoadingState extends AirTicketState{}


class GetAirTicketInfoSuccessState extends AirTicketState{
  final List<AirTicketApplication> applications;

  GetAirTicketInfoSuccessState({required this.applications});
}



class GetAirTicketInfoFailureState extends AirTicketState{
  final String message;

  GetAirTicketInfoFailureState({required this.message});
}


class DeparturePickingUpDateState extends AirTicketState{}
class ArrivalPickingUpDateState extends AirTicketState{}
class DeparturePickingUpTimeState extends AirTicketState{}
class ArrivalTimingPickingUpTimeState extends AirTicketState{}
class ArrivalAtTimingPickingUpTimeState extends AirTicketState{}


class PickUpDepartureDateState extends AirTicketState{}
class PickUpArrivalDateState extends AirTicketState{}
class PickUpArrivalTimeState extends AirTicketState{}
class PickUpDepartureTimeState extends AirTicketState{}
class PickUpArrivalAtState extends AirTicketState{}


class submitAirTicketInfoLoadingState extends AirTicketState{}
class submitAirTicketInfoSuccesState extends AirTicketState{

}
class submitAirTicketInfoFailureState extends AirTicketState{
  final String? message;

  submitAirTicketInfoFailureState({required this.message});
}


class AirTicketUploadAttachmentState extends AirTicketState{}
class AirTicketDeleteAttachmentState extends AirTicketState{}


class PickUpTicketUpAttachmentState extends AirTicketState{}