import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/task_model.dart';
import '../../routes/app_router.dart';
import '../../viewmodels/task_view_model.dart';
import '../../viewmodels/theme_view_model.dart';
import '../widgets/animated_empty_state.dart';
import '../widgets/gradient_background.dart';
import '../widgets/task_form_sheet.dart';
import '../widgets/task_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<TaskViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Mobile'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AppRouter.stats),
            icon: const Icon(Icons.bar_chart_rounded),
          ),
          Switch(
            value: Theme.of(context).brightness == Brightness.dark,
            onChanged: context.read<ThemeViewModel>().toggleTheme,
          ),
        ],
      ),
      body: GradientBackground(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                onChanged: vm.setSearch,
                decoration: const InputDecoration(
                  hintText: 'Search tasks...',
                  prefixIcon: Icon(Icons.search_rounded),
                ),
              ),
            ),
            SizedBox(
              height: 56,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  const SizedBox(width: 12),
                  FilterChip(
                    label: const Text('All'),
                    selected: vm.filter == TaskFilter.all,
                    onSelected: (_) => vm.setFilter(TaskFilter.all),
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text('Completed'),
                    selected: vm.filter == TaskFilter.completed,
                    onSelected: (_) => vm.setFilter(TaskFilter.completed),
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text('Pending'),
                    selected: vm.filter == TaskFilter.pending,
                    onSelected: (_) => vm.setFilter(TaskFilter.pending),
                  ),
                ],
              ),
            ),
            Expanded(
              child: vm.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : vm.filteredTasks.isEmpty
                      ? const AnimatedEmptyState()
                      : ReorderableListView.builder(
                          padding: const EdgeInsets.all(12),
                          itemCount: vm.filteredTasks.length,
                          onReorder: vm.reorderTasks,
                          itemBuilder: (_, index) {
                            final task = vm.filteredTasks[index];
                            return Padding(
                              key: ValueKey(task.id),
                              padding: const EdgeInsets.only(bottom: 8),
                              child: TaskTile(
                                task: task,
                                onToggle: (_) => vm.toggleTask(task),
                                onDelete: () => vm.deleteTask(task),
                                onEdit: () => _showTaskSheet(context, vm, task),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
      floatingActionButton: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.8, end: 1),
        duration: const Duration(milliseconds: 600),
        curve: Curves.elasticOut,
        builder: (_, scale, child) => Transform.scale(scale: scale, child: child),
        child: FloatingActionButton.extended(
          onPressed: () => _showTaskSheet(context, vm, null),
          icon: const Icon(Icons.add_rounded),
          label: const Text('Add Task'),
        ),
      ),
    );
  }

  Future<void> _showTaskSheet(
    BuildContext context,
    TaskViewModel vm,
    TaskModel? task,
  ) async {
    final result = await showModalBottomSheet<TaskFormResult>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => TaskFormSheet(initialTask: task),
    );

    if (result == null) return;

    if (task == null) {
      await vm.addTask(
        title: result.title,
        description: result.description,
        category: result.category,
        priority: result.priority,
        dueDate: result.dueDate,
      );
    } else {
      task
        ..title = result.title
        ..description = result.description
        ..category = result.category
        ..priority = result.priority
        ..dueDate = result.dueDate;
      await vm.editTask(task);
    }
  }
}
