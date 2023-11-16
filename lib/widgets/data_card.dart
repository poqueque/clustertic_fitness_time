import 'package:flutter/material.dart';

import '../styles/app_style.dart';

class DataCard extends StatelessWidget {
  const DataCard({
    super.key,
    required this.iconData,
    required this.titleLabel,
    required this.contentLabel,
  });

  final IconData iconData;
  final String titleLabel;
  final String contentLabel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: AppStyles.heliotrope,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Icon(iconData),
            Text(titleLabel),
            Text(
              contentLabel,
              style: AppStyles.dataText,
            ),
          ],
        ),
      ),
    );
  }
}
