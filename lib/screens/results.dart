import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/question.dart';
import 'package:flutter_application_1/entities/resposta.dart';
import 'package:flutter_application_1/main.dart';

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
      body: Center(
        child: Text("Respostas corretas: ${corretas()}"),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          var resposta = Resposta(
            escolhida: "A",
            questao: Question(
              correctOption: "A",
              options: ["A", "B", "C", "D"],
              textQuestion: "",
              imagePath: "",
            ),
          );

          getIt<List<Resposta>>().add(resposta);
          // atualizarNumRespostasCorretas();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
