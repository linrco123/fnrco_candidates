import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import 'package:path_provider/path_provider.dart';
part 'resume_state.dart';

class ResumeCubit extends Cubit<ResumeState> {
  ResumeCubit() : super(ResumeInitial());
  static ResumeCubit instance(context) => BlocProvider.of(context);

  String fileName = '';
  File? pdfFile;

  void pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
      if (result != null) {
        //PlatformFile file = result.files.first;
        File file = File(result.files.first.path!);
        fileName = result.files.first.name;
        // file.identifier;
        if (await file.existsSync()) {
          logger.e('=====================File Exists ===================');
          logger.e(fileName.isEmpty);

          final Directory dirPAth = await getApplicationDocumentsDirectory();
          final String newPath =
              '${dirPAth.path}/${fileName.substring(fileName.lastIndexOf('/') + 1)}';

          file.copy(newPath);

          pdfFile = File(
              '${dirPAth.path}/${fileName.substring(fileName.lastIndexOf('/') + 1)}');

          if (await pdfFile!.exists()) {
            logger.e('=============if(await pdfFile!.exists()){======');
          }
        }
        emit(ResumePickAttachmentFileState());
      }
    } catch (e) {
      print('exception:::::::::::::::::::::::::::::::::::: $e');
    }
  }

  void removeFile() {
    pdfFile = null;
    fileName = '';
    emit(ResumePickAttachmentFileState());
  }
}
