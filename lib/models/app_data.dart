import 'package:flutter/foundation.dart';

import '../services/database.dart';
import 'activity.dart';

class AppData extends ChangeNotifier {
  List<Activity> activities = [];

  AppData() {
    init();
  }

  Future<void> init() async {
    activities = await Database.instance.getAllActivities();
    notifyListeners();
  }

  void addActivity(Activity activity) {
    activities.add(activity);
    Database.instance.updateActivity(activity);
    notifyListeners();
  }

  void removeActivity(Activity activity) {
    activities.remove(activity);
    Database.instance.removeActivity(activity);
    notifyListeners();
  }

  void editActivity(Activity activity, Activity newActivity) {
    var index = activities.indexOf(activity);
    activities[index] = newActivity;
    Database.instance.updateActivity(activity);
    notifyListeners();
  }

  String getTotalTime() {
    Duration total = Duration.zero;
    for (var activity in activities) {
      total += Duration(
          minutes: activity.durationMinutes, seconds: activity.durationSeconds);
    }
    return "${total.inHours.toString()}h "
        "${(total.inMinutes % 60).toString().padLeft(2, "0")}'";
  }

  String getTotalDistance() {
    double total = 0;
    for (var activity in activities) {
      total += activity.distance;
    }
    return total.toStringAsFixed(1);
  }

  String getTotalActivities() {
    return activities.length.toString();
  }
}
