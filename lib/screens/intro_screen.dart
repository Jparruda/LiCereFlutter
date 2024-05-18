import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/questions_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF808DFF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TitleText(),
            PlayButton(),
          ],
        ),
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  const TitleText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double fontSize = MediaQuery.of(context).size.width * 0.12;
    return Text(
      "LiCere",
      style: Theme.of(context)
          .textTheme
          .displayLarge!
          .copyWith(fontSize: fontSize),
    );
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const QuestionsScreen()),
      ),
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(const Color(0xFF09E762)),
        foregroundColor: WidgetStateProperty.all(const Color(0xFF2F9C5B)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(color: Colors.white),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Text(
          "JOGAR",
          style: GoogleFonts.montserrat().copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
