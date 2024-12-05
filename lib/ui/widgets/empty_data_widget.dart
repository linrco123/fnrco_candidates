
import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/app_images_path.dart';
import 'package:lottie/lottie.dart';

class EmptyDataWidget extends StatelessWidget {
  final String message;
  const EmptyDataWidget({
    Key? key,
     this.message = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      //child: Text('Some Error occurs !!'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: AppColors.grey),
          ),
          //const SizedBox(height: 10.0,),
          Lottie.asset(AppImages.EMPTYDATA,
                      repeat: true,
                   // backgroundLoading: true,
                   alignment: Alignment.center,
              height: 400.0, width: 400.0,fit: BoxFit.cover)
        ],
      ),
    );
  }
}
