import 'package:get_it/get_it.dart';
import 'package:politech/domain/database/dao/horario_dao.dart';
import 'package:politech/domain/horario/horario.dart';
import 'package:politech/domain/repositorio/banco_de_dados_repositorio_padrao.dart';


class HorarioRepositorio extends BandoDeDadosRepositorioPadrao<Horario> {
  late HorarioDao _horarioDao;

  HorarioRepositorio() {
    _horarioDao = GetIt.instance.get<HorarioDao>();
    super.daoPadrao = _horarioDao;
  }

  Future<List<Horario>> listarPorTurma(String turmaId) async =>
      await _horarioDao.listarPorTurma(turmaId);
}
