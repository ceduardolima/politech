import 'package:flutter/material.dart';
import 'package:politech/casosDeUso/cadastro_turma_caso_de_uso.dart';
import 'package:politech/viewModels/chamada_view_model.dart';
import 'package:politech/viewModels/presenca_view_model.dart';
import 'package:politech/viewModels/turma_view_model.dart';
import 'package:politech/viewModels/usuario_view_model.dart';
import 'package:provider/provider.dart';

import '../domain/turma/turma.dart';
import 'aluno_view_model.dart';
import 'horario_view_model.dart';

class DbViewModel extends ChangeNotifier {
  late TurmaViewModel _turmaViewModel;
  late AlunoViewModel _alunoViewModel;
  late HorarioViewModel _horarioViewModel;
  late UsuarioViewModel _usuarioViewModel;
  late ChamadaViewModel _chamadaViewModel;
  late PresencaViewModel _presencaViewModel;

  DbViewModel(BuildContext context) {
    _turmaViewModel = context.read<TurmaViewModel>();
    _alunoViewModel = context.read<AlunoViewModel>();
    _horarioViewModel = context.read<HorarioViewModel>();
    _chamadaViewModel = context.read<ChamadaViewModel>();
    _usuarioViewModel = context.read<UsuarioViewModel>();
    _presencaViewModel = context.read<PresencaViewModel>();
  }

  Future<bool> cadastrarTurmasUsandoMap(Map turmasMap) async {
    final camposExtraidos = CadastroTurmaCasoDeUso(turmasMap);
    final turmasNaoExistentes = _turmaViewModel.turmaExiste(camposExtraidos.turmas);
    final turmaIdList = turmasNaoExistentes.map((e) => e.id).toList();
    if (turmasNaoExistentes.isNotEmpty) {
      final alunos = camposExtraidos.alunos.where((element) => turmaIdList.contains(element.turmaId)).toList();
      final horarios = camposExtraidos.horarios.where((element) => turmaIdList.contains(element.turmaId)).toList();
      await _turmaViewModel.inserirLista(turmasNaoExistentes);
      await _alunoViewModel.inserirLista(alunos);
      await _horarioViewModel.inserirLista(horarios);
      return true;
    }
    return false;
  }

  excluirTurma(Turma turma) async {
    await _presencaViewModel.excluirPresencaDaturma(turma.id);
    await _chamadaViewModel.excluirChamadaDaTurma(turma.id);
    await _alunoViewModel.excluirAlunosDaTurma(turma.id);
    await _horarioViewModel.excluirPorTurmaId(turma.id);
    await _turmaViewModel.excluir(turma);
  }

  PresencaViewModel get presencaViewModel => _presencaViewModel;

  ChamadaViewModel get chamadaViewModel => _chamadaViewModel;

  UsuarioViewModel get usuarioViewModel => _usuarioViewModel;

  HorarioViewModel get horarioViewModel => _horarioViewModel;

  AlunoViewModel get alunoViewModel => _alunoViewModel;

  TurmaViewModel get turmaViewModel => _turmaViewModel;

}