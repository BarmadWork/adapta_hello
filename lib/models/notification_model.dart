import 'package:flutter/material.dart';

enum NotificationStatus { unhandled, inProgress, completed }

class NotificationModel {
  final String id;
  final String title;
  final Color stripeColor;
  final IconData icon;
  final String subtitle;
  final DateTime time;
  NotificationStatus status;

  NotificationModel({
    required this.id,
    required this.title,
    required this.stripeColor,
    required this.icon,
    required this.subtitle,
    required this.time,
    this.status = NotificationStatus.unhandled,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      stripeColor: json['color'] == 'orange'
          ? Colors.orange
          : json['color'] == 'red'
          ? Colors.red
          : Colors.green,
      icon: json['icon'] == 'notifications_outlined'
          ? Icons.notifications_outlined
          : json['icon'] == 'notification_important_outlined'
          ? Icons.notification_important_outlined
          : Icons.info_outline,
      subtitle: json['subtitle'],
      time: DateTime.parse(json['time']),
      status: json['status'] == 'unhandled'
          ? NotificationStatus.unhandled
          : json['status'] == 'inProgress'
          ? NotificationStatus.inProgress
          : NotificationStatus.completed,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'subtitle': subtitle,
    'icon': icon == Icons.notifications_outlined
        ? 'notifications_outlined'
        : icon == Icons.notification_important_outlined
        ? 'notification_important_outlined'
        : 'info_outline',
    'color': stripeColor == Colors.orange
        ? 'orange'
        : stripeColor == Colors.red
        ? 'red'
        : 'green',
    'time': time.toIso8601String(),
    'status': status == NotificationStatus.unhandled
        ? 'unhandled'
        : status == NotificationStatus.inProgress
        ? 'inProgress'
        : 'completed',
  };
}
