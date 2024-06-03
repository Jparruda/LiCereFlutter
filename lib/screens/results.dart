import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/question.dart';
import 'package:flutter_application_1/entities/resposta.dart';
import 'package:flutter_application_1/main.dart';
import 'package:google_fonts/google_fonts.dart';

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
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Definir o padding proporcional como 33% da altura da tela
          double paddingProporcional = constraints.maxHeight * 0.33;
          return  SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.black,
                  height:  constraints.maxHeight * 0.33,
                  width:  constraints.maxWidth,
                ),
                Container(
                  color: Color(0xFF6C07B9),
                  height:  constraints.maxHeight * 0.33,
                  width:  constraints.maxWidth,
                ),
                Row(
                  children: [
                    Container(
                      width:  constraints.maxWidth * 0.33, // Largura do container para visualização
                      height:  constraints.maxHeight * 0.33, // Altura do container para visualização
                      color: Color(0xFF7C0A0A),
                    ),
                    Container(
                      width:  constraints.maxWidth * 0.33, // Largura do container para visualização
                      height:  constraints.maxHeight * 0.33, // Altura do container para visualização
                      color: Colors.black,
                    ),
                    Container(
                      width:  constraints.maxWidth * 0.33, // Largura do container para visualização
                      height:  constraints.maxHeight * 0.33, // Altura do container para visualização
                      color: Color(0xFF095E8F),
                    ),
                  ],
                )
              ],
          )
        );
      }),
    );
  }
}
