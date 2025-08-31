import 'package:adapta_hello/models/notification_model.dart';
import 'package:adapta_hello/notification_bloc/bloc.dart';
import 'package:adapta_hello/notification_bloc/event.dart';
import 'package:adapta_hello/notification_bloc/state.dart';
import 'package:adapta_hello/pages/overview_page/notifications_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Overview extends StatefulWidget {
  const Overview({super.key});

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  @override
  void initState() {
    super.initState();
    // Trigger loading notifications
    context.read<NotificationBloc>().add(LoadNotifications());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meldingen'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Container(
              color: Colors.blue,
              child: Stack(
                children: [
                  TabBar(
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white70,
                    indicatorColor: Colors.white,
                    tabs: [
                      // Openstaand tab
                      Tab(
                        text: 'Openstaand',
                        icon: Stack(
                          children: [
                            Icon(Icons.notifications),
                            BlocBuilder<NotificationBloc, NotificationState>(
                              builder: (context, state) {
                                int count = 0;
                                if (state is NotificationLoaded) {
                                  count = state.unhandled.length;
                                  return count > 0
                                      ? Container(
                                          margin: EdgeInsets.only(left: 16),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          constraints: BoxConstraints(
                                            minWidth: 14,
                                            minHeight: 14,
                                          ),
                                          child: Text(
                                            '$count',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 9,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      : SizedBox.shrink();
                                } else {
                                  return SizedBox.shrink();
                                }
                              },
                            ),
                          ],
                        ),
                      ),

                      // Mee bezig tab
                      Tab(
                        text: 'Mee bezig',
                        icon: Stack(
                          children: [
                            Icon(Icons.access_time),
                            BlocBuilder<NotificationBloc, NotificationState>(
                              builder: (context, state) {
                                int count = 0;
                                if (state is NotificationLoaded) {
                                  count = state.inProgress.length;

                                  return count > 0
                                      ? Container(
                                          margin: EdgeInsets.only(left: 16),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          constraints: BoxConstraints(
                                            minWidth: 14,
                                            minHeight: 14,
                                          ),
                                          child: Text(
                                            '$count',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 9,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      : SizedBox.shrink();
                                } else {
                                  return SizedBox.shrink();
                                }
                              },
                            ),
                          ],
                        ),
                      ),

                      // Afgerond tab
                      Tab(
                        text: 'Afgerond',
                        icon: Icon(Icons.check_circle_outline),
                      ),
                    ],
                  ),

                  // tab dividers
                  Positioned.fill(
                    child: Row(
                      children: [
                        Expanded(child: Container()),
                        Container(width: 1, color: Colors.white24),
                        Expanded(child: Container()),
                        Container(width: 1, color: Colors.white24),
                        Expanded(child: Container()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  NotificationList(status: NotificationStatus.unhandled),
                  NotificationList(status: NotificationStatus.inProgress),
                  NotificationList(status: NotificationStatus.completed),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
