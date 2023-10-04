import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:politech/domain/repositorio/chamada_repositorio.dart';

import '../domain/chamada/chamada.dart';

class ChamadaViewModel extends ChangeNotifier {
  late ChamadaRepositorio _chamadaRepositorio;
  List<Chamada> _chamadas = [];

  ChamadaViewModel() {
    _chamadaRepositorio = GetIt.instance.get<ChamadaRepositorio>();
  }

  ChamadaViewModel.comTurma(String turmaId) {
    _chamadaRepositorio = GetIt.instance.get<ChamadaRepositorio>();
    assistirChamada(turmaId);
  }

  void assistirChamada(String turmaId) {
    _chamadaRepositorio.assistirChamadasDaTurma(turmaId).listen((lista) {
      _chamadas = lista;
      notifyListeners();
    });
  }

  Future<void> inserir(Chamada chamada) async {
    await _chamadaRepositorio.inserir(chamada);
    notifyListeners();
  }

  List<Chamada> get listaChamadas => _chamadas;

  ChamadaRepositorio get chamada => _chamadaRepositorio;
}