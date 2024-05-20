enum Option { A, B, C, D }

class Question {
  final String imagePath;
  // final Map<Option, String> options;
  final String textQuestion;
  //pergunta
  final List<String> options;
  // final Option correctOption;
  final String correctOption;

  Question({
    required this.correctOption,
    required this.textQuestion,
    required this.options,
    required this.imagePath,
  });
}
