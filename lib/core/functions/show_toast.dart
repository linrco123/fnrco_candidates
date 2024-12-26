import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'package:toastification/toastification.dart';

showToast(context,
        {required String title,
        required String desc,
        required ToastificationType type}) =>
    Toastification().show(
      context: context, // optional if you use ToastificationWrapper
      type: type,
      style: ToastificationStyle.fillColored,
      autoCloseDuration: const Duration(milliseconds: 1300),
      title: Text(title, style: TextStyle(color: AppColors.white)),
      // you can also use RichText widget for title and description parameters
      description: RichText(
          text: TextSpan(text: desc, style: TextStyle(color: AppColors.white))),
      alignment: Alignment.topRight,
      direction: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 600),
      animationBuilder: (context, animation, alignment, child) {
        final overlay = Overlay.of(context);
        final overlayState = overlay.context.findRenderObject() as RenderBox;
        return SlideTransition(
          position: Tween<Offset>(
                  begin: Offset(
                    0,
                    0,
                  ),
                  end: Offset(0, 1))
              .animate(AnimationController(
                  vsync: overlay, duration: const Duration(milliseconds: 600))),
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
      showProgressBar: false,
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
