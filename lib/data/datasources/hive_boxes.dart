import 'package:hive_flutter/hive_flutter.dart';

import '../models/task_model.dart';

class HiveBoxes {
  static const String taskBoxName = 'tasks_box';

  static Box<TaskModel> get taskBox => Hive.box<TaskModel>(taskBoxName);

  static Future<void> init() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TaskModelAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(TaskPriorityAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskCategoryAdapter());
    }

    await Hive.openBox<TaskModel>(taskBoxName);
  }
}
