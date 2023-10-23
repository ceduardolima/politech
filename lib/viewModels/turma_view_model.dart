import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:politech/domain/repositorio/turma_repositorio.dart';

import '../domain/aluno/aluno.dart';
import '../domain/turma/turma.dart';

class TurmaViewModel extends ChangeNotifier {
  late TurmaRepositorio _turmaRepositorio;
  List<Turma> _turmas = [];
  List<Aluno> _alunos = [];

  TurmaViewModel() {
    _turmaRepositorio = GetIt.instance.get<TurmaRepositorio>();
  }

  void assistirListaDeTurmas() {
    _turmaRepositorio.assistirListaDeTurmas().listen((lista) {
      _turmas = lista;
      notifyListeners();
    });
  }

  Future<void> inserir(Turma turma) async {
    await _turmaRepositorio.inserir(turma);
    assistirListaDeTurmas();
  }

  Future<List<Aluno>> listarAlunos(String turmaId) async {
    return await _turmaRepositorio.listarAlunos(turmaId);
  }

  List<Turma> get listaDeTurmas => _turmas;

  TurmaRepositorio get turma => _turmaRepositorio;

  List<Aluno> get alunos => _alunos;

  excluir(Turma turma) async {
    await _turmaRepositorio.excluir(turma);
    notifyListeners();
  }
}