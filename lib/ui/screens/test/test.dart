import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/app_images_path.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TestScreenh extends StatefulWidget {
  const TestScreenh({super.key});

  @override
  State<TestScreenh> createState() => _TestScreenhState();
}

class _TestScreenhState extends State<TestScreenh> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Test'),
          backgroundColor: AppColors.primary,
        ),
        body: Container(
          color: AppColors.success,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //SvgPicture.asset(AppImages.jobsvg , height: 100,width: 100,),
              Image.asset(AppImages.boarding2),

              // SizedBox(
              //     width: 200.0,
              //     height: 100.0,
              //     child: Shimmer.fromColors(
              //       baseColor: Colors.red,
              //       highlightColor: Colors.yellow,
              //       child: Text(
              //         'Shimmer',
              //         textAlign: TextAlign.center,
              //         style: TextStyle(
              //           fontSize: 40.0,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     )),
              const SizedBox(
                height: 20.0,
              ),
             
            ],
          )),
        ));
  }
}

