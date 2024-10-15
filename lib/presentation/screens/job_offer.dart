import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:fnrco_candidates/business_logic/cubit/job_offer/job_offer_cubit.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class JobOfferScreen extends StatelessWidget {
  JobOfferScreen({super.key});
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
          onPressed: () {
            _pdfViewerKey.currentState?.openBookmarkView();
          },
          icon: Icon(Icons.view_agenda_outlined)),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text(
          'Job Offer',
          style: TextStyle(
            color: AppColors.white,
          ),
        ),
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: BlocProvider<JobOfferCubit>(
        create: (context) => JobOfferCubit()..convertPdfData('https://gold-jami-18.tiiny.site/'),
        child: BlocConsumer<JobOfferCubit, JobOfferState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is GeneratingPDFLoadingState) {
              return Center(
                child: CircularProgressIndicator(
                    backgroundColor: AppColors.primary),
              );
            }
            if (state is GeneratingPDFSuccessState) {
              return Stack(
                children: [
                  Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 45.0),
                    child: PDFView(
                      filePath: state.pdf.path,
                      enableSwipe: true,
                      swipeHorizontal: true,
                      autoSpacing: false,
                      pageFling: true,
                      pageSnap: true,
                      defaultPage: 1,
                      fitPolicy: FitPolicy.BOTH,
                      preventLinkNavigation: false,
                      onRender: (p) {
                        // controller.pages = p;
                        // controller.changeIsReady(false);
                      },
                      onError: (error) {
                        // controller.errorMessage = error.toString();
                        // if (kDebugMode) {

                        // }
                      },
                      onPageError: (page, error) {
                        // controller.errorMessage = '$page: ${error.toString()}';
                        // if (kDebugMode) {

                        // }
                      },
                      onViewCreated: (pdfCtrl) {
                        // controller.cTr.complete(pdfCtrl);
                      },
                      onLinkHandler: (String? uri) {
                        // if (kDebugMode) {

                        // }
                      },
                      onPageChanged: (int? page, int? total) {},
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                  child: Text('Errorrrrrrrrrrrrrrrrrrrrrrrrr !!!!!!!!!!'));
            }
          },
        ),
      ),
    );
  }
}
