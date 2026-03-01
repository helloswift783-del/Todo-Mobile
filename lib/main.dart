import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/services/notification_service.dart';
import 'data/datasources/hive_boxes.dart';
import 'data/repositories/task_repository.dart';
import 'routes/app_router.dart';
import 'viewmodels/task_view_model.dart';
import 'viewmodels/theme_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveBoxes.init();
  await NotificationService.instance.initialize();

  final taskRepository = TaskRepository(HiveBoxes.taskBox);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
        ChangeNotifierProvider(
          create: (_) => TaskViewModel(taskRepository)..loadTasks(),
        ),
      ],
      child: const TodoApp(),
    ),
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeViewModel = context.watch<ThemeViewModel>();

    return MaterialApp(
      title: 'Todo Mobile',
      debugShowCheckedModeBanner: false,
      themeMode: themeViewModel.themeMode,
      theme: themeViewModel.lightTheme,
      darkTheme: themeViewModel.darkTheme,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRouter.onboarding,
    );
  }
}
