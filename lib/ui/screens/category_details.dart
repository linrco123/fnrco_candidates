import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants/app_colors.dart';
import '../../core/functions/translate.dart';
import '../widgets/home_page/search_form_field.dart';

class CategoryDetailsScreen extends StatelessWidget {
  const CategoryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.dark));
    return Container(
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(children: [
          const SizedBox(
            height: 15.0,
          ),
          // Container(
          //     width: double.infinity,
          //     height: 50.0,
          //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
          //     decoration: BoxDecoration(
          //       color: AppColors.primary,
          //       borderRadius: const BorderRadiusDirectional.only(
          //           bottomStart: Radius.circular(20.0),
          //           bottomEnd: Radius.circular(20.0)),
          //     )),

          SizedBox(
            height: 50.0,
            child: SearchFormField(
              controller: TextEditingController(),
              label: 'search a job here',
              borderColor: AppColors.black,
              preIcon: Icons.search,
              preFun: (value) {},
              sufIcon: Icons.close,
              suFun: () {},
            ),
          ),

          // SizedBox(
          //   height: 50.0,
          //   child: TextFormField(
          //     style: Theme.of(context).textTheme.headlineSmall,
          //     controller: TextEditingController(),
          //     keyboardType: TextInputType.text,
          //     maxLines: 1,
          //     decoration: InputDecoration(
          //         contentPadding: const EdgeInsets.all(10.0),
          //         suffix: IconButton(
          //             onPressed: () {},
          //             icon: Icon(
          //               Icons.close,
          //               color: AppColors.black,
          //               size: 25.0,
          //             )),
          //         hintStyle: Theme.of(context).textTheme.headlineSmall,
          //         hintText: 'search a job here',
          //         border: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(50),
          //             borderSide:
          //                 BorderSide(color: AppColors.black, width: 1.0)),
          //         prefixIcon: Icon(
          //           Icons.search,
          //           color: AppColors.grey,
          //         )),
          //   ),
          // ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15.0),
            child: Row(
              children: [
                const SizedBox(width: 5.0),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    translateLang(context, "results"),
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text('45 ${translateLang(context, "job_founded")}',
                      style: TextStyle(
                        color: AppColors.grey,
                      )),
                ]),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.filter_alt_outlined,
                    color: AppColors.grey,
                    size: 30.0,
                  ),
                ),
              ],
            ),
          ),
          Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: 10.0,
            runSpacing: 10.0,
            children: [
              ...List.generate(
                5,
                (index) => Container(
                    //width: 50.0,
                    // alignment: Alignment.center,
                    height: 40.0,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(40.0),
                    ),
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
          Expanded(
              child: ListView.separated(
                  //  physics: const BouncingScrollPhysics(),
                  itemCount: 8,
                  separatorBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Divider(
                          color: AppColors.primary.withOpacity(0.5),
                          height: 1.0,
                        ),
                      ),
                  itemBuilder: (context, index) => ListTile(
                        leading: Image.asset(
                          'assets/images/job-offer.png',
                          height: 60.0,
                          width: 60.0,
                        ),
                        contentPadding: const EdgeInsets.all(10.0),
                        title: Text(
                          'Lunar Djaj crop',
                          style: TextStyle(color: AppColors.grey ,fontSize: 17.0),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'software engineer',
                              style: TextStyle(
                                fontSize: 22.0,
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/salary.png',
                                  height: 30.0,
                                  width: 30.0,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  '\$500 - \$2000',
                                  style: TextStyle(
                                    color: AppColors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5.0),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 30.0,
                                  color: AppColors.primary.withOpacity(0.4),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Text('United Kingdom, London',
                                    style: TextStyle(
                                      color: AppColors.black,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ))),
          const SizedBox(
            height: 10.0,
          )
        ]),
      ),
    );
  }
}

List<String> stringList = [
  'Fulltime',
  'London',
  'Remote Working',
  'Hourly',
  'Site Working'
];
