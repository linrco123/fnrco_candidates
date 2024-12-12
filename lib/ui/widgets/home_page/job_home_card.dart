import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/app_images_path.dart';

class JobHomeCard extends StatelessWidget {
  final void Function()? onTap;
  final String image;
  final String job;
  final String company;
  final String salary;

  const JobHomeCard(
      {super.key,
      this.onTap,
      required this.image,
      required this.job,
      required this.company,
      required this.salary});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 95.0,
        //width: 100.0,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Image.asset(
              image,
              height: 60.0,
              width: 60.0,
            ),
            const SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(job,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontWeight: FontWeight.bold)),
                Text(company, style: Theme.of(context).textTheme.titleSmall),
                const Spacer(),
                Row(
                  children: [
                    Image.asset(
                      AppImages.SALARY,
                      height: 30.0,
                      width: 30.0,
                      color: AppColors.primary,
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Text(
                        // overflow: TextOverflow.ellipsis,
                        // maxLines: 1,
                        '\$ ${salary.length < 20 ? salary : salary.substring(0, 20)}',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
