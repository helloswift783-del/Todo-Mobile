enum TaskCategory {
  work,
  study,
  personal,
  shopping,
  health;

  String get label => switch (this) {
        TaskCategory.work => 'Work',
        TaskCategory.study => 'Study',
        TaskCategory.personal => 'Personal',
        TaskCategory.shopping => 'Shopping',
        TaskCategory.health => 'Health',
      };
}
