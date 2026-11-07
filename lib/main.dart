import 'package:flutter/material.dart';
import 'constants/app_theme.dart';
import 'screens/main_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const JurassicaApp());
}

class JurassicaApp extends StatelessWidget {
  const JurassicaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jurassica',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.natGeoTheme,
      home: const MainScreen(),
    );
  }
}