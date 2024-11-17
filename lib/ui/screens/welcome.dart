import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/app_pages_names.dart';
import 'package:fnrco_candidates/ui/screens/unregistered_screen.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/ui/widgets/welcome/welcome_card.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Welcome to Fnrcoerp.com',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              textAlign: TextAlign.center,
              'Build your profile, explore and apply to your favorite jobs and get contacted by employers immediately.',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontSize: 18.0, color: AppColors.black.withOpacity(0.4)),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.0),
                  border: BorderDirectional(
                      top: BorderSide(color: AppColors.primary, width: 5.0),
                      bottom:
                          BorderSide(color: AppColors.primary, width: 5.0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  WelcomeCard(
                      title: 'Build your profile',
                      description: 'Sign Up and complete your profile.',
                      icon: CupertinoIcons.person_crop_circle_badge_checkmark,
                      color: Colors.blue),
                  WelcomeCard(
                      title: 'Apply to Jobs',
                      description: 'Explore and instantly apply to jobs.',
                      icon: CupertinoIcons.briefcase,
                      color: Colors.yellow),
                  WelcomeCard(
                      title: 'Get Contacted',
                      description: 'Get Contacted by employers now.',
                      icon: CupertinoIcons.phone_circle,
                      color: Colors.green),
                  //       Container(
                  //         padding: const EdgeInsets.symmetric(
                  //             vertical: 20.0, horizontal: 10.0),
                  //         decoration: BoxDecoration(
                  //             color: AppColors.white,
                  //             borderRadius: BorderRadius.circular(0.0)),
                  //         child: Row(
                  //           children: [
                  //             Container(
                  //                 padding: const EdgeInsets.all(15.0),
                  //                 decoration: BoxDecoration(
                  //                     color: Colors.blue.withOpacity(0.1),
                  //                     shape: BoxShape.circle),
                  //                 child: Icon(
                  //                   CupertinoIcons.person_crop_circle_badge_checkmark,
                  //                   color: Colors.blue,
                  //                 )),
                  //             const SizedBox(
                  //               width: 15.0,
                  //             ),
                  //             Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 Text(
                  //                   'Build your profile',
                  //                   style: TextStyle(
                  //                       color: AppColors.black,
                  //                       fontSize: 18.0,
                  //                       fontWeight: FontWeight.bold),
                  //                 ),
                  //                 const SizedBox(
                  //                   height: 5.0,
                  //                 ),
                  //                 Text('Sign Up and complete your profile.',
                  //                     style: Theme.of(context).textTheme.titleSmall),
                  //               ],
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       Container(
                  //         padding: const EdgeInsets.symmetric(
                  //             vertical: 20.0, horizontal: 10.0),
                  //         decoration: BoxDecoration(
                  //             color: AppColors.white,
                  //             borderRadius: BorderRadius.circular(0.0)),
                  //         child: Row(
                  //           children: [
                  //             Container(
                  //                 padding: const EdgeInsets.all(15.0),
                  //                 decoration: BoxDecoration(
                  //                     color: Colors.yellowAccent.withOpacity(0.1),
                  //                     shape: BoxShape.circle),
                  //                 child: Icon(
                  //                   CupertinoIcons.briefcase,
                  //                   color: Colors.yellow,
                  //                 )),
                  //             const SizedBox(
                  //               width: 15.0,
                  //             ),
                  //             Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 Text(
                  //                   'Apply to Jobs',
                  //                   style: TextStyle(
                  //                       color: AppColors.black,
                  //                       fontSize: 18.0,
                  //                       fontWeight: FontWeight.bold),
                  //                 ),
                  //                 const SizedBox(
                  //                   height: 5.0,
                  //                 ),
                  //                 Text('Explore and instantly apply to jobs.',
                  //                     style: Theme.of(context).textTheme.titleSmall),
                  //               ],
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       Container(
                  //         padding: const EdgeInsets.symmetric(
                  //             vertical: 20.0, horizontal: 10.0),
                  //         decoration: BoxDecoration(
                  //             color: AppColors.white,
                  //             borderRadius: BorderRadius.circular(0.0)),
                  //         child: Row(
                  //           children: [
                  //             Container(
                  //                 padding: const EdgeInsets.all(15.0),
                  //                 decoration: BoxDecoration(
                  //                     color: Colors.green.withOpacity(0.1),
                  //                     shape: BoxShape.circle),
                  //                 child: Icon(
                  //                   CupertinoIcons.phone_circle,
                  //                   color: Colors.green,
                  //                 )),
                  //             const SizedBox(
                  //               width: 15.0,
                  //             ),
                  //             Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 Text(
                  //                   'Get Contacted',
                  //                   style: TextStyle(
                  //                       color: AppColors.black,
                  //                       fontSize: 18.0,
                  //                       fontWeight: FontWeight.bold),
                  //                 ),
                  //                 const SizedBox(
                  //                   height: 5.0,
                  //                 ),
                  //                 Text('Get Contacted by employers now.',
                  //                     style: Theme.of(context).textTheme.titleSmall),
                  //               ],
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                ],
              ),
            ),
            const Spacer(),
            CustomElevatedButton(
                fun: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      AppPagesNames.AUTH, (Route<dynamic> route) => false);
                },
                background: AppColors.primary,
                text: 'Get Started'),
            const SizedBox(
              height: 10.0,
            ),
          ],
        ),
      )),
    );
  }
}
