import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/questions_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double fontSize = screenSize.width * 0.12; 
    return Scaffold(
      backgroundColor: const Color(0xFF808DFF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              "LiCere",
              style: GoogleFonts.lobsterTwo(
                textStyle: TextStyle(
                  fontSize: fontSize,
                  color: const Color(0xFF09E762),
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  shadows: const [
                    Shadow(
                      blurRadius: 14.2,
                      color: Color.fromARGB(78, 0, 0, 0),
                      offset: Offset(-6.0, 6.0),
                    ),
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuestionsScreen()),
                );
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xFF09E762)),
                foregroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 47, 156, 91)),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                ),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: const BorderSide(
                        color: Colors.white), // Adiciona a borda
                  ),
                ),
                elevation: MaterialStateProperty.all<double>(
                    30.0), // Adiciona a sombra
              ),
              child: Text(
                "JOGAR",
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
