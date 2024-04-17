import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Question {
  final String imagePath; // Caminho da imagem ou gif
  final List<String> options; // Lista de opções de resposta
  final int correctOptionIndex; // Índice da opção correta

  Question({
    required this.imagePath,
    required this.options,
    required this.correctOptionIndex,
  });
}

class Quiz {
  final List<Question> questions;
  int _currentIndex = 0;

  Quiz({required this.questions});

  void shuffleQuestions() {
    questions.shuffle();
  }

  Question getCurrentQuestion() {
    return questions[_currentIndex];
  }

  void moveToNextQuestion() {
    if (_currentIndex < questions.length - 1) {
      _currentIndex++;
    } else {
      _currentIndex = 0;
    }
  }
}

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({Key? key}) : super(key: key);

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  late Quiz quiz; // Declaração do quiz
  late double progressValue;
  late List<Color> optionColors;
  late bool optionSelected;
  late int selectedOptionIndex;
  bool answerCorrect =
      false; // Variável para armazenar se a resposta selecionada é correta ou não
  bool optionsEnabled =
      true; // Variável para controlar se as opções estão habilitadas ou não

  @override
  void initState() {
    super.initState();
    progressValue = 0; // Inicializa o valor do progresso
    initializeQuiz(); // Inicialização do quiz
    initializeOptionColors(); // Inicializa as cores das opções
    optionSelected = false;
  }

  // Inicializa o quiz com as perguntas e embaralha
  void initializeQuiz() {
    List<Question> questions = [
      Question(
        imagePath: 'pergunta1.jpg',
        options: ['Opção 1', 'Opção 2', 'Opção 3', 'Opção 4'],
        correctOptionIndex: 1,
      ),
      Question(
        imagePath: 'pergunta2.jpg',
        options: ['Opção 1', 'Opção 2', 'Opção 3', 'Opção 4'],
        correctOptionIndex: 0,
      ),
      Question(
        imagePath: 'pergunta3.jpg',
        options: ['Opção 1', 'Opção 2', 'Opção 3', 'Opção 4'],
        correctOptionIndex: 1,
      ),
      Question(
        imagePath: 'pergunta4.jpg',
        options: ['Opção 1', 'Opção 2', 'Opção 3', 'Opção 4'],
        correctOptionIndex: 0,
      ),
      Question(
        imagePath: 'pergunta5.jpg',
        options: ['Opção 1', 'Opção 2', 'Opção 3', 'Opção 4'],
        correctOptionIndex: 1,
      ),
      Question(
        imagePath: 'pergunta6.jpg',
        options: ['Opção 1', 'Opção 2', 'Opção 3', 'Opção 4'],
        correctOptionIndex: 0,
      ),
      // Adicione mais perguntas conforme necessário
    ];

    // Embaralhar as opções de cada pergunta
    questions.forEach((question) {
      question.options.shuffle();
    });

    quiz = Quiz(questions: questions);
    quiz.shuffleQuestions();
  }

  // Inicializa as cores das opções
  void initializeOptionColors() {
    optionColors = List.generate(
      quiz.getCurrentQuestion().options.length,
      (index) => Colors.grey,
    );
  }

  // Função para avançar para a próxima pergunta após um atraso
  void goToNextQuestionAfterDelay() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        quiz.moveToNextQuestion(); // Avança para a próxima pergunta
        progressValue = (quiz._currentIndex + 1) / quiz.questions.length;
        initializeOptionColors(); // Reinicializa as cores das opções
        optionSelected = false;
        optionsEnabled = true; // Habilita as opções novamente
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LiCere',
          style: GoogleFonts.lobsterTwo(
            textStyle: const TextStyle(
              fontSize: 24,
              color: Color(0xFF09E762),
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                LinearProgressIndicator(
                  color: Colors.green,
                  value: progressValue, // Valor do progresso
                ), // Barra de progresso
                SizedBox(height: 16), // Espaço entre widgets
                Padding(
                  padding: EdgeInsets.all(constraints.maxWidth * 0.02),
                  child: Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      quiz.getCurrentQuestion().imagePath,
                      width: constraints.maxWidth * 0.5,
                      height: constraints.maxWidth * 0.3,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: constraints.maxWidth * 0.5,
                      height: (quiz.getCurrentQuestion().options.length * 10)
                          .toDouble(), // Calcula a altura do Container com base no número de opções
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 8.0, // Espaçamento entre os botões
                        runSpacing:
                            8.0, // Espaçamento entre as linhas de botões
                        children: List.generate(
                          quiz.getCurrentQuestion().options.length,
                          (index) => SizedBox(
                            width: (constraints.maxWidth * 0.5 - 8.0) /
                                    quiz.getCurrentQuestion().options.length -
                                8.0, // Calcula a largura do botão
                            child: TextButton(
                              onPressed: optionsEnabled
                                  ? () {
                                      setState(() {
                                        selectedOptionIndex = index;
                                        optionSelected = true;
                                        optionColors[index] = Color(
                                            0xFF808DFF); // Define a cor da opção selecionada
                                        // Compara o índice da opção selecionada com o índice da opção correta
                                        answerCorrect = index ==
                                            quiz
                                                .getCurrentQuestion()
                                                .correctOptionIndex;
                                        print(
                                            'Opção selecionada: ${quiz.getCurrentQuestion().options[index]}');
                                      });
                                    }
                                  : null,
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (states) {
                                    return optionColors[
                                        index]; // Retorna a cor da opção conforme definido
                                  },
                                ),
                              ),
                              child: Text(
                                quiz.getCurrentQuestion().options[index],
                                style: const TextStyle(
                                  color: Colors.white, // Cor do texto do botão
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (optionSelected) {
                      setState(() {
                        optionsEnabled = false; // Desativa as opções
                        if (answerCorrect) {
                          // Se a resposta estiver correta, define a cor da opção selecionada como verde
                          optionColors[quiz
                              .getCurrentQuestion()
                              .correctOptionIndex] = Colors.green;
                        } else {
                          // Se a resposta estiver incorreta, define a cor da opção selecionada como vermelha
                          optionColors[selectedOptionIndex] = Colors.red;
                        }
                      });
                      goToNextQuestionAfterDelay(); // Avança para a próxima pergunta após um atraso
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF09E762)),
                    foregroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 47, 156, 91)),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
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
                    "Próxima Pergunta",
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
          );
        },
      ),
    );
  }
}
