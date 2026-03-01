import 'package:hive/hive.dart';

import 'task_category.dart';
import 'task_priority.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.priority,
    required this.dueDate,
    this.isCompleted = false,
    this.createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  @HiveField(0)
  final String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  TaskCategory category;

  @HiveField(4)
  TaskPriority priority;

  @HiveField(5)
  DateTime dueDate;

  @HiveField(6)
  bool isCompleted;

  @HiveField(7)
  DateTime createdAt;
}

@HiveType(typeId: 1)
class TaskPriorityAdapter extends TypeAdapter<TaskPriority> {
  @override
  final int typeId = 1;

  @override
  TaskPriority read(BinaryReader reader) =>
      TaskPriority.values[reader.readByte()];

  @override
  void write(BinaryWriter writer, TaskPriority obj) =>
      writer.writeByte(obj.index);
}

@HiveType(typeId: 2)
class TaskCategoryAdapter extends TypeAdapter<TaskCategory> {
  @override
  final int typeId = 2;

  @override
  TaskCategory read(BinaryReader reader) =>
      TaskCategory.values[reader.readByte()];

  @override
  void write(BinaryWriter writer, TaskCategory obj) =>
      writer.writeByte(obj.index);
}
