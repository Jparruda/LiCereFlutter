import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/question.dart';
import 'package:flutter_application_1/entities/quiz.dart';
import 'package:flutter_application_1/entities/resposta.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/screens/results.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  late Quiz quiz; // Declaração do quiz
  late double progressValue;
  late List<Color> optionColors;
  late bool optionSelected;
  late String selectedOption;
  bool answerCorrect =
      false; // Variável para armazenar se a resposta selecionada é correta ou não
  bool optionsEnabled =
      true; // Variável para controlar se as opções estão habilitadas ou não

  List<String> opcoesLetras(String letraObrigatoria, int quantidade) {
    const alfabeto = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final letrasPossiveis = alfabeto.replaceAll(letraObrigatoria, '').split('');
    letrasPossiveis.shuffle();
    final letrasAleatorias = letrasPossiveis.take(quantidade).toList();
    letrasAleatorias.insert(0, letraObrigatoria);
    return letrasAleatorias;
  }

  @override
  void initState() {
    super.initState();
    initializeQuiz(); // Inicialização do quiz
    progressValue = 1 / quiz.questions.length;
    initializeOptionColors(); // Inicializa as cores das opções
    optionSelected = false;
  }

  // Inicializa o quiz com as perguntas e embaralha
  void initializeQuiz() {
    List<Question> questions = [
      Question(
        imagePath: 'A.jpg',
        textQuestion: 'Que letra é essa?',
        options: opcoesLetras("A", 3),
        correctOption: 'A',
      ),
      Question(
        imagePath: 'B.jpg',
        textQuestion: 'Que letra é essa?',
        options: opcoesLetras("B", 3),
        correctOption: 'B',
      ),
      Question(
        imagePath: 'C.jpg',
        textQuestion: 'Que letra é essa?',
        options: opcoesLetras("C", 3),
        correctOption: 'C',
      ),
      Question(
        imagePath: 'D.jpg',
        textQuestion: 'Que letra é essa?',
        options: opcoesLetras("D", 3),
        correctOption: 'D',
      ),
      Question(
        imagePath: 'E.jpg',
        textQuestion: 'Que letra é essa?',
        options: opcoesLetras("E", 3),
        correctOption: 'E',
      ),
      Question(
        imagePath: 'F.jpg',
        textQuestion: 'Que letra é essa?',
        options: opcoesLetras("F", 3),
        correctOption: 'F',
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
      (index) => const Color(0xFFE3E3E3),
    );
  }

  // Função para avançar para a próxima pergunta após um atraso
  void goToNextQuestionAfterDelay() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        quiz.moveToNextQuestion(); // Avança para a próxima pergunta
        progressValue = (quiz.currentIndex + 1) / quiz.questions.length;
        initializeOptionColors(); // Reinicializa as cores das opções
        optionSelected = false;
        optionsEnabled = true; // Habilita as opções novamente
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF808DFF),
      appBar: AppBar(
        title: Text(
          'LiCere',
          style: GoogleFonts.lobsterTwo(
            textStyle: const TextStyle(
              fontSize: 40,
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
                SizedBox(
                  height: 9.0,
                  child: LinearProgressIndicator(
                    color: const Color(0xFF09E762),
                    value: progressValue,
                    backgroundColor:
                        const Color(0xFF08B44D), // Valor do progresso
                    borderRadius: BorderRadius.circular(40.00),
                  ),
                ),
                const SizedBox(height: 16), // Espaço entre widgets
                Padding(
                  padding: EdgeInsets.all(constraints.maxWidth * 0.02),
                  child: Align(
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        quiz.getCurrentQuestion().imagePath,
                        width: constraints.maxWidth * 0.4,
                        height: constraints.maxWidth * 0.2,
                      ),
                    ),
                  ),
                ),
                Text(
                  quiz.getCurrentQuestion().textQuestion,
                  style:  GoogleFonts.montserrat( 
                    textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),)
                ),
                const SizedBox(height: 20), // 
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: constraints.maxWidth * 0.7,
                      height: (quiz.getCurrentQuestion().options.length * 10)
                          .toDouble(), // Calcula a altura do Container com base no número de opções
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 8.0, // Espaçamento entre os botões
                        runSpacing:
                            20.0, // Espaçamento entre as linhas de botões
                        children: List.generate(
                          quiz.getCurrentQuestion().options.length,
                          (index) => SizedBox(
                            width: (constraints.maxWidth * 0.5 - 8.0) /
                                    quiz.getCurrentQuestion().options.length -
                                8.0, // Calcula a largura do botão
                            height: constraints.maxHeight * 0.13,
                            child: TextButton(
                              onPressed: optionsEnabled
                                  ? () {
                                      setState(() {
                                        selectedOption = quiz
                                                .getCurrentQuestion()
                                                .options[
                                            index]; // Armazena a opção selecionada
                                        optionSelected = true;
                                        optionColors[index] = const Color(0xFFFFF86E); // Define a cor da opção selecionada
                                        // Verifica se a opção selecionada é correta
                                        answerCorrect = selectedOption ==
                                            quiz
                                                .getCurrentQuestion()
                                                .correctOption;
                                      });
                                    }
                                  : null,
                              style: ButtonStyle(
                                backgroundColor:
                                    WidgetStateProperty.resolveWith<Color>(
                                  (states) {
                                    return optionColors[
                                        index]; // Retorna a cor da opção conforme definido
                                  },
                                ),
                              ),
                              child: Text(
                                quiz.getCurrentQuestion().options[index],
                                style:  GoogleFonts.montserrat( 
                                  textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold
                              ),)
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.all(constraints.maxHeight * 0.1),
                  child: TextButton(
                    onPressed: () {
                      if (optionSelected) {
                        setState(() {
                          optionsEnabled = false; // Desativa as opções
                          if (answerCorrect) {
                            // Se a resposta estiver correta, define a cor da opção selecionada como verde
                            optionColors[quiz
                                    .getCurrentQuestion()
                                    .options
                                    .indexOf(selectedOption)] =
                                const Color(0xFF09E762);
                          } else {
                            // Se a resposta estiver incorreta, define a cor da opção selecionada como vermelha
                            optionColors[quiz
                                    .getCurrentQuestion()
                                    .options
                                    .indexOf(selectedOption)] =
                                const Color(0xFFFC1605);
                          }
                        });
                        goToNextQuestionAfterDelay(); // Avança para a próxima pergunta após um atraso
                        Resposta resposta = Resposta(
                            escolhida: selectedOption,
                            questao: quiz.getCurrentQuestion());
                        getIt<List<Resposta>>().add(resposta);

                        if (quiz.currentIndex == quiz.questions.length - 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Resultados(),
                            ),
                          );
                        }
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          const Color(0xFF09E762)),
                      foregroundColor: WidgetStateProperty.all<Color>(
                          const Color.fromARGB(255, 47, 156, 91)),
                      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                      ),
                      shape: WidgetStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: const BorderSide(
                              color: Colors.white), // Adiciona a borda
                        ),
                      ),
                      elevation: WidgetStateProperty.all<double>(
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
