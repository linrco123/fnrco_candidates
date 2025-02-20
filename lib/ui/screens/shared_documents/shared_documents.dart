// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/logic/cubit/shared_documents/shared_documents_cubit.dart';
import 'package:fnrco_candidates/ui/screens/shared_documents/show_document.dart';
import 'package:fnrco_candidates/ui/widgets/empty_data_widget.dart';
import 'package:fnrco_candidates/ui/widgets/error_widget.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/return_btn.dart';
import 'package:fnrco_candidates/ui/widgets/shared_documents/shared_doc_card.dart';
import 'package:page_transition/page_transition.dart';

class SharedDocumentsScreen extends StatelessWidget {
  final int appId;
  const SharedDocumentsScreen({
    Key? key,
    required this.appId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        title: Text(
          translateLang(context, 'shared_documents'),
          style:
              TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
        ),
        leading: ReturnButton(
          color: AppColors.primary,
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      backgroundColor: AppColors.white,
      body: Container(
        color: Colors.grey.shade100,
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: BlocConsumer<SharedDocumentsCubit, SharedDocumentsState>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = BlocProvider.of<SharedDocumentsCubit>(context);
            if (state is SharedDocumentsGetDetailsLoadingState) {
              return const AnimatedLoadingWidget(
                height: 150.0,
                width: 150.0,
              );
            }

            if (state is SharedDocumentsGetDetailsfailureState) {
              return FailureWidget(
                  showImage: true,
                  title: state.message,
                  onTap: () {
                    context.read<SharedDocumentsCubit>().getAppDocs(appId);
                  });
            }

            return cubit.sharedAppDocs.isEmpty
                ? const EmptyDataWidget(
                    message: 'No Documents available Yet !!!!',
                  )
                : Container(
                    color: Colors.grey.shade100,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 10.0),
                    child: Column(
                      children: [
                        Expanded(
                            child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  // mainAxisExtent: 5,
                                  childAspectRatio: 0.87,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemCount: cubit.sharedAppDocs.length,
                          itemBuilder: (context, index) => SharedDocCard(
                            onTap: () {
                              cubit.chooseDocument(index);
                            },
                            isActive: index == cubit.chosenDocument,
                            fileName: cubit.sharedAppDocs[index].fileName!,
                            fileType: cubit.sharedAppDocs[index].fileType!,
                            uploadDate: cubit.sharedAppDocs[index].uploadedAt!,
                          ),
                        )),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: AppColors.white,
                                    shadowColor: AppColors.blurRed,
                                    elevation: 10,
                                    padding: const EdgeInsets.all(10.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0)),
                                    backgroundColor: AppColors.primary),
                                onPressed: () {
                                  Navigator.of(context).push(PageTransition(
                                      child: BlocProvider.value(
                                        value: cubit,
                                        child: ShowDocumentScreen(
                                            sharedDocument: cubit.sharedAppDocs[
                                                cubit.chosenDocument]),
                                      ),
                                      type: PageTransitionType.fade,
                                      alignment: Alignment.centerLeft,
                                      duration: const Duration(seconds: 1)));
                                },
                                child: Icon(
                                  Icons.arrow_forward,
                                  size: 25,
                                  color: AppColors.white,
                                ))
                          ],
                        ),
                        // CustomElevatedButton(
                        //     fun: () {
                        //       Navigator.of(context).push(PageTransition(
                        //           child: BlocProvider.value(
                        //             value: cubit,
                        //             child: ShowDocumentScreen(
                        //                 sharedDocument: cubit.sharedAppDocs[
                        //                     cubit.chosenDocument]),
                        //           ),
                        //           type: PageTransitionType.fade,
                        //           alignment: Alignment.centerLeft,
                        //           duration: const Duration(seconds: 1)));
                        //     },
                        //     background: AppColors.primary,
                        //     text: translateLang(context, 'proceed'))
                      ],
                    ));

            // return Center(
            //   child: Text(
            //     'Unkown Error !!!',
            //     style: Theme.of(context).textTheme.labelMedium,
            //   ),
            // );
          },
        ),
      ),
    );
  }

  String _getFileName(String filePath) {
    return filePath.substring(filePath.lastIndexOf('/') + 1);
  }
}
