import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/presentation/screens/job_application.dart';

class JobDetailsScreen extends StatelessWidget {
  const JobDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      body: Container(
        color: AppColors.blurGreen,
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Container(
                        decoration: BoxDecoration(
                            color: AppColors.grey.withOpacity(0.3),
                            shape: BoxShape.circle),
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(Icons.keyboard_backspace_rounded,
                            color: AppColors.grey),
                      )),
                  const SizedBox(width: 10.0),
                  Text(
                    'Details',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      CupertinoIcons.line_horizontal_3_decrease_circle,
                      color: AppColors.grey,
                      size: 30.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 15.0),
                child: Divider(
                  color: AppColors.primary.withOpacity(0.5),
                  height: 1.0,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Jakarata, Indonisa',
                            style: TextStyle(
                              fontSize: 17.0,
                              color: AppColors.black,
                            )),
                        Text(
                          'software engineer',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // const Spacer(),
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      'assets/images/job-offer.png',
                      height: 80.0,
                      width: 80.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                spacing: 10.0,
                runSpacing: 10.0,
                children: [
                  ...List.generate(
                    stringList.length,
                    (index) => Container(
                        //width: 50.0,
                        // alignment: Alignment.center,
                        height: 40.0,
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(40.0),
                            border:
                                Border.all(color: AppColors.primary, width: 1)),
                        child: Text(
                          stringList[index],
                          style: TextStyle(color: AppColors.primary),
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Divider(
                  color: AppColors.primary.withOpacity(0.5),
                  height: 1.0,
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        shape: BoxShape.circle),
                    child: Image.asset(
                      'assets/images/salary.png',
                      height: 30.0,
                      width: 30.0,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'salary',
                        style: TextStyle(color: AppColors.grey, fontSize: 15.0),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        '\$500 - \$2,000/monthly',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        shape: BoxShape.circle),
                    child: Icon(
                      Icons.location_on_outlined,
                      size: 30.0,
                      color: AppColors.primary.withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'location',
                        style: TextStyle(color: AppColors.grey, fontSize: 15.0),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text('United Kingdom, London',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: AppColors.black,
                          )),
                    ],
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Divider(
                  color: AppColors.primary.withOpacity(0.5),
                  height: 1.0,
                ),
              ),
              Row(
                children: [
                  Text(
                    'Job Description',
                    style: TextStyle(
                      fontSize: 22.0,
                      color: AppColors.black,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      job_description,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: AppColors.black,
                        //fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Column(
                children: [
                  ...List.generate(
                      6,
                      (int index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: Row(
                              children: [
                                Image.asset('assets/images/check.png',
                                    height: 15.0, width: 15.0),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  child: Text(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: AppColors.black,
                                      //fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ))
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Container(
                      padding: const EdgeInsets.all(0.0),
                      decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          shape: BoxShape.circle),
                      child: Icon(
                        CupertinoIcons.line_horizontal_3_decrease_circle,
                        color: AppColors.grey,
                        size: 60.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const JobApplicationScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 48),
                        shape: const StadiumBorder(),
                      ),
                      child: Text(
                        'Apply Job'.toUpperCase(),
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}

List<String> stringList = [
  'Fulltime',
  'Remote Working',
  'Hourly',
];

String job_description =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley";
