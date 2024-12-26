import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../core/functions/translate.dart';
import '../../widgets/return_btn.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TutorialDisplayScreen extends StatefulWidget {
  final String videoID;
  const TutorialDisplayScreen({super.key, required this.videoID});

  @override
  State<TutorialDisplayScreen> createState() => _TutorialDisplayState();
}

class _TutorialDisplayState extends State<TutorialDisplayScreen> {
  YoutubePlayerController? _youtubePlayerController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      _youtubePlayerController = YoutubePlayerController(
          initialVideoId: widget.videoID,
          flags: YoutubePlayerFlags(
            autoPlay: true,
            mute: false
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // backgroundColor: AppColors.white,
          title: Text(
            translateLang(context, "tut_vid"),
            style: TextStyle(color: AppColors.primary),
          ),
          centerTitle: true,
          leading: ReturnButton()),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (_youtubePlayerController != null)
              YoutubePlayer(
                controller: _youtubePlayerController!,
                showVideoProgressIndicator: true,
                progressIndicatorColor: AppColors.primary,
                progressColors: ProgressBarColors(
                  playedColor: AppColors.primary,
                  handleColor: AppColors.black,
                ),
                onReady: () {
                  _youtubePlayerController!.addListener(() {});
                },
              ),
          ],
        ),
      ),
    );
  }
}
