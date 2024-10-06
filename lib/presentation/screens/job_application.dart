import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/presentation/screens/company_info.dart';

class JobApplicationScreen extends StatelessWidget {
  const JobApplicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.primary));
    return Scaffold(
      body: Stack(children: [
        Container(
          color: AppColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          height: MediaQuery.of(context).size.height / 3,
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                              color: AppColors.white,
                            )),
                        Text(
                          'software engineer',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: AppColors.white,
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
            ],
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height / 3.5),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: const BorderRadiusDirectional.only(
                    topStart: Radius.circular(30.0),
                    topEnd: Radius.circular(30.0))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 30.0,
                      ),
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
                      const SizedBox(
                        width: 30.0,
                      ),
                      Text(
                        'Apply Form'.toUpperCase(),
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.primary)),
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        children: [
                          Text(
                            '+Upload Resume',
                            style: TextStyle(
                                color: AppColors.grey, fontSize: 20.0),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.upload_file_rounded,
                            color: AppColors.primary,
                          )
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Full name',
                    filled: true,
                    hintStyle: TextStyle(color: AppColors.grey),
                    fillColor: const Color(0xFFF5FCF9),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0 * 1.5, vertical: 16.0),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                  ),
                  onSaved: (name) {
                    // Save it
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(color: AppColors.grey),
                    filled: true,
                    fillColor: const Color(0xFFF5FCF9),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0 * 1.5, vertical: 16.0),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                  ),
                  onSaved: (name) {
                    // Save it
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Phone',
                    hintStyle: TextStyle(color: AppColors.grey),
                    filled: true,
                    fillColor: const Color(0xFFF5FCF9),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0 * 1.5, vertical: 16.0),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  onSaved: (phone) {
                    // Save it
                  },
                ),
                //const SizedBox(height: 20.0,),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const CompanyInfoScreen()));
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
                const SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
