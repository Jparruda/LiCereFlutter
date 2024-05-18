import 'package:flutter_application_1/entities/question.dart';

class Quiz {
  final List<Question> questions;
  int currentIndex = 0;

  Quiz({required this.questions});

  void shuffleQuestions() {
    questions.shuffle();
  }

  Question getCurrentQuestion() {
    return questions[currentIndex];
  }

  void moveToNextQuestion() {
    if (currentIndex < questions.length - 1) {
      currentIndex++;
    } else {
      currentIndex = 0;
    }
  }
}