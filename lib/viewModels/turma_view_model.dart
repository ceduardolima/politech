import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:politech/casosDeUso/cadastro_turma_caso_de_uso.dart';
import 'package:politech/domain/repositorio/turma_repositorio.dart';
import 'package:politech/viewModels/banco_de_dados_view_model_padrao.dart';

import '../domain/aluno/aluno.dart';
import '../domain/turma/turma.dart';

class TurmaViewModel extends BancoDeDadosViewModelPadrao {
  late TurmaRepositorio _turmaRepositorio;
  List<Turma> _turmas = [];
  List<Aluno> _alunos = [];

  TurmaViewModel() {
    _turmaRepositorio = GetIt.instance.get<TurmaRepositorio>();
    repositrio = _turmaRepositorio;
  }

  void assistirListaDeTurmas() {
    _turmaRepositorio.assistirListaDeTurmas().listen((lista) {
      _turmas = lista;
      notifyListeners();
    });
  }

  Future<List<Aluno>> listarAlunos(String turmaId) async {
    return await _turmaRepositorio.listarAlunos(turmaId);
  }

  Future<List<Turma>> cadastrarTurma(Map turmasMap) async {
    final turmas = CadastroTurmaCasoDeUso(turmasMap).obterTurmas();
    await _turmaRepositorio.inserirLista(turmas);
    return turmas;
  }

  List<Turma> get listaDeTurmas => _turmas;

  TurmaRepositorio get turma => _turmaRepositorio;

  List<Aluno> get alunos => _alunos;

}