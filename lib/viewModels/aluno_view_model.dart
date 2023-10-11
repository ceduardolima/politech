import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:politech/domain/repositorio/aluno_repositorio.dart';

import '../domain/aluno/aluno.dart';

class AlunoViewModel extends ChangeNotifier {
  late AlunoRepositorio _alunoRepositorio;
  List<Aluno> _alunos = [];


  AlunoViewModel() {
    _alunoRepositorio = GetIt.instance.get<AlunoRepositorio>();
    assistirListaDeAlunos();
  }

  void assistirListaDeAlunos() {
    _alunoRepositorio.assistirListaDeAlunos().listen((lista) {
      _alunos = lista;
      notifyListeners();
    });
  }

  List<Aluno> get listaAluno => _alunos;

  AlunoRepositorio get aluno => _alunoRepositorio;

  Future<void> inserirLista(List<Aluno> alunos) async {
    await _alunoRepositorio.inserirLista(alunos);
  }
  
  Future<bool> excluirAlunosDaTurma(String turmaId) async {
    return await _alunoRepositorio.excluirAlunosDaTurma(turmaId);
  }
}