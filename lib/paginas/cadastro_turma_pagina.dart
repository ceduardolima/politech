import 'package:politech/paginas/login_pagina.dart';
import 'package:politech/theme/colors_theme.dart';
import 'package:flutter/material.dart';

class TelaCadastroTurma extends StatefulWidget {
  TelaCadastroTurma({Key? key}) : super(key: key);

  @override
  _TelaCadastroTurmaState createState() => _TelaCadastroTurmaState();
}

class _TelaCadastroTurmaState extends State<TelaCadastroTurma> {
  List<Turma> turmas = [];
  TextEditingController nomeController = TextEditingController();
  TextEditingController codigoController = TextEditingController();
  TextEditingController diaController = TextEditingController();
  TextEditingController horaInicioController = TextEditingController();
  TextEditingController horaFimController = TextEditingController();

  void adicionarTurma() {
    setState(() {
      turmas.add(
        Turma(
          nome: nomeController.text,
          codigo: codigoController.text,
          horario: Horario(
            dia: diaController.text,
            horaInicio: horaInicioController.text,
            horaFim: horaFimController.text,
          ),
        ),
      );
      nomeController.clear();
      codigoController.clear();
      diaController.clear();
      horaInicioController.clear();
      horaFimController.clear();
    });
  }

  void _mostrarDialogAdicionarTurma(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Adicionar Turma'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomeController,
                decoration: InputDecoration(labelText: 'Nome da Turma'),
              ),
              TextField(
                controller: codigoController,
                decoration: InputDecoration(labelText: 'Código da Turma'),
              ),
              TextField(
                controller: diaController,
                decoration: InputDecoration(labelText: 'Dia da Aula'),
              ),
              TextField(
                controller: horaInicioController,
                decoration: InputDecoration(labelText: 'Hora de Início'),
              ),
              TextField(
                controller: horaFimController,
                decoration: InputDecoration(labelText: 'Hora de Fim'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                adicionarTurma();
                Navigator.of(context).pop();
              },
              child: Text('Adicionar Turma'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Turma'),
        backgroundColor: ColorsTheme().lightColorsScheme().primary,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: turmas.length,
        itemBuilder: (context, index) {
          final turma = turmas[index];
          return Container(
            color: Colors.blue,
            padding: EdgeInsets.all(16.0),
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nome: ${turma.nome}',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Código: ${turma.codigo}',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Horário: ${turma.horario.dia} ${turma.horario.horaInicio} - ${turma.horario.horaFim}',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _mostrarDialogAdicionarTurma(context);
        },
        child: Icon(Icons.add),
        backgroundColor: ColorsTheme().lightColorsScheme().primary,
      ),
    );
  }
}

class Turma {
  final String nome;
  final String codigo;
  final Horario horario;

  Turma({
    required this.nome,
    required this.codigo,
    required this.horario,
  });
}

class Horario {
  final String dia;
  final String horaInicio;
  final String horaFim;

  Horario({
    required this.dia,
    required this.horaInicio,
    required this.horaFim,
  });
}