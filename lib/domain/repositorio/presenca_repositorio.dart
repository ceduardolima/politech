import 'package:get_it/get_it.dart';
import 'package:politech/domain/database/dao/presenca_dao.dart';

import '../aluno/aluno.dart';
import '../presenca/presenca.dart';

class PresencaRepositorio {
  late PresencaDao _presencaDao;

  PresencaRepositorio() {
    _presencaDao = GetIt.instance.get<PresencaDao>();
  }

  Future<void> inserir(Presenca presenca) async {
    await _presencaDao.inserir(presenca);
  }

  Stream<List<Presenca>> assistirListaDePresencaDaTurma(String turmaId) async* {
    yield* _presencaDao.assistirListaDePresencaDaTurma(turmaId);
  }

  Future<List<Aluno>> listarAlunosPresentes() async {
    return await _presencaDao.listarAlunosPresentes();
  }

  Future<List<Aluno>> listarAlunosFaltates() async {
    return await _presencaDao.listarAlunosFaltates();
  }

  Future<List<Presenca>> listarPresencasDoAluno(String alunoId, DateTime inicio, DateTime fim, bool presente) async {
    return await _presencaDao.listarPresencasDoAluno(alunoId, inicio, fim, presente);
  }
}