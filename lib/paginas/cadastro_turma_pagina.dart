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
  String? selectedDia;
  String? selectedHoraInicio;
  String? selectedHoraFim;

  final List<String> diasDaSemana = [
    'Segunda',
    'Terça',
    'Quarta',
    'Quinta',
    'Sexta',
    'Sábado',
  ];

  final List<String> horarios = [
    '07:10',
    '08:00',
    '08:50',
    '09:40',
    '10:30',
    '11:20',
    '12:10',
    '13:00',
    '13:50',
    '14:40',
    '15:30',
    '16:20',
    '17:10',
    '18:00',
    '18:50',
    '19:40',
    '20:30',
    '21:20',
    '22:10',
  ];

  void adicionarTurma() {
    setState(() {
      turmas.add(
        Turma(
          nome: nomeController.text,
          codigo: codigoController.text,
          horario: Horario(
            dia: selectedDia!,
            horaInicio: selectedHoraInicio!,
            horaFim: selectedHoraFim!,
          ),
        ),
      );
      nomeController.clear();
      codigoController.clear();
      selectedDia = null;
      selectedHoraInicio = null;
      selectedHoraFim = null;
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
              DropdownButtonFormField<String>(
                value: selectedDia,
                hint: Text('Escolha o Dia da Semana'),
                items: diasDaSemana.map((String dia) {
                  return DropdownMenuItem<String>(
                    value: dia,
                    child: Text(dia),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedDia = newValue;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                value: selectedHoraInicio,
                hint: Text('Escolha o Horário de Início'),
                items: horarios.map((String hora) {
                  return DropdownMenuItem<String>(
                    value: hora,
                    child: Text(hora),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedHoraInicio = newValue;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                value: selectedHoraFim,
                hint: Text('Escolha o Horário de Fim'),
                items: horarios.map((String hora) {
                  return DropdownMenuItem<String>(
                    value: hora,
                    child: Text(hora),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedHoraFim = newValue;
                  });
                },
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (selectedDia != null &&
                    selectedHoraInicio != null &&
                    selectedHoraFim != null) {
                  adicionarTurma();
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Preencha todos os campos!'),
                    ),
                  );
                }
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: turmas.length,
          separatorBuilder: (context, index) => SizedBox(height: 10.0),
          itemBuilder: (context, index) {
            final turma = turmas[index];
            return Card(
              color: ColorsTheme().lightColorsScheme().primary,
              elevation: 4.0,
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nome: ${turma.nome}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      'Código: ${turma.codigo}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Horário: ${turma.horario.dia} ${turma.horario.horaInicio} - ${turma.horario.horaFim}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
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
