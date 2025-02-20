import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../../core/functions/translate.dart';
import '../../logic/cubit/resume/resume_cubit.dart';
import '../../constants/app_colors.dart';
import '../widgets/auth/custom_elevated_btn.dart';
import '../widgets/profile/title_text.dart';
import '../widgets/return_btn.dart';

class ResumeScreen extends StatelessWidget {
  const ResumeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          translateLang(context, "my_resume"),
          style: TextStyle(
            color: AppColors.primary,
          ),
        ),
        centerTitle: true,
        leading: ReturnButton(),
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: BlocProvider(
        create: (context) => ResumeCubit(),
        child: BlocConsumer<ResumeCubit, ResumeState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            ResumeCubit resumeCubit = ResumeCubit.instance(context);
            return SingleChildScrollView(
              child: Container(
                color: AppColors.white,
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    const CustomTitle(
                      title: "resume_attch",
                      frontP: 0.0,
                    ),
                    Container(
                      width: double.infinity / 2,
                      height: resumeCubit.fileName.isEmpty ? 103 : 300,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () {
                          resumeCubit.pickFile();
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            resumeCubit.fileName.isEmpty
                                ? Icon(
                                    Icons.attach_file,
                                    color: AppColors.primary,
                                  )
                                : Stack(
                                    children: [
                                      SizedBox(
                                        width: double.infinity / 2,
                                        height: 300,
                                        child: PDFView(
                                          filePath: resumeCubit.pdfFile!.path,
                                          enableSwipe: true,
                                          swipeHorizontal: true,
                                          autoSpacing: false,
                                          pageFling: true,
                                          pageSnap: true,
                                          fitEachPage: true,
                                          defaultPage: 1,
                                          fitPolicy: FitPolicy.BOTH,
                                          preventLinkNavigation: false,
                                        ),
                                      ),
                                      Positioned(
                                        top: 0.0,
                                        right: 0.0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.black
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              resumeCubit.removeFile();
                                            },
                                            child: Icon(
                                              Icons.close,
                                              color: AppColors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                            if (resumeCubit.fileName.isEmpty)
                              const SizedBox(height: 10),
                            resumeCubit.fileName.isEmpty
                                ? Text(
                                    translateLang(context, 'upload_file'),
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  )
                                : const SizedBox.shrink()
                          ],
                        ),
                      ),
                    ),
                    // resumeCubit.fileName.isNotEmpty
                    //     ? SizedBox(
                    //         width: double.infinity / 2,
                    //         height: 300,
                    //         child: PDFView(
                    //           filePath: resumeCubit.pdfFile!.path,
                    //           enableSwipe: true,
                    //           swipeHorizontal: true,
                    //           autoSpacing: false,
                    //           pageFling: true,
                    //           pageSnap: true,
                    //           fitEachPage: true,
                    //           defaultPage: 1,
                    //           fitPolicy: FitPolicy.BOTH,
                    //           preventLinkNavigation: false,
                    //           onRender: (p) {
                    //             // controller.pages = p;
                    //             // controller.changeIsReady(false);
                    //           },
                    //           onError: (error) {
                    //             // controller.errorMessage = error.toString();
                    //             // if (kDebugMode) {

                    //             // }
                    //           },
                    //           onPageError: (page, error) {
                    //             // controller.errorMessage = '$page: ${error.toString()}';
                    //             // if (kDebugMode) {

                    //             // }
                    //           },
                    //           onViewCreated: (pdfCtrl) {
                    //             // controller.cTr.complete(pdfCtrl);
                    //           },
                    //           onLinkHandler: (String? uri) {
                    //             // if (kDebugMode) {

                    //             // }
                    //           },
                    //           onPageChanged: (int? page, int? total) {},
                    //         ),
                    //       )
                    //     : SizedBox.shrink(),

                    const SizedBox(
                      height: 20.0,
                    ),
                    const CustomTitle(
                      title: "into_ov_view",
                      frontP: 0.0,
                    ),
                    TextFormField(
                      maxLines: 3,
                      controller: TextEditingController(),
                      decoration: InputDecoration(
                          hintText:
                              'write something interesting about yourself........',
                          hintStyle:
                              TextStyle(color: AppColors.grey, fontSize: 15.0),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20.0),
                          )),
                    ),

                    const SizedBox(
                      height: 20.0,
                    ),

                    const CustomTitle(
                      title: "education",
                      frontP: 0.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text('Title',
                              style: TextStyle(
                                  color: AppColors.black, fontSize: 17.0)),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                            child: DropdownButton(
                          hint: const Text('select item'),
                          items: [
                            'item1',
                            'item2',
                            'item3',
                            'item4',
                          ]
                              .map((value) => DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  ))
                              .toList(),
                          onChanged: (value) {},
                        ))
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text('Academy',
                              style: TextStyle(
                                  color: AppColors.black, fontSize: 17.0)),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                            child: DropdownButton(
                          hint: const Text('select item'),
                          items: [
                            'item1',
                            'item2',
                            'item3',
                            'item4',
                          ]
                              .map((value) => DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  ))
                              .toList(),
                          onChanged: (value) {},
                        ))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text('Year',
                              style: TextStyle(
                                  color: AppColors.black, fontSize: 17.0)),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                            child: DropdownButton(
                          hint: const Text('select item'),
                          items: [
                            'item1',
                            'item2',
                            'item3',
                            'item4',
                          ]
                              .map((value) => DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  ))
                              .toList(),
                          onChanged: (value) {},
                        ))
                      ],
                    ),
                    // Container(
                    //   margin: const EdgeInsets.symmetric(vertical: 15.0),
                    //   child: Text('Skills & Experience',
                    //       style: TextStyle(
                    //           color: AppColors.primary, fontSize: 18.0)),
                    // ),
                    const SizedBox(
                      height: 20.0,
                    ),

                    const CustomTitle(
                      title: "skills_expers",
                      frontP: 0.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text('Title',
                              style: TextStyle(
                                  color: AppColors.black, fontSize: 17.0)),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                            child: DropdownButton(
                          hint: const Text('select item'),
                          items: [
                            'item1',
                            'item2',
                            'item3',
                            'item4',
                          ]
                              .map((value) => DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  ))
                              .toList(),
                          onChanged: (value) {},
                        ))
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text('Company',
                              style: TextStyle(
                                  color: AppColors.black, fontSize: 17.0)),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                            child: DropdownButton(
                          hint: const Text('select item'),
                          items: [
                            'item1',
                            'item2',
                            'item3',
                            'item4',
                          ]
                              .map((value) => DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  ))
                              .toList(),
                          onChanged: (value) {},
                        ))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text('Year',
                              style: TextStyle(
                                  color: AppColors.black, fontSize: 17.0)),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                            child: DropdownButton(
                          hint: const Text('select item'),
                          items: [
                            'item1',
                            'item2',
                            'item3',
                            'item4',
                          ]
                              .map((value) => DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  ))
                              .toList(),
                          onChanged: (value) {},
                        ))
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    CustomElevatedButton(
                        fun: () {},
                        background: AppColors.primary,
                        text: 'Submit')
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
