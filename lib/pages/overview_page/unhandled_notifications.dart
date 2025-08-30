import 'package:adapta_hello/notification_bloc/bloc.dart';
import 'package:adapta_hello/notification_bloc/event.dart';
import 'package:adapta_hello/notification_bloc/state.dart';
import 'package:adapta_hello/widgets/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UnhandledNotifications extends StatefulWidget {
  const UnhandledNotifications({super.key});

  @override
  State<UnhandledNotifications> createState() => _UnhandledNotificationsState();
}

class _UnhandledNotificationsState extends State<UnhandledNotifications> {
  // Map color names to Material colors
  Color _mapColor(String colorName) {
    switch (colorName) {
      case "red":
        return Colors.red;
      case "yellow":
        return Colors.orange; // better visible
      case "green":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  // Map icon names to Material icons
  IconData _mapIcon(String iconName) {
    switch (iconName) {
      case "notification_important_outlined":
        return Icons.notification_important_outlined;
      case "notifications_outlined":
        return Icons.notifications_outlined;
      default:
        return Icons.notifications_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Trigger loading notifications
    context.read<NotificationBloc>().add(LoadNotifications());

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16.0),
      color: Colors.grey[200],
      child: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading) {
            return Center(child: CircularProgressIndicator(color: Colors.blue));
          } else if (state is NotificationLoaded) {
            // in real use, get current date
            final today = DateTime(2025, 8, 30);
            final yesterday = today.subtract(Duration(days: 1));

            // today's notifications
            final todayNotifications = state.notifications.where((n) {
              final notifTime = DateTime.parse(n['time']);
              return notifTime.year == today.year &&
                  notifTime.month == today.month &&
                  notifTime.day == today.day;
            }).toList();

            // yesterday's notifications
            final yesterdayNotifications = state.notifications.where((n) {
              final notifTime = DateTime.parse(n['time']);
              return notifTime.year == yesterday.year &&
                  notifTime.month == yesterday.month &&
                  notifTime.day == yesterday.day;
            }).toList();

            return ListView.builder(
              itemCount:
                  todayNotifications.length + yesterdayNotifications.length + 2,
              itemBuilder: (context, index) {
                // today's notifications
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
                } else if (0 < index && index < todayNotifications.length + 1) {
                  final notification = todayNotifications[index - 1];
                  return NotificationCard(
                    time: notification['time'],
                    title: notification['title'],
                    subtitle: notification['subtitle'],
                    icon: _mapIcon(notification['icon']),
                    stripeColor: _mapColor(notification['color']),
                    onTap: () {},
                  );
                }
                // yesterday's notifications
                else if (index == todayNotifications.length + 1) {
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
                    time: notification['time'],
                    title: notification['title'],
                    subtitle: notification['subtitle'],
                    icon: _mapIcon(notification['icon']),
                    stripeColor: _mapColor(notification['color']),
                    onTap: () {},
                  );
                } else {
                  return const SizedBox.shrink();
                }
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
