import 'package:flutter/material.dart';
import 'package:politech/domain/aluno/aluno.dart';
import 'package:politech/domain/horario/horario.dart';

import '../domain/turma/turma.dart';

class CadastroTurmaCasoDeUso {
  final List<Turma> _turmas = [];
  final List<Aluno> _alunos = [];
  final List<Horario> _horarios = [];

  CadastroTurmaCasoDeUso(Map turmas) {
    _criarListaDeTumas(turmas);
  }

  _criarListaDeTumas(Map turmasMap) {
    final chaves = turmasMap.keys.toList();
    for(var chave in chaves) {
      Map turmaMap = turmasMap[chave];
      _criarAlunos(chave, turmaMap["alunos"]);
      _criarHorarios(chave, turmaMap["horarios"]);
      _turmas.add(Turma(chave, turmaMap["nome"], turmaMap["codigo"]));
    }
  }

  _criarAlunos(String turmaId, List alunos) {
    final List<Aluno> bufferAlunos = [];
    for(var aluno in alunos) {
      bufferAlunos.add(Aluno.genId(aluno, turmaId));
    }
    _alunos.addAll(bufferAlunos);
  }

  _criarHorarios(String turmaId, List horarios) {
    final List<Horario> bufferHorarios = [];
    for (var horario in horarios) {
      bufferHorarios.add(Horario.gen(horario["dia"], horario["horario"], horario["sala"], turmaId));
    }
    _horarios.addAll(bufferHorarios);
  }

  List<Aluno> get alunos => _alunos;

  List<Turma> get turmas => _turmas;

  List<Horario> get horarios => _horarios;
}