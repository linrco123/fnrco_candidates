// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/data/api_provider/management_content/surveys.dart';
import 'package:fnrco_candidates/logic/cubit/management_content/survies/surveys_cubit.dart';
import 'package:fnrco_candidates/ui/screens/management_content/survey/survey_view.dart';
import 'package:fnrco_candidates/ui/widgets/empty_data_widget.dart';
import 'package:fnrco_candidates/ui/widgets/error_widget.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/management_content/survey_card.dart';

class SurviesScreen extends StatelessWidget {
  final SurveysProvider surviesProvider = SurveysProvider();
  final SurveysCubit surveysCubit = SurveysCubit(SurveysProvider());
  SurviesScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => surveysCubit..getsurveys(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text(
            'Surveys',
            style: TextStyle(color: AppColors.primary),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColors.primary,
              )),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(15.0),
          child: BlocBuilder<SurveysCubit, SurveysState>(
            builder: (context, state) {
              var surveysCubit = BlocProvider.of<SurveysCubit>(context);
              if (state is SurveysLoadingState) {
                return const Center(
                  child: AnimatedLoadingWidget(
                    height: 150,
                    width: 150,
                  ),
                );
              }
              if (state is SurveysFailureState) {
                return FailureWidget(
                  showImage: true,
                    title:
                        'Some Error ocurrs when getting surveys !!!\n try again',
                    onTap: () {
                      surveysCubit.getsurveys();
                    });
              }
              return surveysCubit.surveys.isEmpty
                  ? const EmptyDataWidget(
                      message: "No Surveys available Yet!!!",
                    )
                  : ListView.separated(
                      itemCount: surveysCubit.surveys.length,
                      itemBuilder: (BuildContext context, int index) => InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (Context) => BlocProvider.value(
                                      value: surveysCubit
                                        ..getSurveyView(
                                            surveysCubit.surveys[index].id!),
                                      child: SurveyViewScreen(),
                                    )));
                          },
                          child:
                              SurveyCard(survey: surveysCubit.surveys[index])),
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        height: 10.0,
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
