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
  TextEditingController distanceController = TextEditingController();
  TextEditingController minutesController = TextEditingController();
  TextEditingController secondsController = TextEditingController();

  Duration duration = Duration.zero;

  int selectedItem = -1;

  @override
  void initState() {
    Activity? activity = widget.activity;
    super.initState();
    if (activity != null) {
      selectedItem = Activity.types.indexOf(activity.type);
      distanceController.text = activity.distance.toString();
      minutesController.text = activity.duration.inMinutes.toString();
      secondsController.text =
          (activity.duration.inSeconds % 60).toString().padLeft(2, "0");
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: distanceController,
                      decoration: const InputDecoration(
                        hintText: "0",
                        label: Text("Distancia"),
                        suffixText: "Km",
                      ),
                      textAlign: TextAlign.center,
                      style: AppStyles.bigTitle,
                      keyboardType: TextInputType.numberWithOptions(),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: minutesController,
                      decoration: const InputDecoration(
                        hintText: "0",
                        label: Text("Minutos"),
                      ),
                      textAlign: TextAlign.center,
                      style: AppStyles.bigTitle,
                      keyboardType: TextInputType.number,
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(":", style: AppStyles.bigTitle),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: secondsController,
                      decoration: const InputDecoration(
                        hintText: "0",
                        label: Text("Segundos"),
                      ),
                      textAlign: TextAlign.center,
                      style: AppStyles.bigTitle,
                      keyboardType: TextInputType.number,
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: (selectedItem >= 0 &&
                        distanceController.text.isNotEmpty &&
                        minutesController.text.isNotEmpty &&
                        secondsController.text.isNotEmpty)
                    ? () {
                        var distance = distanceController.text;
                        var activity = Activity(
                            type: Activity.types[selectedItem],
                            date: DateTime.now(),
                            distance: double.tryParse(
                                    distance.replaceAll(",", ".")) ??
                                0,
                            duration: Duration(
                              minutes:
                                  int.tryParse(minutesController.text) ?? 0,
                              seconds:
                                  int.tryParse(secondsController.text) ?? 0,
                            ));
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
