// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/data/api_provider/management_contect/surveys.dart';
import 'package:fnrco_candidates/logic/cubit/survies/surveys_cubit.dart';
import 'package:fnrco_candidates/ui/screens/management_content/survey_view.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:html/parser.dart' as html_parser;

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
                return Center(
                  child: LoadingWidget(),
                );
              }
              if (state is SurveysFailureState) {
                return Center(
                  child: Text(
                    'Some Error occurs !!!',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                );
              }
              if (state is SurveysSuccessState) {
                return ListView.separated(
                  itemCount: state.surveys.length,
                  itemBuilder: (BuildContext context, int index) => InkWell(
                    onTap: () {
                     
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (Context) => BlocProvider.value(
                                value: surveysCubit..getSurveyView( state.surveys[index].id!),
                                child: SurveyViewScreen(),
                              )));
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                          boxShadow: [
                            //   BoxShadow(
                            //   color: AppColors.primary.withOpacity(0.1),
                            //   blurRadius: 5.0,
                            //   spreadRadius: 5.0,
                            // blurStyle: BlurStyle.outer,
                            //   offset: Offset(0, 1)
                            // )
                          ],
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10.0),
                          border: BorderDirectional(
                              top: BorderSide(
                                  color: AppColors.primary, width: 5.0),
                              bottom: BorderSide(
                                  color: AppColors.primary, width: 5.0))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.surveys[index].surveyName!,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: AppColors.black),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  textAlign: TextAlign.justify,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  html_parser
                                      .parse(state.surveys[index].surveyDesc!)
                                      .body!
                                      .text,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Text(
                                'Survey By: ',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              Text(
                                state.surveys[index].surveyBy!,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_month,
                                color: AppColors.primary,
                                size: 20.0,
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                state.surveys[index].surveyFrom!,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Text(
                                  'to',
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                              ),
                              Text(
                                state.surveys[index].surveyTo!,
                                style: Theme.of(context).textTheme.labelMedium,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Text(
                                'Status: ',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              Text(
                                state.surveys[index].surveyStatus!,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    height: 10.0,
                  ),
                );
              }

              return SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
