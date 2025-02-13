import '../../constants/enums.dart';

class NotificationModel {
  final String title;
  final String body;
  final ScreenCode screenCode;

  NotificationModel(
      {required this.title, required this.body, required this.screenCode});
}
