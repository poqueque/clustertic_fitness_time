import 'package:fitness_time/styles/app_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/app_data.dart';
import '../widgets/data_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var height = 150.0;
  var weight = 55.0;
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<AppData>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Hero(
                tag: 'profile',
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: NetworkImage(
                    "https://randomuser.me/api/portraits/women/44.jpg",
                  ),
                ),
              ),
            ),
            const Text(
              'Antònia Font',
              style: AppStyles.bigTitle,
            ),
            const Text(
              'registered 20 April 2023',
              style: AppStyles.subTitle,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DataCard(
                  iconData: Icons.access_alarm,
                  titleLabel: "Time",
                  contentLabel: data.getTotalTime(),
                ),
                DataCard(
                  iconData: Icons.place,
                  titleLabel: "Km",
                  contentLabel: data.getTotalDistance(),
                ),
                DataCard(
                  iconData: Icons.home,
                  titleLabel: "Activities",
                  contentLabel: data.getTotalActivities(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Height"),
                Slider(
                  min: 140,
                  max: 210,
                  value: height,
                  activeColor: AppStyles.heliotrope,
                  onChanged: (value) {
                    height = value;
                    setState(() {});
                  },
                ),
                Text("${height.round()} cm"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Weight"),
                Slider(
                  min: 40,
                  max: 120,
                  value: weight,
                  activeColor: AppStyles.heliotrope,
                  onChanged: (value) {
                    weight = value;
                    setState(() {});
                  },
                ),
                Text("${weight.round()} kg"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
