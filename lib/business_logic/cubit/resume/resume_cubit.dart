import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'resume_state.dart';

class ResumeCubit extends Cubit<ResumeState> {
  ResumeCubit() : super(ResumeInitial());
  static ResumeCubit instance(context) => BlocProvider.of(context);

  String fileName = '';
  File? pdfFile;

  void pickFile() async {
    try{
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      PlatformFile file = result.files.first;
      pdfFile = File(file.path!);
      fileName =  file.name;
      // file.identifier;
    }
    }catch(e){
      print('exception:::::::::::::::::::::::::::::::::::: $e');
    }
  }
}
