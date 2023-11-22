import 'package:flutter/foundation.dart';

import 'activity.dart';

class AppData extends ChangeNotifier {
  List<Activity> activities = [];

  void addActivity(Activity activity) {
    activities.add(activity);
    notifyListeners();
  }

  void removeActivity(Activity activity) {
    activities.remove(activity);
    notifyListeners();
  }

  void editActivity(Activity activity, Activity newActivity) {
    var index = activities.indexOf(activity);
    activities[index] = newActivity;
    notifyListeners();
  }

  String getTotalTime() {
    Duration total = Duration.zero;
    for (var activity in activities) {
      total += activity.duration;
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
