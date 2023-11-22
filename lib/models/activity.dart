import 'package:flutter/material.dart';

class Activity {
  static List<ActivityType> types = [
    ActivityType.walk,
    ActivityType.run,
    ActivityType.bike
  ];
  final ActivityType type;
  final DateTime date;
  final double distance;
  final int durationMinutes;
  final int durationSeconds;

  Activity({
    required this.type,
    required this.date,
    required this.distance,
    required this.durationMinutes,
    required this.durationSeconds,
  });
}

enum ActivityType {
  walk("Caminar", Icons.directions_walk),
  run("Correr", Icons.directions_run),
  bike("Bicicleta", Icons.directions_bike);

  final String description;
  final IconData iconData;

  const ActivityType(this.description, this.iconData);
}
