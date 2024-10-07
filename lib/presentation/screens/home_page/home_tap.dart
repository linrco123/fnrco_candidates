import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/presentation/screens/category_details.dart';
import 'package:fnrco_candidates/presentation/screens/job_details.dart';

class HomeTapScreen extends StatelessWidget {
  const HomeTapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.blurGreen,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 100.0,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: const BorderRadiusDirectional.only(
                      bottomStart: Radius.circular(20.0),
                      bottomEnd: Radius.circular(20.0)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good Morning',
                          style:
                              TextStyle(color: AppColors.white, fontSize: 17.0),
                        ),
                        Text(
                          'Muhammed Nady',
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const CircleAvatar(
                      radius: 30.0,
                      backgroundImage:
                          AssetImage('assets/images/person1.jpg'),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 70.0, left: 30.0, right: 30.0),
                child: TextFormField(
                  controller: TextEditingController(),
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.white,
                      hintStyle: Theme.of(context).textTheme.headlineSmall,
                      hintText: 'search a job here',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          )),
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.grey,
                      )),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30.0,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListView(
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            height: 130.0,
                            //width: 200.0,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Icon(
                                    CupertinoIcons.checkmark_circle,
                                    color: AppColors.grey,
                                    size: 70.0,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '29',
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30.0),
                                    ),
                                    Text(
                                      'Jobs applied',
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: Container(
                            height: 130.0,
                            //width: 200.0,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: AppColors.secondary,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Icon(
                                    CupertinoIcons.question_circle,
                                    color: AppColors.grey,
                                    size: 70.0,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '3',
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30.0),
                                    ),
                                    Text(
                                      'InterViews',
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'Categories',
                        style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Wrap(
                      direction: Axis.horizontal,
                      spacing: 20.0,
                      runSpacing: 10.0,
                      children: [
                        ...List.generate(
                            listIcons.length,
                            (index) => InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const CategoryDetailsScreen()));
                                  },
                                  child: Container(
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                          color: AppColors.primary, width: 1.0),
                                    ),
                                    child: Icon(listIcons[index]),
                                  ),
                                )),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'Recommended Jobs',
                        style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      width: double.infinity,
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 5.0),
                        scrollDirection: Axis.horizontal,
                        itemCount: 7,
                        itemBuilder: (BuildContext context, int index) =>
                            GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const JobDetailsScreen()));
                          },
                          child: Container(
                            height: 90.0,
                            //width: 100.0,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/job-offer.png',
                                  height: 60.0,
                                  width: 60.0,
                                ),
                                const SizedBox(width: 10.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'software engineer',
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text('Jakarata, Indonisa',
                                        style: TextStyle(
                                          color: AppColors.black,
                                        )),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/salary.png',
                                          height: 30.0,
                                          width: 30.0,
                                          color: AppColors.primary,
                                        ),
                                        const SizedBox(
                                          width: 5.0,
                                        ),
                                        Text(
                                          '\$500 - \$2000',
                                          style: TextStyle(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'Recent Jobs',
                            style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'MORE',
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold),
                            )),
                        // ListView.separated(
                        //   shrinkWrap: true,
                        //   physics: const NeverScrollableScrollPhysics(),
                        //   separatorBuilder: (context, index) =>
                        //       const SizedBox(height: 10.0),
                        //   scrollDirection: Axis.vertical,
                        //   itemCount: 7,
                        //   itemBuilder: (BuildContext context, int index) =>
                        //       Container(
                        //     height: 90.0,
                        //     //width: 100.0,
                        //     padding: const EdgeInsets.all(10.0),
                        //     decoration: BoxDecoration(
                        //       color: AppColors.white,
                        //       borderRadius: BorderRadius.circular(20.0),
                        //     ),
                        //     child: Row(
                        //       children: [
                        //         Image.asset(
                        //           'assets/images/job-offer.png',
                        //           height: 60.0,
                        //           width: 60.0,
                        //         ),
                        //         const SizedBox(width: 10.0),
                        //         Column(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             Text(
                        //               'UI/UX designer',
                        //               style: TextStyle(
                        //                 color: AppColors.black,
                        //                 fontWeight: FontWeight.bold,
                        //               ),
                        //             ),
                        //             Text('Jakarata, Indonisa',
                        //                 style: TextStyle(
                        //                   color: AppColors.black,
                        //                 )),
                        //             const Spacer(),
                        //             Row(
                        //               children: [
                        //                 Image.asset(
                        //                   'assets/images/salary.png',
                        //                   height: 30.0,
                        //                   width: 30.0,
                        //                   color: AppColors.primary,
                        //                 ),
                        //                 const SizedBox(
                        //                   width: 5.0,
                        //                 ),
                        //                 Text(
                        //                   '\$500 - \$2000',
                        //                   style: TextStyle(
                        //                     color: AppColors.primary,
                        //                     fontWeight: FontWeight.bold,
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           ],
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}

List<IconData> listIcons = <IconData>[
  CupertinoIcons.bolt,
  CupertinoIcons.pen,
  CupertinoIcons.archivebox,
  CupertinoIcons.arrow_branch,
  CupertinoIcons.dot_square,
  CupertinoIcons.wrench,
  CupertinoIcons.ticket,
  CupertinoIcons.table
];
