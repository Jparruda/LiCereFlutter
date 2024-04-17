import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/intro_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Licere',
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.lobsterTwoTextTheme(),
      ),
      home: const MyHomePage(title: 'LiCere'),
    );
  }
}
