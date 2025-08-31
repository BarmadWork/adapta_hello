import 'package:adapta_hello/models/notification_model.dart';
import 'package:adapta_hello/notification_bloc/bloc.dart';
import 'package:adapta_hello/notification_bloc/state.dart';
import 'package:adapta_hello/pages/detain_page.dart';
import 'package:adapta_hello/widgets/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationList extends StatefulWidget {
  final NotificationStatus status;
  const NotificationList({super.key, required this.status});

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  Widget build(BuildContext context) {
    // in real use, get current date
    final today = DateTime(2025, 8, 30);
    final yesterday = today.subtract(Duration(days: 1));

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16.0),
      color: Colors.grey[200],
      child: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading) {
            return Center(child: CircularProgressIndicator(color: Colors.blue));
          } else if (state is NotificationLoaded) {
            final notifications = widget.status == NotificationStatus.unhandled
                ? state.unhandled
                : widget.status == NotificationStatus.inProgress
                ? state.inProgress
                : state.completed;

            // today's notifications
            final todayNotifications = notifications.where((n) {
              final notifTime = n.time;
              return notifTime.year == today.year &&
                  notifTime.month == today.month &&
                  notifTime.day == today.day;
            }).toList();

            // yesterday's notifications
            final yesterdayNotifications = notifications.where((n) {
              final notifTime = n.time;
              return notifTime.year == yesterday.year &&
                  notifTime.month == yesterday.month &&
                  notifTime.day == yesterday.day;
            }).toList();

            return ListView.builder(
              itemCount:
                  todayNotifications.length + yesterdayNotifications.length + 2,
              itemBuilder: (context, index) {
                // today's notifications
                if (todayNotifications.isNotEmpty) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        'Vandaag',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    );
                  } else if (0 < index &&
                      index < todayNotifications.length + 1) {
                    final notification = todayNotifications[index - 1];
                    return NotificationCard(
                      time: notification.time.toIso8601String(),
                      title: notification.title,
                      subtitle: notification.subtitle,
                      icon: notification.icon,
                      stripeColor: notification.stripeColor,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                DetainPage(notification: notification),
                          ),
                        );
                      },
                    );
                  }
                }
                // yesterday's notifications
                if (yesterdayNotifications.isNotEmpty) {
                  if (index == todayNotifications.length + 1) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        'Gisteren',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    );
                  } else if (index > todayNotifications.length + 1 &&
                      index <
                          todayNotifications.length +
                              yesterdayNotifications.length +
                              2) {
                    final notification =
                        yesterdayNotifications[index -
                            (todayNotifications.length + 2)];
                    return NotificationCard(
                      time: notification.time.toIso8601String(),
                      title: notification.title,
                      subtitle: notification.subtitle,
                      icon: notification.icon,
                      stripeColor: notification.stripeColor,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                DetainPage(notification: notification),
                          ),
                        );
                      },
                    );
                  }
                }
                return const SizedBox.shrink();
              },
            );
          } else if (state is NotificationError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Onbekende status'));
          }
        },
      ),
    );
  }
}
