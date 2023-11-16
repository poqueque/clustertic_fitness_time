import 'package:flutter/material.dart';

import '../models/activity.dart';

class ActivityDetail<Activity> extends StatefulWidget {
  const ActivityDetail({super.key, this.activity});

  final Activity? activity;

  @override
  State<ActivityDetail> createState() => _ActivityDetailState();
}

class _ActivityDetailState extends State<ActivityDetail> {
  TextEditingController activityController = TextEditingController();
  TextEditingController distanceController = TextEditingController();

  @override
  void initState() {
    Activity? activity = widget.activity;
    super.initState();
    if (activity != null) {
      activityController.text = activity.type;
      distanceController.text = activity.distance.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    Activity? activity = widget.activity;
    return Scaffold(
        appBar: AppBar(
          title:
              Text((activity == null) ? "Nueva actividad" : "Edita actividad"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: activityController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Tipo de actividad',
                ),
              ),
              TextField(
                controller: distanceController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Distancia',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  var activityType = activityController.text;
                  var distance = distanceController.text;
                  var activity = Activity(
                    type: activityType,
                    date: DateTime.now(),
                    distance: double.tryParse(distance) ?? 0,
                  );
                  Navigator.pop(
                    context,
                    activity,
                  );
                },
                child: Text((activity == null)
                    ? "Añade Actividad"
                    : "Guarda Actividad"),
              )
            ],
          ),
        ));
  }
}
