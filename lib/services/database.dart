import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/activity.dart';

class Database {
  static final Database _singleton = Database._internal();
  factory Database() => _singleton;
  Database._internal();
  static Database get instance => _singleton;

  Isar? isar;

  Future<Isar> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [ActivitySchema],
      directory: dir.path,
    );
    return isar!;
  }

  Future<List<Activity>> getAllActivities() async {
    isar ??= await init();
    return isar!.activitys.where().findAll();
  }

  Future<void> updateActivity(Activity activity) async {
    isar ??= await init();
    await isar!.writeTxn(() async {
      isar!.activitys.put(activity);
    });
  }

  Future<void> removeActivity(Activity activity) async {
    isar ??= await init();
    await isar!.writeTxn(() async {
      isar!.activitys.delete(activity.id);
    });
  }
}
