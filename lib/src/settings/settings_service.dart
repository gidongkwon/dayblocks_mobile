import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  const SettingsService({ required this.prefs });

  final SharedPreferences prefs;

  Future<ThemeMode> themeMode() async => ThemeMode.values.byName(prefs.getString('themeMode') ?? 'system');
  Future<int> startOfWeek() async => prefs.getInt('startOfWeek') ?? DateTime.monday;

  Future<void> updateThemeMode(ThemeMode theme) async {
    prefs.setString('themeMode', theme.name);
  }

  Future<void> updateStartOfWeek(int day) async {
    prefs.setInt('startOfWeek', day);
  }
}
