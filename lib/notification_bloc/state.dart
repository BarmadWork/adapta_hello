import 'package:adapta_hello/models/notification_model.dart';

abstract class NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final List<NotificationModel> unhandled;
  final List<NotificationModel> inProgress;
  final List<NotificationModel> completed;
  final List<NotificationModel> all;

  NotificationLoaded({
    required this.unhandled,
    required this.inProgress,
    required this.completed,
    required this.all,
  });
}

class NotificationError extends NotificationState {
  final String message;

  NotificationError(this.message);
}
