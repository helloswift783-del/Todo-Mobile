import 'package:hive/hive.dart';

import '../models/task_model.dart';

class TaskRepository {
  TaskRepository(this._box);

  final Box<TaskModel> _box;

  List<TaskModel> getTasks() => _box.values.toList();

  Future<void> addTask(TaskModel task) async => _box.put(task.id, task);

  Future<void> updateTask(TaskModel task) async => _box.put(task.id, task);

  Future<void> deleteTask(String id) async => _box.delete(id);

  Future<void> saveOrder(List<TaskModel> tasks) async {
    final map = {for (final task in tasks) task.id: task};
    await _box.putAll(map);
  }
}
