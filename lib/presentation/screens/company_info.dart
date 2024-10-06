import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/presentation/widgets/prefered_size.dart';

class CompanyInfoScreen extends StatelessWidget {
  const CompanyInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(270.0),
          child: Container(
            color: AppColors.blurGreen,
            child: Stack(
              children: [
                Container(
                  height: 250.0,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            'assets/images/company.jpg',
                          ),
                          fit: BoxFit.cover)),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.white.withOpacity(0.3),
                                  shape: BoxShape.circle),
                              padding: const EdgeInsets.all(10.0),
                              child: Icon(Icons.keyboard_backspace_rounded,
                                  color: AppColors.white),
                            )),
                        const SizedBox(width: 10.0),
                        Text(
                          'Company Details',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 30.0,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            CupertinoIcons.ellipsis_vertical,
                            color: AppColors.white,
                            size: 30.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/company-logo1.jpg'),
                          radius: 50.0,
                        )))
              ],
            ),
          )),
      body: Container(
        color: AppColors.blurGreen,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Row(
                    children: [
                      // const SizedBox(width: 5.0),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'HighSpeed Studios',
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text('United Kingdom , London',
                                style: TextStyle(
                                  color: AppColors.black,
                                )),
                          ]),
                      const Spacer(),
                      Column(
                        children: [
                          Icon(
                            Icons.star,
                            color: AppColors.secondary,
                            size: 30.0,
                          ),
                          Text(
                            '4.5',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.secondary),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: AppColors.primary, width: 1.0),
                        ),
                        child: Icon(
                          CupertinoIcons.phone_fill,
                          color: AppColors.primary,
                          size: 30.0,
                        ),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Telephone',
                            style: TextStyle(
                                color: AppColors.grey, fontSize: 15.0),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            '+51 546 768 652',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: AppColors.primary, width: 1.0),
                        ),
                        child: Icon(
                          CupertinoIcons.mail_solid,
                          color: AppColors.primary,
                          size: 30.0,
                        ),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email',
                            style: TextStyle(
                                color: AppColors.grey, fontSize: 15.0),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            'eclisespeedst56@mail.com',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: AppColors.primary, width: 1.0),
                        ),
                        child: Icon(
                          CupertinoIcons.location_fill,
                          color: AppColors.primary,
                          size: 30.0,
                        ),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Website',
                            style: TextStyle(
                                color: AppColors.grey, fontSize: 15.0),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            'speedloading.studio',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Text(
                      'About Company',
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
                        about_company,
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
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 48),
                    shape: const StadiumBorder(),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '21 available jobs',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 17.0,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.white,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String about_company =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley";
