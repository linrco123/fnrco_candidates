import 'package:flutter/material.dart';
import '../../constants/app_images_path.dart';
import '../../core/functions/translate.dart';

class CustomFlutterErrorWidget extends StatelessWidget {
  const CustomFlutterErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        children: [
          Image(
            image: AssetImage(AppImages.flutter_error),
            height: 50.0,
          ),
          SizedBox(height: 20.0),
          Text(
            translateLang(context,"error_occurred_later"),
            style: TextStyle(fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}
