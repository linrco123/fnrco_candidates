import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:fnrco_candidates/logic/cubit/job_offer/job_offer_cubit.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
//import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class JobOfferScreen extends StatelessWidget {
  final String pdfLink;
  JobOfferScreen({super.key, required this.pdfLink});
  //final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<JobOfferCubit>(
      create: (context) => JobOfferCubit()
        ..convertPdfData('https://kdamat.com/servant/cv/download/815'),
      child: Builder(
        builder: (context) {
          return Scaffold(
            floatingActionButton: IconButton(
                style: IconButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    fixedSize: Size(40.0, 40.0)),
                onPressed: () {
                  //_pdfViewerKey.currentState?.openBookmarkView();
                  BlocProvider.of<JobOfferCubit>(context).uploadJobOffer();
                  print('=================================job offer ================================');
                },
                icon: Icon(
                  Icons.upload_outlined,
                  color: AppColors.white,
                )),
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
              leading: BackButton(
                color: AppColors.white,
              ),
            ),
            body: BlocConsumer<JobOfferCubit, JobOfferState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                return Stack(
                  children: [
                    Container(
                      height: 50.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                    ),
                    if (state is GeneratingPDFLoadingState)
                      Center(
                        child: CircularProgressIndicator(
                            backgroundColor: AppColors.primary),
                      ),
                    if (state is GeneratingPDFErrorState)
                      Center(
                          child: Text('Errorrrrrrrrrrrrrrrrrrrrrrrrr !!!!!!!!!!')),
                    if (state is GeneratingPDFSuccessState)
                      Padding(
                        padding: const EdgeInsets.only(top: 55.0),
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
              },
            ),
          );
        }
      ),
    );
  }
}
