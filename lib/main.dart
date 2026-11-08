import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants/app_theme.dart';
import 'providers/dino_catalog_provider.dart';
import 'screens/main_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DinoCatalogProvider()),
      ],
      child: const JurassicaApp(),
    ),
  );
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