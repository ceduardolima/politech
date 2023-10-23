import 'package:flutter/material.dart';
import 'package:politech/viewModels/aluno_view_model.dart';
import 'package:politech/viewModels/presenca_view_model.dart';
import 'package:politech/viewModels/turma_view_model.dart';
import 'package:provider/provider.dart';

class PresencaPagina extends StatefulWidget {
  PresencaPagina({
    super.key,
    required this.turmaId,
  });

  final String turmaId;

  @override
  State<PresencaPagina> createState() => _PresencaPaginaState();
}

class _PresencaPaginaState extends State<PresencaPagina> {
  late PresencaViewModel presencaViewModel;

  late TurmaViewModel turmaViewModel;

  List<List<String>> faltas = [];

  @override
  void initState() {
    super.initState();
    presencaViewModel = context.read<PresencaViewModel>();
    turmaViewModel = context.read<TurmaViewModel>();
    obterFaltas();
  }

  void obterFaltas() async {
    final alunos = await turmaViewModel.listarAlunos(widget.turmaId);
    final List<List<String>> faltasBuffer = [];
    final numFaltas = await presencaViewModel.numFaltasDosAlunos(alunos);
    for (var i = 0; i < alunos.length; i++) {
      faltasBuffer.add([(alunos[i].nome), numFaltas[i].toString()]);
    }
    setState(() {
      faltas = faltasBuffer;
    });
  }

  List<DataRow> obterLinhas() =>
      faltas.map((e) =>
          DataRow(cells: [
            DataCell(Text(e[0], overflow: TextOverflow.ellipsis,)),
            DataCell(Text(e[1], textAlign: TextAlign.center,))
          ])).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        primary: true,
        title: Text("Presenças"),
      ),
      body: faltas.isEmpty
          ? const Center(
        child: Text("vazio"),
      )
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DataTable(
                columns: const [
                  DataColumn(label: Text("Alunos")),
                  DataColumn(label: Text("Dias faltados")),
                ],
                rows: obterLinhas()
            ),
          ],
        ),
      ),
    );
  }
}
