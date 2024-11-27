import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/localizations/app_localizations.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_elevated_btn.dart';

class PollsScreen extends StatelessWidget {
  const PollsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submit polls'),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        //color: AppColors.blurRed,
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  'Do you have any symptoms of craziness ?',
                  style: TextStyle(fontSize: 18.0, color: AppColors.white),
                )),
            const SizedBox(
              height: 10.0,
            ),
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    RadioListTile(
                        activeColor: AppColors.primary,
                        title: Text('yes'),
                        value: 1,
                        groupValue: 0,
                        onChanged: (c) {
                          // medicalDeclareCubit.changeRadioItem(c!);
                        }),
                    RadioListTile(
                        activeColor: AppColors.primary,
                        title: Text('No'),
                        value: 2,
                        groupValue: 1,
                        onChanged: (c) {
                          // medicalDeclareCubit.changeRadioItem(c!);
                        }),
                    RadioListTile(
                        activeColor: AppColors.primary,
                        title: Text('agree'),
                        value: 3,
                        groupValue: 0,
                        onChanged: (c) {
                          // medicalDeclareCubit.changeRadioItem(c!);
                        }),
                    RadioListTile(
                        activeColor: AppColors.primary,
                        title: Text('don\'t agree'),
                        value: 4,
                        groupValue: 0,
                        onChanged: (c) {
                          //medicalDeclareCubit.changeRadioItem(c!);
                        }),
                  ],
                )),
            Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    CustomElevatedButton(
                        fun: () {},
                        background: AppColors.primary,
                        text: AppLocalizations.of(context)!.translate('next'))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
