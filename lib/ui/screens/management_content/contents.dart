// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
 import 'package:fnrco_candidates/data/api_provider/management_content/contents.dart';
 import 'package:fnrco_candidates/logic/cubit/management_content/contents/contents_cubit.dart';
import 'package:fnrco_candidates/ui/widgets/empty_data_widget.dart';
import 'package:fnrco_candidates/ui/widgets/error_widget.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/management_content/content_card.dart';

class ContentsScreen extends StatelessWidget {
  ContentsScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
         ContentsCubit(ContentsProvider())..getContents(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            translateLang(context, 'contents'),
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
          child: BlocBuilder<ContentsCubit, ContentsState>(
            builder: (context, state) {
              var cubit = BlocProvider.of<ContentsCubit>(context);
              if (state is ContentsLoadingState) {
                return AnimatedLoadingWidget(
                  height: 150,
                  width: 150,
                );
              }
              if (state is ContentsFailureState) {
                return FailureWidget(
                    title: 'Some Error occured !!! try again',
                    onTap: () {
                      cubit.getContents();
                    });
              }
              return (state as ContentsSuccessState).contents.isEmpty
                  ? EmptyDataWidget(
                      message: "No Contents available Yet!!!",
                    )
                  : ListView.separated(
                      itemCount: state.contents.length,
                      itemBuilder: (BuildContext context, int index) => InkWell(
                          onTap: () {},
                          child: ContentCard(content: state.contents[index])),
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
