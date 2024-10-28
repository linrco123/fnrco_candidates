import 'package:flutter/material.dart';
 
class CurrentPageIndicator extends StatelessWidget {
  final int currentPage;
  final List<dynamic> list;
  final MainAxisAlignment alignment;
  final Color color;
  CurrentPageIndicator(
      {super.key,
      required this.currentPage,
      required this.list,
      required this.alignment,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      children: list
          .map((item) => AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: currentPage == list.indexOf(item) ? 30 : 8,
                height: 8,
                margin: const EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                    color:color,
                    borderRadius: BorderRadius.circular(10.0)),
              ))
          .toList(),
    );
  }
}
