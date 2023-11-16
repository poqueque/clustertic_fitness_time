import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/activity.dart';
import '../styles/app_style.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({super.key, required this.activity});
  final Activity activity;

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd MMM yyyy - HH:mm');
    final String formattedDate = formatter.format(activity.date);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.run_circle_outlined,
                size: 32,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.type,
                  style: AppStyles.dataText,
                ),
                Text(formattedDate),
              ],
            ),
            const Spacer(),
            Text(
              "${activity.distance} km",
              style: AppStyles.dataText,
            ),
          ],
        ),
      ),
    );
  }
}
