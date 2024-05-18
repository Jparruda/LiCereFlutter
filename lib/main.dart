import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/resposta.dart';
import 'package:flutter_application_1/main_theme.dart';
import 'package:flutter_application_1/screens/intro_screen.dart';
import 'package:flutter_application_1/screens/results.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.I;

void main() {
  getIt.registerSingleton<List<Resposta>>(List.empty(growable: true));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Licere',
      theme: mainTheme,
      home: const HomePage(),
      // home: const Resultados(),
    );
  }
}
