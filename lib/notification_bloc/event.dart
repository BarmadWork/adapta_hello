import 'package:adapta_hello/models/notification_model.dart';

abstract class NotificationEvent {}

class LoadNotifications extends NotificationEvent {}

class UpdateNotificationStatus extends NotificationEvent {
  final String id;
  final NotificationStatus newStatus;

  UpdateNotificationStatus({required this.id, required this.newStatus});
}
