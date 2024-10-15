import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/business_logic/cubit/resume/resume_cubit.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/localizations/app_localizations.dart';
import 'package:fnrco_candidates/presentation/widgets/auth/custom_elevated_btn.dart';

class ResumeScreen extends StatelessWidget {
  const ResumeScreen({super.key});
  // final List<String> items = [
  //   'Item1',
  //   'Item2',
  //   'Item3',
  //   'Item4',
  // ];
  // String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary.withOpacity(0.1),
        title: Text(
          'My Resume',
          style: TextStyle(
            color: AppColors.primary,
          ),
        ),
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
                color: AppColors.primary.withOpacity(0.1),
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Text('Resume Attachment',
                          style: TextStyle(
                              color: AppColors.primary, fontSize: 18.0)),
                    ),
                    Container(
                      width: double.infinity / 2,
                      height: 103,
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
                                : GestureDetector(
                                    onTap: () {
                                      // controller.removeFile()
                                    },
                                    child: Icon(
                                      CupertinoIcons.bin_xmark,
                                      color: AppColors.primary,
                                    ),
                                  ),
                            const SizedBox(height: 10),
                            Text(
                              resumeCubit.fileName.isEmpty
                                  ? AppLocalizations.of(context)!
                                      .translate('upload_file')
                                  : resumeCubit.fileName,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Text('Intro & Overview',
                          style: TextStyle(
                              color: AppColors.primary, fontSize: 18.0)),
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
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Text('Education',
                          style: TextStyle(
                              color: AppColors.primary, fontSize: 18.0)),
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
                          hint: Text('select item'),
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
                          hint: Text('select item'),
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
                          hint: Text('select item'),
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
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Text('Skills & Experience',
                          style: TextStyle(
                              color: AppColors.primary, fontSize: 18.0)),
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
                          hint: Text('select item'),
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
                          hint: Text('select item'),
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
                          hint: Text('select item'),
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
