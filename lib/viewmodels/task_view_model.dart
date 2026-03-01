import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

import '../core/services/notification_service.dart';
import '../data/models/task_category.dart';
import '../data/models/task_model.dart';
import '../data/models/task_priority.dart';
import '../data/repositories/task_repository.dart';

enum TaskFilter { all, completed, pending }

class TaskViewModel extends ChangeNotifier {
  TaskViewModel(this._repository);

  final TaskRepository _repository;
  final _uuid = const Uuid();

  List<TaskModel> _tasks = [];
  bool _isLoading = false;
  String _query = '';
  TaskFilter _filter = TaskFilter.all;

  List<TaskModel> get tasks => _tasks;
  bool get isLoading => _isLoading;
  String get query => _query;
  TaskFilter get filter => _filter;

  List<TaskModel> get filteredTasks {
    var result = [..._tasks];

    switch (_filter) {
      case TaskFilter.completed:
        result = result.where((task) => task.isCompleted).toList();
      case TaskFilter.pending:
        result = result.where((task) => !task.isCompleted).toList();
      case TaskFilter.all:
        break;
    }

    if (_query.isNotEmpty) {
      final lower = _query.toLowerCase();
      result = result
          .where(
            (task) =>
                task.title.toLowerCase().contains(lower) ||
                task.description.toLowerCase().contains(lower) ||
                task.category.label.toLowerCase().contains(lower),
          )
          .toList();
    }

    result.sort((a, b) {
      if (a.isCompleted != b.isCompleted) {
        return a.isCompleted ? 1 : -1;
      }
      return a.dueDate.compareTo(b.dueDate);
    });

    return result;
  }

  Future<void> loadTasks() async {
    _isLoading = true;
    notifyListeners();

    _tasks = _repository.getTasks();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addTask({
    required String title,
    required String description,
    required TaskCategory category,
    required TaskPriority priority,
    required DateTime dueDate,
  }) async {
    HapticFeedback.mediumImpact();
    final task = TaskModel(
      id: _uuid.v4(),
      title: title,
      description: description,
      category: category,
      priority: priority,
      dueDate: dueDate,
    );

    await _repository.addTask(task);
    await NotificationService.instance.scheduleReminder(
      id: _notificationId(task.id),
      title: title,
      date: dueDate,
    );
    _tasks = _repository.getTasks();
    notifyListeners();
  }

  Future<void> editTask(TaskModel task) async {
    await _repository.updateTask(task);
    await NotificationService.instance.scheduleReminder(
      id: _notificationId(task.id),
      title: task.title,
      date: task.dueDate,
    );
    _tasks = _repository.getTasks();
    notifyListeners();
  }

  Future<void> deleteTask(TaskModel task) async {
    HapticFeedback.lightImpact();
    await _repository.deleteTask(task.id);
    await NotificationService.instance.cancelReminder(_notificationId(task.id));
    _tasks = _repository.getTasks();
    notifyListeners();
  }

  Future<void> toggleTask(TaskModel task) async {
    HapticFeedback.selectionClick();
    task.isCompleted = !task.isCompleted;
    await _repository.updateTask(task);
    _tasks = _repository.getTasks();
    notifyListeners();
  }

  Future<void> reorderTasks(int oldIndex, int newIndex) async {
    final visible = filteredTasks;
    if (newIndex > oldIndex) newIndex -= 1;

    final task = visible.removeAt(oldIndex);
    visible.insert(newIndex, task);

    _tasks = visible;
    await _repository.saveOrder(_tasks);
    notifyListeners();
  }

  void setSearch(String value) {
    _query = value;
    notifyListeners();
  }

  void setFilter(TaskFilter value) {
    _filter = value;
    notifyListeners();
  }

  Map<String, int> completionStats() {
    final completed = _tasks.where((task) => task.isCompleted).length;
    final pending = _tasks.length - completed;
    return {'Completed': completed, 'Pending': pending};
  }

  int _notificationId(String taskId) => taskId.hashCode & 0x7fffffff;
}
