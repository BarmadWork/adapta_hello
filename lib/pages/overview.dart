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
                      Tab(text: 'Openstaand', icon: Icon(Icons.notifications)),
                      Tab(text: 'Mee bezig', icon: Icon(Icons.access_time)),
                      Tab(
                        text: 'Afgerond',
                        icon: Icon(Icons.check_circle_outline),
                      ),
                    ],
                  ),
                  // dividers
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
                  Center(child: Text('Openstaand')),
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
