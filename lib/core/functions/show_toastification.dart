import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:toastification/toastification.dart';

showToast(context,
        {required String title,
        required String desc,
        required ToastificationType type}) =>
    Toastification().show(
      context: context, // optional if you use ToastificationWrapper
      type: type,
      style: ToastificationStyle.fillColored,
      autoCloseDuration: const Duration(seconds: 5),
      title: Text(title, style: TextStyle(color: AppColors.white)),
      // you can also use RichText widget for title and description parameters
      description: RichText(
          text: TextSpan(text: desc, style: TextStyle(color: AppColors.white))),
      alignment: Alignment.topRight,
      direction: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 600),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      //icon: const Icon(Icons.check),
      showIcon: true, // show or hide the icon
      // primaryColor: Colors.green,
      // backgroundColor: Colors.green,
      // foregroundColor: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
          spreadRadius: 0,
        )
      ],
      //showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      //applyBlurEffect: true,
      callbacks: ToastificationCallbacks(
        onTap: (toastItem) => print('Toast ${toastItem.id} tapped'),
        onCloseButtonTap: (toastItem) =>
            print('Toast ${toastItem.id} close button tapped'),
        onAutoCompleteCompleted: (toastItem) =>
            print('Toast ${toastItem.id} auto complete completed'),
        onDismissed: (toastItem) => print('Toast ${toastItem.id} dismissed'),
      ),
    );
