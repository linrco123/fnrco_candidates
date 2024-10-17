import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
part 'job_offer_state.dart';

class JobOfferCubit extends Cubit<JobOfferState> {
  JobOfferCubit() : super(JobOfferInitial());

  Future<void> convertPdfData(String url) async {
    emit(GeneratingPDFLoadingState());
    Completer<File> completer = Completer();
     try {
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      await file.writeAsBytes(bytes, flush: true);
      emit(GeneratingPDFSuccessState(pdf: file));
      completer.complete(file);
    } catch (e) {
      emit(GeneratingPDFErrorState(message: e.toString()));
    }
  }
}
