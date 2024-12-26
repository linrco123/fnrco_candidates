import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final void Function() fun;
  final double elevation;
  final double height;
  final double width;
  final Color background;
  final Color foreground;
  final String text;
  final double textSize;

  const CustomElevatedButton(
      {super.key,
      required this.fun,
      this.elevation = 0,
      this.height = 60.0,
      this.width = double.infinity,
      required this.background,
      this.foreground = const Color(0xFFFFFFFF),
      required this.text,
      this.textSize = 18.0});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: fun,
      clipBehavior: Clip.antiAlias,
      style: ElevatedButton.styleFrom(
          elevation: elevation,
          backgroundColor: background,
          foregroundColor: foreground,
          minimumSize: Size(width, height),
          shape: const RoundedRectangleBorder(
              borderRadius:
                  BorderRadiusDirectional.all(Radius.circular(16.0)))),
      child: Text(
        textAlign: TextAlign.center,
        text,
        style: TextStyle(fontSize: textSize),
      ),
    );
  }
}
