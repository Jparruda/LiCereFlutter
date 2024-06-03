import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/question.dart';
import 'package:flutter_application_1/entities/resposta.dart';
import 'package:flutter_application_1/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';

class Resultados extends StatefulWidget {
  const Resultados({super.key});

  @override
  State<Resultados> createState() => _ResultadosState();
}

class _ResultadosState extends State<Resultados> {
  // ValueNotifier<int> corretas = ValueNotifier(0);
  int corretas() {
    return getIt<List<Resposta>>()
        .where(
            (resposta) => resposta.escolhida == resposta.questao.correctOption)
        .length;
  }

  List<Resposta> getRespostas() {
    return getIt<List<Resposta>>();
  }

  // void atualizarNumRespostasCorretas() {
  //   corretas.value = 0;
  //   List<Resposta> respostas = getRespostas();

  //   for (Resposta resposta in respostas) {
  //     if (resposta.escolhida == resposta.questao.correctOption) {
  //       corretas.value++;
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: LayoutBuilder(builder: (context, constraints) {
        // Definir o padding proporcional como 33% da altura da tela
        return SingleChildScrollView(
            child: Center(
          child: Column(
            children: [
              Container(
                height: constraints.maxHeight * 0.4,
                width: constraints.maxWidth * 0.9,
                decoration: BoxDecoration(
                    color: const Color(0xFF646AFF),
                    borderRadius: BorderRadius.circular(40)),
                child: Row(
                  children: [
                    Container(
                      width: constraints.maxWidth * 0.03,
                    ),
                    Container(
                      width: constraints.maxWidth * 0.18,
                      height: constraints.maxWidth * 0.18,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFF09E762)),
                      child: Column(
                        mainAxisAlignment:MainAxisAlignment.center ,
                        children: [
                          Container(
                            height: 10,
                          ),
                          Text("ACERTOS:",
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: constraints.maxWidth * 0.015,
                                fontWeight: FontWeight.bold,
                              ))),
                          Text(corretas().toString(),
                            style: GoogleFonts.lobsterTwo(
                                  textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: constraints.maxWidth * 0.1,
                                fontWeight: FontWeight.bold,
                                shadows: const [
                                  Shadow(
                                    offset: Offset(2.0, 2.0), // Deslocamento da sombra
                                    blurRadius: 3.0, // Raio do desfoque da sombra
                                    color: Color.fromARGB(128, 0, 0, 0), // Cor da sombra com transparência
                                  ),
                                ],
                              ))
                          )
                        ],
                      ),
                    ),
                    Flexible(
                      child: Container(
                        // width: constraints.maxWidth * 0.1,
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Color(0xFF8185FF),
                          borderRadius: BorderRadius.circular(40)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: getRespostas().map((resposta) {
                            bool correct = resposta.escolhida == resposta.questao.correctOption;
                            // Color color;
                            // if (correct) {
                            //   color = Colors.green;
                            // } else {
                            //   color = Colors.red;
                            // }
                            // Color color2 = correct ? Colors.green : Colors.red; // operador ternário
                            return Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: correct ? Color(0xFF09E762) : Color(0xFFE20000),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: constraints.maxHeight * 0.1,
                width: constraints.maxWidth,
              ),
              Container(
                width: constraints.maxWidth *
                    0.33, // Largura do container para visualização
                height: constraints.maxHeight *
                    0.5, // Altura do container para visualização
                color: const Color(0xFFE20000),
              ),
            ],
          ),
        ));
      }),
    );
  }
}
