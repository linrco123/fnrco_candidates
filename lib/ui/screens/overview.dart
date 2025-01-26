import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/data/api_provider/overview_provider.dart';
import '../../logic/cubit/overview/overview_cubit.dart';
import '../widgets/return_btn.dart';
import '../../../constants/app_colors.dart';
import '../../../core/functions/translate.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OverviewCubit(OverviewProvider()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text(
            translateLang(context, 'overview'),
            style: TextStyle(
                color: AppColors.primary, fontWeight: FontWeight.bold),
          ),
          leading: ReturnButton(),
          centerTitle: true,
        ),
        body: BlocConsumer<OverviewCubit, OverviewState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Container(
              //color: AppColors.primary,
              width: double.maxFinite,
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [],
              ),
            );
          },
        ),
      ),
    );
  }
}
