import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:politech/casosDeUso/cadastro_turma_caso_de_uso.dart';
import 'package:politech/domain/horario/horario.dart';
import 'package:politech/domain/repositorio/horario_repositorio.dart';
import 'package:politech/viewModels/banco_de_dados_view_model_padrao.dart';

class HorarioViewModel extends BancoDeDadosViewModelPadrao<Horario> {
  List<Horario> horarios = [];
  late HorarioRepositorio _repositorioHorario;

  HorarioViewModel() {
    _repositorioHorario = GetIt.instance.get<HorarioRepositorio>();
    repositrio = _repositorioHorario;
  }

  Future<List<Horario>> listarHorariosDaTurma(String turmaId) async =>
      _repositorioHorario.listarPorTurma(turmaId);

  Future<void> excluirPorTurmaId(String turmaId) async =>
      _repositorioHorario.excluirPorTurmaId(turmaId);
}
