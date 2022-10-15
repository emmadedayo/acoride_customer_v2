import '../../core/constant/enum.dart';

const FIELD_NOTIFICATION_TYPE = 'type';

class NotificationItem {

  NotificationMode mode;
  String title, description;

  NotificationItem({this.mode: NotificationMode.External, this.title: '', this.description: ''});
}