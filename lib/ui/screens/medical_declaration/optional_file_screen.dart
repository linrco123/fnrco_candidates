import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../../../constants/app_colors.dart';
import '../../../core/classes/dotted_border.dart';
import '../../../core/functions/translate.dart';
import '../../../logic/cubit/medical_declare/medical_declare_cubit.dart';

class OptionalFileScreen extends StatelessWidget {
  const OptionalFileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: BlocBuilder<MedicalDeclareCubit, MedicalDeclareState>(
        builder: (context, state) {
          final cubit = BlocProvider.of<MedicalDeclareCubit>(context);
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  '( Optional )',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(fontSize: 30),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: Text(
                    textAlign: TextAlign.center,
                    'It\'s already up to you  , you can upload file attached with medical declaration or not',
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(color: AppColors.grey, fontSize: 16),
                  ),
                ),
                CustomPaint(
                  painter: DottedBorderPainter(),
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          enableFeedback: true,
                          maximumSize: Size(double.infinity, 70),
                          padding: const EdgeInsets.symmetric(
                              vertical: 30.0, horizontal: 15.0),
                          iconColor: AppColors.primary,
                          visualDensity: VisualDensity.compact,
                          // textStyle:TextStyle(color: AppColors.grey, fontSize: 17.0) ,
                          side: BorderSide.none),
                      onPressed: () {
                        cubit.uploadRequestFile();
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              cubit.fileName.isEmpty
                                  ? translateLang(context, "upload_attach")
                                  : cubit.fileName,
                              style: TextStyle(
                                  color: AppColors.grey, fontSize: 16.0),
                            ),
                          ),
                          const Spacer(),
                          cubit.fileName.isEmpty
                              ? Icon(
                                  Icons.upload_file_rounded,
                                  color: AppColors.primary,
                                  size: 25.0,
                                )
                              : InkWell(
                                  onTap: () {
                                    cubit.deleteRequestFile();
                                  },
                                  child: Icon(
                                    CupertinoIcons.delete_simple,
                                    color: AppColors.primary,
                                    size: 25.0,
                                  ))
                        ],
                      )),
                ),
                // if (cubit.fileName.isNotEmpty)
                //   const SizedBox(
                //     height: 1.0,
                //   ),
                if (cubit.fileName.isNotEmpty)
                  showAttachment(cubit.attachment!.path),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget showAttachment(String path) {
    if (path.contains('.pdf')) {
      return Card(
        shadowColor: AppColors.black,
        clipBehavior: Clip.antiAlias,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: SizedBox(
            height: 300.0,
            width: double.infinity,
            child: PDFView(
              filePath: path,
            )),
      );
    } else {
      return Card(
        shadowColor: AppColors.black,
        clipBehavior: Clip.antiAlias,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Image.file(
          File(path),
          // height: 300,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    }
  }
}
