import 'package:fitness_time/styles/app_style.dart';
import 'package:flutter/material.dart';

import '../widgets/data_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
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
              child: CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(
                  "https://randomuser.me/api/portraits/women/44.jpg",
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DataCard(
                  iconData: Icons.access_alarm,
                  titleLabel: "Time",
                  contentLabel: "2h 45'",
                ),
                DataCard(
                  iconData: Icons.place,
                  titleLabel: "Km",
                  contentLabel: "212,4",
                ),
                DataCard(
                  iconData: Icons.home,
                  titleLabel: "Activities",
                  contentLabel: "42",
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Height"),
                Slider(
                  min: 100,
                  max: 250,
                  value: 150,
                  activeColor: AppStyles.heliotrope,
                  onChanged: (value) {},
                ),
                const Text("150 cm"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Weight"),
                Slider(
                  min: 40,
                  max: 100,
                  value: 55,
                  activeColor: AppStyles.heliotrope,
                  onChanged: (value) {},
                ),
                const Text("55 kg"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
