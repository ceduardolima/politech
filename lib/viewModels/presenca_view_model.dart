import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:politech/domain/repositorio/presenca_repositorio.dart';

import '../domain/aluno/aluno.dart';
import '../domain/presenca/presenca.dart';

class PresencaViewModel extends ChangeNotifier {
  late PresencaRepositorio _presencaRepositorio;
  List<Presenca> _presencas = [];

  PresencaViewModel() {
    _presencaRepositorio = GetIt.instance.get<PresencaRepositorio>();
  }

  PresencaViewModel.comTurma(String turmaId) {
    _presencaRepositorio = GetIt.instance.get<PresencaRepositorio>();
    _assistirListaDePresencaDaTurma(turmaId);
  }

  void _assistirListaDePresencaDaTurma(String turmaId) {
    _presencaRepositorio.assistirListaDePresencaDaTurma(turmaId).listen((
        lista) {
      _presencas = lista;
      notifyListeners();
    });
  }

  @transaction
  Future<void> inserirFaltas(String chamadaId, DateTime data, List<Aluno> alunosFaltantes) async {
    List<Presenca> presencas = alunosFaltantes.map((e) =>
        Presenca.genId(e.id, false, data, chamadaId)).toList();
    await _presencaRepositorio.inserirLista(presencas);
  }

  Future<List<Aluno>> listarAlunosDaChamada(String chamadaId, bool presente) async {
    return await _presencaRepositorio.listarAlunosDaChamada(chamadaId, presente);
  }

  Future<List<int>> numFaltasDosAlunos(List<Aluno> alunos) async {
    List<String> alunosId = alunos.map((e) => e.id).toList();
    return await _presencaRepositorio.numeroDeFaltasDoAluno(alunosId);
  }

  Future<void> excluirPresencaDaChamada(String chamadaId) async {
    await _presencaRepositorio.excluirPresencaDaChamada(chamadaId);
    notifyListeners();
  }

  Future<void> excluirPresencaDaturma(String turmaId) async {
    await _presencaRepositorio.excluirPresencaDaTurma(turmaId);
    notifyListeners();
  }

  List<Presenca> get listaDePresencas => _presencas;

  PresencaRepositorio get presenca => _presencaRepositorio;
}