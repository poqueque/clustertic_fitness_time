import 'package:fitness_time/screens/profile_page.dart';
import 'package:flutter/material.dart';

import '../models/activity.dart';
import '../styles/app_style.dart';
import '../widgets/activity_card.dart';
import 'new_activity.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Activity> activities = [];

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Actividades",
              style: AppStyles.bigTitle,
            ),
            if (activities.isEmpty)
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
            for (var activity in activities)
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
                      var index = activities.indexOf(activity);
                      activities[index] = returnedActivity;
                      setState(() {});
                    }
                  },
                  child: ActivityCard(activity: activity),
                ),
                onDismissed: (_) {
                  activities.remove(activity);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Actividad ${activity.type} eliminada"),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var activity = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ActivityDetail()));
          activities.add(activity);
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
