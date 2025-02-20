import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

animatedTransition(BuildContext context, Widget screen) => Navigator.push(
    context,
    PageTransition(
        child: screen,
        type: PageTransitionType.fade,
        alignment: Alignment.centerLeft,
        duration: const Duration(seconds: 1)));
