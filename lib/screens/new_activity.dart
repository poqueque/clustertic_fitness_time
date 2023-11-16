import 'package:flutter/material.dart';

import '../models/activity.dart';

class NewActivity extends StatefulWidget {
  const NewActivity({super.key});

  @override
  State<NewActivity> createState() => _NewActivityState();
}

class _NewActivityState extends State<NewActivity> {
  TextEditingController activityController = TextEditingController();
  TextEditingController distanceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Nueva actividad"),
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
                child: const Text("Añade Actividad"),
              )
            ],
          ),
        ));
  }
}
