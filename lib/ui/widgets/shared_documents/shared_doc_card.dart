// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/app_images_path.dart';

class SharedDocCard extends StatelessWidget {
  final bool isActive;
  final void Function()? onTap;
  final String fileName;
  final String uploadDate;
  final String fileType;
  const SharedDocCard({
    Key? key,
    required this.isActive,
    this.onTap,
    required this.fileName,
    required this.uploadDate,
    required this.fileType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 3,
        child: Container(
          // height: 210,
          //  width: 210,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                  color: isActive ? AppColors.primary : AppColors.white,
                  width: 2.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 5.0,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  isActive
                      ? Image.asset(
                          AppImages.RED_CHECKED,
                          height: 20,
                          width: 20,
                        )
                      : Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              shape: BoxShape.circle,
                              border:
                                  Border.all(width: 1, color: AppColors.black)),
                        ),
                ],
              ),
              Expanded(
                  child: Column(
                spacing: 7.0,
                children: [
                  SvgPicture.asset(
                    AppImages.document,
                    height: 50.0,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    fileName,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    fileType,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    uploadDate.split('T').first,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
