import 'package:get_it/get_it.dart';
import 'package:politech/domain/database/dao/chamada_dao.dart';

import '../chamada/chamada.dart';

class ChamadaRepositorio {
  late ChamadaDao _chamadaDao;

  ChamadaRepositorio() {
    _chamadaDao = GetIt.instance.get<ChamadaDao>();
  }

  Future<void> inserir(Chamada chamada) async {
    await _chamadaDao.inserir(chamada);
  }

  Future<void> inserirLista(List<Chamada> chamada) async {
    await _chamadaDao.inserirLista(chamada);
}

  Stream<List<Chamada>> assistirChamadasDaTurma(String turmaId) async* {
    yield* _chamadaDao.assistirChamadasDaTurma(turmaId);
  }

  Future<List<Chamada>> listarChamadasDaTurma(String turmaId) async {
    return await _chamadaDao.listarChamadasDaTurma(turmaId);
  }

  Future<void> atualizar(Chamada chamada) async {
    await _chamadaDao.atualizar(chamada);
  }

  Future<void> excluirChamadasDaTurma(String turmaId) async {
    await _chamadaDao.excluirChamadasDaTurma(turmaId);
  }

  Future<void> excluir(Chamada chamada) async {
    await _chamadaDao.excluir(chamada);
  }
}