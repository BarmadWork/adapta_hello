import 'package:adapta_hello/models/notification_model.dart';
import 'package:adapta_hello/notification_bloc/bloc.dart';
import 'package:adapta_hello/notification_bloc/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPage extends StatefulWidget {
  final NotificationModel notification;

  const DetailPage({super.key, required this.notification});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final today = DateTime(2025, 8, 30); // just for testing
    return Scaffold(
      appBar: AppBar(
        title: const Text('Melding ZorgDomein'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          if (widget.notification.status == NotificationStatus.inProgress)
            // Afronden button
            TextButton(
              child: Text(
                'Afronden',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                context.read<NotificationBloc>().add(
                  UpdateNotificationStatus(
                    id: widget.notification.id,
                    newStatus: NotificationStatus.completed,
                  ),
                );
                Navigator.of(context).pop();
              },
            ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // notification day
            Text(
              '${widget.notification.time.isBefore(today) ? 'Gisteren' : 'Vandaag'} - ${widget.notification.time.hour}:${widget.notification.time.minute.toString().padLeft(2, '0')}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),

            // notification status
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color:
                    widget.notification.status == NotificationStatus.unhandled
                    ? Colors.orange
                    : (widget.notification.status ==
                              NotificationStatus.inProgress
                          ? Colors.lightBlueAccent
                          : Colors.green),
              ),
              child: Row(
                children: [
                  Icon(
                    widget.notification.status == NotificationStatus.unhandled
                        ? Icons.warning
                        : widget.notification.status ==
                              NotificationStatus.inProgress
                        ? Icons.info
                        : Icons.check_circle_outline,
                    color: Colors.black87,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.notification.status == NotificationStatus.unhandled
                          ? "Nog niet opgepakt"
                          : widget.notification.status ==
                                NotificationStatus.inProgress
                          ? "Opgepakt door jou"
                          : "Afgerond door jou",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor:
                          widget.notification.status ==
                              NotificationStatus.unhandled
                          ? Colors.orangeAccent
                          : widget.notification.status ==
                                NotificationStatus.inProgress
                          ? Colors.lightBlue
                          : Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                    onPressed: () {
                      if (widget.notification.status ==
                          NotificationStatus.unhandled) {
                        context.read<NotificationBloc>().add(
                          UpdateNotificationStatus(
                            id: widget.notification.id,
                            newStatus: NotificationStatus.inProgress,
                          ),
                        );
                      } else if (widget.notification.status ==
                          NotificationStatus.inProgress) {
                        context.read<NotificationBloc>().add(
                          UpdateNotificationStatus(
                            id: widget.notification.id,
                            newStatus: NotificationStatus.unhandled,
                          ),
                        );
                      }
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      widget.notification.status == NotificationStatus.unhandled
                          ? "Pak op"
                          : widget.notification.status ==
                                NotificationStatus.inProgress
                          ? "Pak niet op"
                          : "",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // notification message
            Row(
              children: [
                const SizedBox(width: 16),
                Icon(Icons.message, color: Colors.black),
                const SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bericht uit team inbox",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Ontvangen aanvraagformulier\n"
                      "verpleging thuis met ZD-Nummer:\n"
                      "ZD100015706",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Open in ZorgDomein button
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.open_in_new, color: Colors.blue),
              label: const Text(
                "Open in ZorgDomein",
                style: TextStyle(color: Colors.blue),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.blue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
