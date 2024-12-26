import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/cubit/profile_get/about_me/about_me_cubit.dart';
import '../../widgets/empty_data_widget.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/profile_get/keyword_card.dart';

class GetKeywordsScreen extends StatefulWidget {
  const GetKeywordsScreen({super.key});

  @override
  State<GetKeywordsScreen> createState() => _GetPersonalDetailsScreenState();
}

class _GetPersonalDetailsScreenState extends State<GetKeywordsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AboutMeCubit>().getKeywords();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutMeCubit, AboutMeState>(builder: (context, state) {
      if (state is AboutMeGetkeywordsLoadingState) {
        return AnimatedLoadingWidget();
      }
      if (state is AboutMeGetkeywordsErrorState) {
        return FailureWidget(
            title: 'Error ocurred on getting Keywords',
            onTap: () {
              context.read<AboutMeCubit>().getKeywords();
            });
      }
 if(state is AboutMeGetkeywordsSuccessState){
      return state.keywords.isEmpty
          ? EmptyDataWidget()
          : Container(
              height: double.infinity,
              width: double.infinity,
              child: ListView.separated(
                itemCount: state.keywords.length,
                itemBuilder: (context, index) =>
                    KeyWordCard(keyword: state.keywords[index]),
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 16.0,
                ),
              ),
            );}
            return SizedBox.shrink();
    });
  }
}
