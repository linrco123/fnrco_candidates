// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/functions/show_snackbar.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';

import 'package:fnrco_candidates/data/models/shared_documents.dart';
import 'package:fnrco_candidates/logic/cubit/shared_documents/shared_documents_cubit.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/return_btn.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ShowDocumentScreen extends StatelessWidget {
  final SharedDocument sharedDocument;
  const ShowDocumentScreen({
    Key? key,
    required this.sharedDocument,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text(
            translateLang(context, 'document'),
            style: TextStyle(
                color: AppColors.primary, fontWeight: FontWeight.bold),
          ),
          leading: ReturnButton(
            color: AppColors.primary,
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        backgroundColor: AppColors.white,
        body: BlocConsumer<SharedDocumentsCubit, SharedDocumentsState>(
          listener: (context, state) {
            if (state is SharedDocumentDownloadLoadingState) {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        contentPadding: const EdgeInsets.all(30),
                        backgroundColor: AppColors.black,
                        content: Row(
                          children: [
                            CircularProgressIndicator(
                              color: AppColors.white,
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              ' Loading.....',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(color: AppColors.white),
                            ),
                          ],
                        ),
                      ));
            }
            if (state is SharedDocumentDownloadSuccessState) {
              Navigator.of(context).pop();

              // showToast(context,
              //     title: translateLang(context, 'success'),
              //     desc: 'Request File downloaded successfully',
              //     type: ToastificationType.success);
              showSuccessSnackBar(context,
                  text: 'Shared Document downloaded successfully');
            }
            if (state is SharedDocumentDownloadFailureState) {
              Navigator.of(context).pop();
              // showToast(context,
              //     title: translateLang(context, 'error'),
              //     desc: state.message,
              //     type: ToastificationType.error);
              showSuccessSnackBar(context, text: state.message);
            }
          },
          builder: (context, state) {
            return Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 10.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: showDocument(sharedDocument.filePath!),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomElevatedButton(
                          fun: () {
                            context
                                .read<SharedDocumentsCubit>()
                                .downloadSharedDocument(
                                    sharedDocument.filePath!);
                          },
                          background: AppColors.primary,
                          text: translateLang(context, "download_doc")),
                    )
                  ],
                ));
          },
        ));
  }

  Widget showDocument(String path) {
    if (path.contains('.pdf')) {
      return SizedBox(
          //height:value* 300.0,
          width: double.infinity,
          child: SfPdfViewer.network(
            path,
          ));
    } else {
      return CachedNetworkImage(
        // height: 300.0,
        width: double.infinity,
        fit: BoxFit.cover,
        imageUrl: path,
        progressIndicatorBuilder: (context, url, progress) =>
            AnimatedLoadingWidget(),
        errorWidget: (context, url, error) => Icon(
          Icons.error,
          color: AppColors.primary,
          size: 25.0,
        ),
      );
    }
  }
}
