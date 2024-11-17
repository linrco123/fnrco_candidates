import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/app_pages_names.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/ui/screens/sloped_container.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/ui/widgets/home_page/search_form_field.dart';

class UnregisteredScreen extends StatelessWidget {
  const UnregisteredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          WavyContainer(
              widget: Container(
            width: double.infinity,
            // height: MediaQuery.of(context).size.height * 0.5,
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            decoration: BoxDecoration(
              //color: AppColors.success,
              // borderRadius: BorderRadius.only(
              //   topRight: Radius.elliptical(3, 60),
              //   topLeft: Radius.elliptical(3, 60),
              //   bottomLeft: Radius.elliptical(3, 60),
              //   bottomRight: Radius.elliptical(3, 60),
              // ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Find Jobs',
                  style: TextStyle(
                      fontSize: 40.0,
                      color: AppColors.white,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 0.0,
                ),
                Text(
                  'Anytime, anywhere',
                  style: TextStyle(
                      fontSize: 25.0,
                      color: AppColors.white,
                      fontWeight: FontWeight.w300),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SearchFormField(
                    controller: TextEditingController(),
                    label: 'Search by title,skills or company',
                    fillColor: AppColors.white,
                    preIcon: Icons.search,
                    vPadding: 20.0,
                    preFun: () {},
                    sufIcon: Icons.close,
                    borderColor: AppColors.white,
                    suFun: () {}),
                const SizedBox(
                  height: 20.0,
                ),
                SearchFormField(
                    controller: TextEditingController(),
                    label: 'All countries',
                    fillColor: AppColors.white,
                    vPadding: 20.0,
                    preIcon: Icons.location_on_outlined,
                    preFun: () {},
                    sufIcon: Icons.close,
                    suFun: () {}),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: CustomElevatedButton(
                      fun: () {},
                      background: AppColors.white,
                      text: 'Find Jobs',
                      foreground: AppColors.primary,
                    ))
              ],
            ),
          )),
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.6,
                left: 70.0,
                right: 70.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  'Create a professional CV that Employers will love ',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                //const SizedBox(height: 20.0,),
                SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: CustomElevatedButton(
                        fun: () {},
                        background: AppColors.primary,
                        text: 'Create Account')),
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(AppPagesNames.LOGIN);
                  },
                  child: Text.rich(
                      TextSpan(
                        text: translateLang(context, "already_have_an_account"),
                        style: Theme.of(context).textTheme.titleSmall,
                        children: [
                          TextSpan(text: ' '),
                          TextSpan(
                            text: translateLang(context, "sign_in"),
                            style: TextStyle(color: AppColors.primary),
                          ),
                        ],
                      ),
                      style: Theme.of(context).textTheme.headlineSmall),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
