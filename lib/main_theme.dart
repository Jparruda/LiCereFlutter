import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData mainTheme = ThemeData(
  useMaterial3: true,
  textTheme: GoogleFonts.lobsterTwoTextTheme()
      .copyWith(
    displayLarge: const TextStyle(
      fontSize: 80,
      color: Color(0xFF09E762),
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      shadows: [
        Shadow(
          blurRadius: 14.2,
          color: Color.fromARGB(78, 0, 0, 0),
          offset: Offset(-6.0, 6.0),
        ),
      ],
    ),
  )
      .apply(
    fontFamily: "LobsterTwo_regular",
    fontFamilyFallback: ["LobsterTwo"],
  ),
);
