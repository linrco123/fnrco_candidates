// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:fnrco_candidates/constants/enums.dart';
import 'package:fnrco_candidates/data/models/job_contract_model.dart';
import 'package:fnrco_candidates/data/models/joining_date_model.dart';
import 'package:fnrco_candidates/data/models/notifications.dart';
import 'package:fnrco_candidates/data/models/visa_approval_model.dart';
import 'package:meta/meta.dart';

import 'package:fnrco_candidates/data/api_provider/notifications.dart';
import 'package:fnrco_candidates/data/models/job_offer_model.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsProvider notificationsProvider;
  NotificationsCubit(
    this.notificationsProvider,
  ) : super(NotificationsInitial());
   int notDoneItems = 0;
  var notifications = List<NotificationModel>.empty(growable: true);

  int countAllStagesUnDoneItems() {
    
    for (JobApplication app in jobApplications) {
      if (app.isAction!.toLowerCase() == 'not done') {
        notDoneItems++;
        notifications.add(NotificationModel(
            title: app.position!,
            body: app.approvals!.candidate!.remarks.toString(),
            screenCode: ScreenCode.Offer));
      }
    }

    for (ContractApplication app in ContractApplications) {
      if (app.isAction!.toLowerCase() == 'not done') {
        notDoneItems++;
        notifications.add(NotificationModel(
            title: app.position!,
            body: app.approvals!.candidate!.remarks.toString(),
            screenCode: ScreenCode.Contract));
      }
    }

    for (VisaApprovalApplication app in visaApplications) {
      if (app.isAction!.toLowerCase() == 'not done') {
        notDoneItems++;
        notifications.add(NotificationModel(
            title: app.position!,
            body: app.approvals!.candidate!.remarks.toString(),
            screenCode: ScreenCode.Visa));
      }
    }

    for (JoiningDateApplication app in joiningDateApplications) {
      if (app.isAction!.toLowerCase() == 'not done') {
        notDoneItems++;
        notifications.add(NotificationModel(
            title: app.position!,
            body: app.approvals!.candidate!.remarks.toString(),
            screenCode: ScreenCode.joinDate));
      }
    }
    return notDoneItems;

  }
   void moveToClickedScreen(ScreenCode screenCode){
    if(screenCode == ScreenCode.Offer){
      
      emit(JobOfferTransitionState());

    }else if(screenCode == ScreenCode.Contract){

       emit(JobContractTransitionState());
      
    }else if(screenCode == ScreenCode.Visa){

       emit(VisaApprovalTransitionState());
      
    }else if(screenCode == ScreenCode.joinDate){

       emit(JoiningDateTransitionState());
      
    }

   }
  final jobApplications = List<JobApplication>.empty(growable: true);

  getJobApplications() {
    // emit(GetJobOfferApplicationsLoadingState());
    notificationsProvider.getJobApplications().then((value) {
      jobApplications.addAll(value.applications!);
      // emit(GetJobOfferApplicationsSuccessState(
      //     applications: value.applications!));
    }).catchError((error) {
      // emit(GetJobOfferApplicationsFailureState(message: error.failure.message));
    });
  }

  var ContractApplications = List<ContractApplication>.empty(growable: true);

  getContractApplications() {
    // emit(GetJobContractApplicationsLoadingState());
    notificationsProvider.getContractApplications().then((value) {
      ContractApplications.addAll(value.applications!);
      // emit(GetJobContractApplicationsSuccessState(
      //     applications: value.applications!));
    }).catchError((error) {
      // emit(GetJobContractApplicationsFailureState(
      //     message: error.failure.message));
    });
  }

  final joiningDateApplications =
      List<JoiningDateApplication>.empty(growable: true);
  getJoiningDateInfo() {
    // emit(GetJoiningDateLoadingState());
    notificationsProvider.getJoiningDate().then((value) {
      joiningDateApplications.addAll(value.dateApplications!);
      // emit(GetJoiningDateSuccessState(applications: value.dateApplications!));
    }).catchError((error) {
      //  emit(GetJoiningDateFailureState(error.failure.message));
    });
  }

  final visaApplications = List<VisaApprovalApplication>.empty(growable: true);
  getVisadata() {
    // emit(GetVisaApprovalDataLoadingState());
    notificationsProvider.getVisadata().then((value) {
      visaApplications.clear();
      visaApplications.addAll(value.visaApplications!);
      // emit(GetVisaApprovalDataSuccessState(
      //     applications: value.visaApplications!));
    }).catchError((error) {
      //  emit(GetVisaApprovalDataFailureState(message: error.failure.message));
    });
  }
}
