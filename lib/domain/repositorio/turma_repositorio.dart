import 'package:get_it/get_it.dart';
import 'package:politech/domain/database/dao/turma_dao.dart';

import '../aluno/aluno.dart';
import '../turma/turma.dart';

class TurmaRepositorio {
  late TurmaDao _turmaDao;

  TurmaRepositorio() {
    _turmaDao = GetIt.instance.get<TurmaDao>();
  }

  Future<void> inserir(Turma turma) async {
    await _turmaDao.inserir(turma);
  }

  Stream<List<Turma>> assistirListaDeTurmas() async* {
    yield* _turmaDao.assistirListaDeTurmas();
  }

  Future<List<Aluno>> listarAlunos(String nomeDaTurma) async {
    return await _turmaDao.listarAlunos(nomeDaTurma);
  }

  Future<void> excluir(Turma turma) async {
    await _turmaDao.excluir(turma);
  }
}