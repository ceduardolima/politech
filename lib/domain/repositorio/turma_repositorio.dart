import 'package:floor/floor.dart';
import 'package:get_it/get_it.dart';
import 'package:politech/domain/database/dao/turma_dao.dart';
import 'package:politech/domain/repositorio/banco_de_dados_repositorio_padrao.dart';

import '../aluno/aluno.dart';
import '../turma/turma.dart';

class TurmaRepositorio extends BandoDeDadosRepositorioPadrao<Turma> {
  late TurmaDao _turmaDao;

  TurmaRepositorio() {
    _turmaDao = GetIt.instance.get<TurmaDao>();
    daoPadrao = _turmaDao;
  }

  @transaction
  Stream<List<Turma>> assistirListaDeTurmas() async* {
    yield* _turmaDao.assistirListaDeTurmas();
  }

  @transaction
  Future<List<Aluno>> listarAlunos(String turmaId) async {
    return await _turmaDao.listarAlunos(turmaId);
  }
}