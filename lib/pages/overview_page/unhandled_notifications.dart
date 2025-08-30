import 'package:adapta_hello/widgets/notification_card.dart';
import 'package:flutter/material.dart';

class UnhandledNotifications extends StatefulWidget {
  const UnhandledNotifications({super.key});

  @override
  State<UnhandledNotifications> createState() => _UnhandledNotificationsState();
}

class _UnhandledNotificationsState extends State<UnhandledNotifications> {
  // mock notifications data
  List<dynamic> todayNotifications = [
    {
      "title": "Aanvraagformulier ontvangen",
      "subtitle": "Ontvangen aanvraagformulier verpleging thuis",
      "icon": "notifications_outlined",
      "color": "yellow",
      "time": "2025-08-30T11:40:00",
    },
  ];

  List<dynamic> yesterdayNotifications = [
    {
      "title": "S. Tetteren",
      "subtitle":
          "Het deksel is niet gesloten en de medicatie kan daardoor niet worden uitgegeven.",
      "icon": "notification_important_outlined",
      "color": "red",
      "time": "2025-08-29T13:45:00",
    },
    {
      "title": "C. Tan",
      "subtitle":
          "Controleer de alarmfunctionaliteit. Het alarm dat ontstaat kan veilig worden genegeerd.",
      "icon": "notification_important_outlined",
      "color": "red",
      "time": "2025-08-29T14:40:00",
    },
  ];

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
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16.0),
      color: Colors.grey[200],
      child: ListView.builder(
        itemCount:
            todayNotifications.length + yesterdayNotifications.length + 2,
        itemBuilder: (context, index) {
          // Today's notifications
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
          // Yesterday's notifications
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
                yesterdayNotifications[index - (todayNotifications.length + 2)];
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
      ),
    );
  }
}
