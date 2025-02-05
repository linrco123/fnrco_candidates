import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/api_provider/welcome_provider.dart';
import '../../logic/cubit/welcome/welcome_cubit.dart';
import '../../constants/app_colors.dart';
import '../widgets/auth/custom_elevated_btn.dart';
import '../widgets/welcome/welcome_card.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WelcomeCubit(WelcomeProvider()),
      child: Scaffold(
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
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Welcome to Fnrco company',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(fontSize: 25.0),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                textAlign: TextAlign.center,
                'Build your profile, explore and apply to your favorite jobs and get contacted by employers immediately.',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: AppColors.grey),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              CustomPaint(
                //size: Size(300, 200), // Size of the container
                painter: QuarterArchPainter(),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.5,
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      color: AppColors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      WelcomeCard(
                          title: 'Build your profile',
                          description: 'Sign Up and complete your profile.',
                          icon:
                              CupertinoIcons.person_crop_circle_badge_checkmark,
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
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Builder(builder: (context) {
                return CustomElevatedButton(
                    fun: () async {

                      context.read<WelcomeCubit>().handleTransition(context);
                     // context.read<WelcomeCubit>().getPolls();
                    },
                    background: AppColors.primary,
                    text: 'Get Started');
              }),
              const SizedBox(
                height: 10.0,
              ),
            ],
          ),
        )),
      ),
    );
  }
}

class QuarterArchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();

    // Top-left corner with rounded arch
    paint.color = AppColors.primary; // Color for the top-left corner
    Path topLeftPath = Path()
      ..moveTo(0, size.height) // Start at bottom-left
      ..lineTo(0, 0) // Move to top-left
      ..lineTo(size.width / 2, 0) // Move to middle-top
      ..arcToPoint(Offset(0, size.height / 2), // Rounded arch
          radius: Radius.circular(20), // Radius for rounding
          clockwise: true)
      ..close();
    canvas.drawPath(topLeftPath, paint);

    // Bottom-right corner with rounded arch
    paint.color =
        AppColors.primary.withOpacity(0.1); // Color for the bottom-right corner
    Path bottomRightPath = Path()
      ..moveTo(size.width, 0) // Start at top-right
      ..lineTo(size.width, size.height) // Move to bottom-right
      ..lineTo(size.width / 2, size.height) // Move to middle-bottom
      ..arcToPoint(Offset(size.width, size.height / 2), // Rounded arch
          radius: Radius.circular(20), // Radius for rounding
          clockwise: true)
      ..close();
    canvas.drawPath(bottomRightPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
// class QuarterArchPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint()..color = AppColors.primary; // Color for arches

//     // Draw the top-left arch
//     Path topLeftPath = Path()
//       ..moveTo(0, size.height)
//       ..lineTo(0, 0)
//       ..lineTo(size.width / 2, 0)
//       ..arcToPoint(Offset(0, size.height / 2), radius: Radius.circular(50), clockwise: false)
//       ..lineTo(0, size.height);

//     canvas.drawPath(topLeftPath, paint);

//     // Draw the top-right arch
//     Path topRightPath = Path()
//       ..moveTo(size.width, 0)
//       ..lineTo(size.width, size.height)
//       ..lineTo(size.width / 2, 0)
//       ..arcToPoint(Offset(size.width, size.height / 2), radius: Radius.circular(50), clockwise: false)
//       ..lineTo(size.width, 0);

//     canvas.drawPath(topRightPath, paint);

//     // Draw the bottom-left arch
//     Path bottomLeftPath = Path()
//       ..moveTo(0, size.height)
//       ..lineTo(size.width / 2, size.height)
//       ..lineTo(0, size.height)
//       ..arcToPoint(Offset(0, size.height / 2), radius: Radius.circular(50), clockwise: true)
//       ..lineTo(0, size.height);

//     canvas.drawPath(bottomLeftPath, paint);

//     // Draw the bottom-right arch
//     Path bottomRightPath = Path()
//       ..moveTo(size.width, size.height)
//       ..lineTo(size.width, size.height / 2)
//       ..lineTo(size.width / 2, size.height)
//       ..arcToPoint(Offset(size.width, size.height), radius: Radius.circular(50), clockwise: true)
//       ..lineTo(size.width, size.height);

//     canvas.drawPath(bottomRightPath, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }
