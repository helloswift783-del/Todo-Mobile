# Todo Mobile (Flutter)

A production-ready Flutter Todo app for Android and iOS built with Material Design 3, MVVM architecture, local persistence (Hive), reminders, onboarding, and animated interactions.

## Features
- Add, edit, delete tasks
- Mark as completed with animated checkbox
- Swipe-to-delete animation
- Drag-and-drop reorder
- Categories and priority levels
- Due date & time picker
- Search and filtering
- Light/Dark mode toggle
- Animated onboarding (3 pages)
- Statistics pie chart
- Local notifications for reminders
- Persistent storage with Hive
- Empty state animation
- Loading states and haptic feedback

## Folder structure
```text
lib/
  core/
    services/
      notification_service.dart
    theme/
      app_theme.dart
    utils/
      date_formatter.dart
  data/
    datasources/
      hive_boxes.dart
    models/
      task_category.dart
      task_model.dart
      task_model.g.dart
      task_priority.dart
    repositories/
      task_repository.dart
  routes/
    app_router.dart
  viewmodels/
    task_view_model.dart
    theme_view_model.dart
  views/
    screens/
      home_screen.dart
      onboarding_screen.dart
      statistics_screen.dart
    widgets/
      animated_empty_state.dart
      gradient_background.dart
      task_form_sheet.dart
      task_tile.dart
  main.dart
assets/
  images/
    app_icon.png
    splash.png
```

## Setup
1. Install Flutter stable (>=3.22 recommended).
2. Run:
   ```bash
   flutter pub get
   ```
3. Generate launcher icons and splash:
   ```bash
   dart run flutter_launcher_icons
   dart run flutter_native_splash:create
   ```
4. Run app:
   ```bash
   flutter run
   ```

## Required dependencies
- provider
- hive
- hive_flutter
- intl
- uuid
- flutter_local_notifications
- timezone
- fl_chart
- animations

(See `pubspec.yaml` for full versions.)
