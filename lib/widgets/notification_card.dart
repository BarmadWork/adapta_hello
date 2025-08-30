import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final String time;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color stripeColor;
  final VoidCallback? onTap;

  const NotificationCard({
    super.key,
    required this.time,
    required this.title,
    required this.subtitle,
    this.icon = Icons.notifications_outlined,
    this.stripeColor = Colors.orange,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // time
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(
            '${DateTime.parse(time).hour}:${DateTime.parse(time).minute.toString().padLeft(2, '0')}',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
          color: stripeColor,
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 12),
                child: ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    overlayColor: stripeColor,
                    shadowColor: Colors.transparent,
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 8),

                      // leading icon
                      Icon(icon, color: stripeColor),

                      // notification info
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // title
                              Text(
                                title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 2),

                              // subtitle
                              Text(
                                subtitle,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black.withAlpha(180),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // trailing icon
                      const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.chevron_right, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),

              // top right icon
              Positioned(
                top: 6,
                right: 4,
                child: Icon(
                  Icons.question_mark_rounded,
                  color: Colors.grey,
                  size: 16,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),
      ],
    );
  }
}
