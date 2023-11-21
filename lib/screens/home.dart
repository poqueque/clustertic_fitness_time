import 'package:fitness_time/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/activity.dart';
import '../models/app_data.dart';
import '../styles/app_style.dart';
import '../widgets/activity_card.dart';
import 'activity_detail.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: AppStyles.persianPink,
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        "https://randomuser.me/api/portraits/women/44.jpg"),
                  ),
                  Text("Antònia Font"),
                ],
              ),
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => const ProfilePage()));
              },
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Fitness Time 1.0.0",
                textAlign: TextAlign.end,
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Fitness Time"),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => const ProfilePage()));
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Hero(
                tag: "profile",
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://randomuser.me/api/portraits/women/44.jpg"),
                ),
              ),
            ),
          )
        ],
      ),
      body: Consumer<AppData>(builder: (context, data, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                "Actividades",
                style: AppStyles.bigTitle,
              ),
              if (data.activities.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(80.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.run_circle_outlined,
                        size: 120,
                        color: Colors.black45,
                      ),
                      Text(
                        "No hay actividades. Pulsa + per añadir una.",
                        style: AppStyles.subTitle,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              for (var activity in data.activities)
                Dismissible(
                  key: UniqueKey(),
                  child: InkWell(
                    onTap: () async {
                      var returnedActivity = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ActivityDetail(activity: activity)));
                      if (returnedActivity is Activity) {
                        data.editActivity(activity, returnedActivity);
                      }
                    },
                    onLongPress: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: const Icon(Icons.edit),
                                title: const Text("Editar actividad"),
                                onTap: () async {
                                  Navigator.pop(context);
                                  var returnedActivity = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ActivityDetail(
                                              activity: activity)));
                                  if (returnedActivity is Activity) {
                                    data.editActivity(
                                        activity, returnedActivity);
                                  }
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.delete),
                                title: const Text("Eliminar actividad"),
                                onTap: () {
                                  Navigator.pop(context);
                                  data.removeActivity(activity);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: ActivityCard(activity: activity),
                  ),
                  onDismissed: (_) {
                    data.removeActivity(activity);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            "Actividad ${activity.type.description} eliminada"),
                      ),
                    );
                  },
                ),
            ],
          ),
        );
      }),
      floatingActionButton: Consumer<AppData>(builder: (context, data, child) {
        return FloatingActionButton(
          onPressed: () async {
            var activity = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ActivityDetail()));
            data.addActivity(activity);
          },
          child: const Icon(Icons.add),
        );
      }),
    );
  }
}
