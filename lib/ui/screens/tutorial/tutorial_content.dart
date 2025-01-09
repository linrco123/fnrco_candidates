import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_images_path.dart';
import '../../../core/functions/translate.dart';
import '../../../data/api_provider/tutorial_provider.dart';
import '../../../data/models/tutorial_model.dart';
import '../../../logic/cubit/tutorial/tutorial_cubit.dart';
import 'tutorial_display.dart';
import '../../widgets/empty_data_widget.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/return_btn.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TutorialsContentScreen extends StatelessWidget {
  const TutorialsContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TutorialCubit(TutorialProvider())..getTutorials(),
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.white,
            title: Text(
              translateLang(context, "tut_con"),
              style: TextStyle(color: AppColors.primary),
            ),
            centerTitle: true,
            leading: ReturnButton()),
        body: BlocBuilder<TutorialCubit, TutorialState>(
          builder: (context, state) {
            if (state is TutorialLoadingState) {
              return AnimatedLoadingWidget(
                height: 150.0,
                width: 150.0,
              );
            }
            if (state is TutorialFailureState) {
              return FailureWidget(
                  showImage: true,
                  title: 'Error ocurred on getting tutorials !!!\n try again',
                  onTap: () {
                    context.read<TutorialCubit>().getTutorials();
                  });
            }

            return (state as TutorialSuccessState).tutorials.isEmpty
                ? EmptyDataWidget()
                : Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: Center(
                      child: ListView.separated(
                        itemCount: state.tutorials.length,
                        itemBuilder: (context, index) =>
                            TutorialCard(tutorial: state.tutorials[index]),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 5.0,
                        ),
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}

class TutorialCard extends StatelessWidget {
  final Tutorial tutorial;

  const TutorialCard({super.key, required this.tutorial});
  @override
  Widget build(BuildContext context) {
    var videoID = YoutubePlayer.convertUrlToId(tutorial.tuLink!);
    var videoImage = YoutubePlayer.getThumbnail(videoId: videoID!);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TutorialDisplayScreen(
                  videoID: videoID,
                )));
      },

      child: Card(
        color: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 200.0,
                width: double.infinity,
                child: CachedNetworkImage(
                  progressIndicatorBuilder: (context, url, progress) =>
                      AnimatedLoadingWidget(
                    height: 70.0,
                    width: 70.0,
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    AppImages.youtubePNG,
                    height: 200.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  // placeholder: (context, url) => Image.asset(
                  //   'assets/images/youtube.png',
                  //   height: 70.0,
                  //   width: 70.0,
                  // ),
                  placeholderFadeInDuration: const Duration(milliseconds: 600),
                  imageUrl: videoImage,
                  // height: 70.0,
                  // width: 70.0,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                tutorial.tuTitle!,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(color: AppColors.primary, fontSize: 22.0),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                tutorial.tuDesc!,
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ),
      ),
      //   child: Card(
      //     color: Colors.grey.shade100,
      //     child: ListTile(
      //       shape: RoundedRectangleBorder(),
      //       leading: SizedBox(
      //         height: 70.0,
      //         width: 70.0,
      //         child: CachedNetworkImage(
      //           progressIndicatorBuilder: (context, url, progress) =>
      //               AnimatedLoadingWidget(
      //             height: 70.0,
      //             width: 70.0,
      //           ),
      //           errorWidget: (context, url, error) => Image.asset(
      //             AppImages.youtubePNG,
      //             height: 100.0,
      //             width: 70.0,
      //             fit: BoxFit.cover,
      //           ),
      //           // placeholder: (context, url) => Image.asset(
      //           //   'assets/images/youtube.png',
      //           //   height: 70.0,
      //           //   width: 70.0,
      //           // ),
      //           placeholderFadeInDuration: const Duration(milliseconds: 600),
      //           imageUrl: videoImage,
      //           height: 70.0,
      //           width: 70.0,
      //           fit: BoxFit.cover,

      //         ),
      //       ),
      // title: Text(
      //   tutorial.tuTitle!,
      // ),
      // titleTextStyle: Theme.of(context)
      //     .textTheme
      //     .headlineLarge!
      //     .copyWith(color: AppColors.primary),
      // subtitle: Text(
      //   tutorial.tuDesc!,
      // ),
      // subtitleTextStyle: Theme.of(context).textTheme.headlineMedium,
      //  ),
      //  ),
    );
  }
}
