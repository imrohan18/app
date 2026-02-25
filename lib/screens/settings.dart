import 'package:flutter/material.dart';
import '../main.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final current = themeController.mode;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          const ListTile(
            title: Text('Appearance'),
            subtitle: Text('Choose app theme'),
          ),
          RadioListTile<ThemeMode>(
            value: ThemeMode.system,
            groupValue: current,
            onChanged: (m) => themeController.setMode(ThemeMode.system),
            title: const Text('Use System'),
          ),
          RadioListTile<ThemeMode>(
            value: ThemeMode.light,
            groupValue: current,
            onChanged: (m) => themeController.setMode(ThemeMode.light),
            title: const Text('Light'),
          ),
          RadioListTile<ThemeMode>(
            value: ThemeMode.dark,
            groupValue: current,
            onChanged: (m) => themeController.setMode(ThemeMode.dark),
            title: const Text('Dark'),
          ),
        ],
      ),
    );
  }
}

