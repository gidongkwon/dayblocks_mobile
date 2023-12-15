import 'package:flutter/material.dart';

import 'settings_controller.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatelessWidget {
  const SettingsView({super.key, required this.controller});

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('테마', style: TextStyle(fontWeight: FontWeight.bold)),
                const Spacer(),
                DropdownButton<ThemeMode>(
                  // Read the selected themeMode from the controller
                  value: controller.themeMode,
                  // Call the updateThemeMode method any time the user selects a theme.
                  onChanged: controller.updateThemeMode,
                  items: const [
                    DropdownMenuItem(
                      value: ThemeMode.system,
                      child: Text('시스템 테마'),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.light,
                      child: Text('라이트 테마'),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.dark,
                      child: Text('다크 테마'),
                    )
                  ],
                ),
              ],
            ),
            Row(
              children: [
                const Text('한 주의 시작', style: TextStyle(fontWeight: FontWeight.bold)),
                const Spacer(),
                DropdownButton<int>(
                  // Read the selected themeMode from the controller
                  value: controller.startOfWeek,
                  // Call the updateThemeMode method any time the user selects a theme.
                  onChanged: controller.updateStartOfWeek,
                  items: const [
                    DropdownMenuItem(
                      value: DateTime.sunday,
                      child: Text('일요일'),
                    ),
                    DropdownMenuItem(
                      value: DateTime.monday,
                      child: Text('월요일'),
                    ),
                  ],
                ),
              ],
            ),
          ]
        )
      ),
    );
  }
}
