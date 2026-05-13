import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guild_leaderboard/pages/home.dart';
import 'package:guild_leaderboard/style/theme_setting.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Guild Leaderboard',
      theme: lightTheme,
      darkTheme: darkTheme,
      home: Home(),
    );
  }
}
