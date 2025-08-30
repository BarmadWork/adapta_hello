import 'package:adapta_hello/pages/overview_page/unhandled_notifications.dart';
import 'package:flutter/material.dart';

class Overview extends StatefulWidget {
  const Overview({super.key});

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
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
                      Tab(
                        text: 'Openstaand',
                        icon: Stack(
                          children: [
                            Icon(Icons.notifications),
                            Container(
                              margin: EdgeInsets.only(left: 16),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 14,
                                minHeight: 14,
                              ),
                              child: const Text(
                                '3',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Tab(
                        text: 'Mee bezig',
                        icon: Stack(
                          children: [
                            Icon(Icons.access_time),
                            Container(
                              margin: EdgeInsets.only(left: 16),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 14,
                                minHeight: 14,
                              ),
                              child: const Text(
                                '2',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
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
                  UnhandledNotifications(),
                  Center(child: Text('Mee bezig')),
                  Center(child: Text('Afgerond')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
