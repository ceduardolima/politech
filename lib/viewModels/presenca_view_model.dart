import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:politech/domain/repositorio/presenca_repositorio.dart';

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

  Future<void> inserirAlunosPresentes(String chamadaId, DateTime data, List<String> listaAlunoId) async {
    List<Presenca> presencas = listaAlunoId.map((e) =>
        Presenca.genId(e, true, data, chamadaId)).toList();
    await _presencaRepositorio.inserirLista(presencas);
  }

  List<Presenca> get listaDePresencas => _presencas;

  PresencaRepositorio get presenca => _presencaRepositorio;
}