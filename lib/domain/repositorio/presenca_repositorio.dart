import 'package:floor/floor.dart';
import 'package:get_it/get_it.dart';
import 'package:politech/domain/database/dao/presenca_dao.dart';

import '../aluno/aluno.dart';
import '../presenca/presenca.dart';

class PresencaRepositorio {
  late PresencaDao _presencaDao;

  PresencaRepositorio() {
    _presencaDao = GetIt.instance.get<PresencaDao>();
  }

  @transaction
  Future<void> inserir(Presenca presenca) async {
    await _presencaDao.inserir(presenca);
  }

  @transaction
  Future<void> inserirLista(List<Presenca> presencas) async {
    await _presencaDao.inserirLista(presencas);
  }

  @transaction
  Stream<List<Presenca>> assistirListaDePresencaDaTurma(String turmaId) async* {
    yield* _presencaDao.assistirListaDePresencaDaTurma(turmaId);
  }

  @transaction
  Future<List<Aluno>> listarAlunosPresentes() async {
    return await _presencaDao.listarAlunosPresentes();
  }

  @transaction
  Future<List<int>> numeroDeFaltasDoAluno(List<String> listaId) async {
    List<int> listaFaltas = [];
    for (var id in listaId) {
      int? numFaltas = await _presencaDao.numeroDeFaltasDoAluno(id);
      listaFaltas.add(numFaltas ?? 0);
    }
    return listaFaltas;
  }

  @transaction
  Future<List<Aluno>> listarAlunosFaltates() async {
    return await _presencaDao.listarAlunosFaltates();
  }

  @transaction
  Future<List<Presenca>> listarPresencasDoAluno(
      String alunoId, DateTime inicio, DateTime fim, bool presente) async {
    return await _presencaDao.listarPresencasDoAluno(
        alunoId, inicio, fim, presente);
  }

  @transaction
  Future<List<Aluno>> listarAlunosDaChamada(
      String chamadaId, bool presente) async {
    return await _presencaDao.listarAlunosDaChamada(chamadaId, presente);
  }

  @transaction
  Future<void> excluirPresencaDaTurma(String turmaId) async {
    await _presencaDao.excluirPresencaDaTurma(turmaId);
  }

  @transaction
  Future<void> excluirPresencaDaChamada(String chamadaId) async {
    await _presencaDao.excluirPresencaDaChamada(chamadaId);
  }

  @transaction
  Future<void> excluir(Presenca presenca) async {
    await _presencaDao.excluir(presenca);
  }
}
