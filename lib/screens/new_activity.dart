import 'package:fitness_time/styles/app_style.dart';
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

  int selectedItem = -1;

  @override
  void initState() {
    Activity? activity = widget.activity;
    super.initState();
    if (activity != null) {
      selectedItem = Activity.types.indexOf(activity.type);
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var activityType in Activity.types)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedItem = Activity.types.indexOf(activityType);
                        });
                      },
                      child: Card(
                        color:
                            selectedItem == Activity.types.indexOf(activityType)
                                ? AppStyles.heliotrope
                                : null,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Icon(activityType.iconData),
                              Text(activityType.description),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              const Align(
                  alignment: Alignment.centerLeft, child: Text("Distancia")),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: distanceController,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                      ),
                      textAlign: TextAlign.center,
                      style: AppStyles.bigTitle,
                      keyboardType: TextInputType.number,
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                  const Column(
                    children: [
                      Text(
                        "Km",
                        style: AppStyles.bigTitle,
                      ),
                      SizedBox(
                        height: 11,
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed:
                    (selectedItem >= 0 && distanceController.text.isNotEmpty)
                        ? () {
                            var distance = distanceController.text;
                            var activity = Activity(
                              type: Activity.types[selectedItem],
                              date: DateTime.now(),
                              distance: double.tryParse(distance) ?? 0,
                            );
                            Navigator.pop(
                              context,
                              activity,
                            );
                          }
                        : null,
                child: Text((activity == null)
                    ? "Añade Actividad"
                    : "Guarda Actividad"),
              )
            ],
          ),
        ));
  }
}
