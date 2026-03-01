import 'package:flutter/material.dart';

import '../../core/utils/date_formatter.dart';
import '../../data/models/task_model.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    required this.task,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
    super.key,
  });

  final TaskModel task;
  final ValueChanged<bool?> onToggle;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Dismissible(
      key: ValueKey(task.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: scheme.errorContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(Icons.delete_outline_rounded, color: scheme.onErrorContainer),
      ),
      onDismissed: (_) => onDelete(),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          onTap: onEdit,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          leading: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) =>
                ScaleTransition(scale: animation, child: child),
            child: Checkbox(
              key: ValueKey(task.isCompleted),
              value: task.isCompleted,
              onChanged: onToggle,
            ),
          ),
          title: Text(
            task.title,
            style: TextStyle(
              decoration:
                  task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
            ),
          ),
          subtitle: Text(
            '${task.category.label} • ${task.priority.label}\n${DateFormatter.format(task.dueDate)}',
          ),
          isThreeLine: true,
        ),
      ),
    );
  }
}
