// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/data/api_provider/management_content/faqs.dart';
import 'package:fnrco_candidates/logic/cubit/management_content/faqs/faqs_cubit.dart';
import 'package:fnrco_candidates/ui/widgets/empty_data_widget.dart';
import 'package:fnrco_candidates/ui/widgets/error_widget.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/management_content/faqs_card.dart';
import 'package:fnrco_candidates/ui/widgets/return_btn.dart';

class FAQsScreen extends StatelessWidget {
  FAQsScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FAQsCubit(FaqsProvider())..getFAQs(),
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              'FAQs',
              style: TextStyle(color: AppColors.primary),
            ),
            centerTitle: true,
            leading: ReturnButton()),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(15.0),
          child: BlocBuilder<FAQsCubit, FAQsState>(
            builder: (context, state) {
              var cubit = BlocProvider.of<FAQsCubit>(context);
              if (state is FAQsLoadingState) {
                return Center(
                  child: AnimatedLoadingWidget(
                    height: 150.0,
                    width: 150.0,
                  ),
                );
              }
              if (state is FAQsFailureState) {
                return FailureWidget(
                    title: "Some Error ocurrs when getting FAQs !!!",
                    onTap: () {
                      cubit.getFAQs();
                    });
              }

              return (state as FAQsSuccessState).faqs.isEmpty
                  ? EmptyDataWidget(
                      message: "No FAQS available Yet !!!",
                    )
                  : ListView.separated(
                      itemCount: state.faqs.length,
                      itemBuilder: (BuildContext context, int index) =>
                          FAQCard(faq: state.faqs[index]),
                      // Column(children: [
                      //   Text(state.faqs[index].title!),
                      //   const SizedBox(height: 10.0,),
                      //   Text(html_parser.parse(state.faqs[index].desc!).body!.text),

                      // ],),
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                            height: 10.0,
                          ));
            },
          ),
        ),
      ),
    );
  }
}
