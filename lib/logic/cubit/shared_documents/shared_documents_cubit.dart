// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:fnrco_candidates/core/classes/dio_helper.dart';
import 'package:fnrco_candidates/data/models/job_offer_model.dart';
import 'package:fnrco_candidates/data/models/shared_documents.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fnrco_candidates/data/api_provider/shared_documents.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';

part 'shared_documents_state.dart';

class SharedDocumentsCubit extends Cubit<SharedDocumentsState> {
  SharedDocumentsProvider sharedDocumentsProvider;
  SharedDocumentsCubit(
    this.sharedDocumentsProvider,
  ) : super(SharedDocumentsInitial());

  final jobApplications = List<JobApplication>.empty(growable: true);
  getJobApplications() {
    emit(GetJobApplicationsLoadingState());
    sharedDocumentsProvider.getJobApplications().then((value) {
      jobApplications.addAll(value.applications!);
      emit(GetJobApplicationsSuccessState(applications: value.applications!));
    }).catchError((error) {
      emit(GetJobApplicationsFailureState(message: error.failure.message));
    });
  }

  // var sharedDocsApps = List<SharedDocsApplication>.empty(growable: true);

  // void getDocsApps() {
  //   emit(SharedDocumentsGetAppsLoadingState());
  //   sharedDocumentsProvider.getDocsApps().then((value) {
  //     emit(SharedDocumentsGetAppsSuccessState(applications: value.));
  //   }).catchError((error) {
  //     emit(SharedDocumentsGetAppsfailureState(message: error.failure.message));
  //   });
  // }

  var sharedAppDocs = List<SharedDocument>.empty(growable: true);

  void getAppDocs(int candidateAppId) {
    emit(SharedDocumentsGetDetailsLoadingState());
    sharedAppDocs.clear();
    sharedDocumentsProvider.getAppDocs(candidateAppId).then((value) {
      sharedAppDocs.addAll(value.sharedDocuments!);
      emit(SharedDocumentsGetDetailsSuccessState(
          sharedDocuments: value.sharedDocuments!));
    }).catchError((error) {
      emit(SharedDocumentsGetDetailsfailureState(
          message: error.failure.message));
    });
  }

  int chosenDocument = 1000;
  void chooseDocument(int index) {
    chosenDocument = index;
    emit(ChooseDocumentState());
  }

  void downloadSharedDocument(String path) async {
    try {
      emit(SharedDocumentDownloadLoadingState());

      final String filename = path.split('/').last;
      final Directory? dirPath;
      if (Platform.isIOS) {
        dirPath = await getDownloadsDirectory();
      } else {
        dirPath = await getTemporaryDirectory();
      }

      if (await dirPath!.exists()) {
        final newPath = '${dirPath.path}/$filename';
        DioHelper.dio.download(path, newPath).then((value) {
          logger.e('=================response-=================');
          logger.e(value.statusCode);
          logger.e(value.statusMessage);
          emit(SharedDocumentDownloadSuccessState());
        }).catchError((error) {
          emit(SharedDocumentDownloadFailureState(message: error.toString()));
        });
      }
    } catch (error) {
      emit(SharedDocumentDownloadFailureState(message: error.toString()));
    }
  }
}
