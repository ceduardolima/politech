import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:politech/domain/repositorio/chamada_repositorio.dart';

import '../domain/chamada/chamada.dart';

class ChamadaViewModel extends ChangeNotifier {
  late ChamadaRepositorio _chamadaRepositorio;
  List<Chamada> _chamadas = [];
  final String _turmaId;

  ChamadaViewModel(this._turmaId) {
    _chamadaRepositorio = GetIt.instance.get<ChamadaRepositorio>();
  }

  ChamadaViewModel.comTurma(this._turmaId) {
    _chamadaRepositorio = GetIt.instance.get<ChamadaRepositorio>();
    assistirChamada();
  }

  void assistirChamada() {
    _chamadaRepositorio.assistirChamadasDaTurma(_turmaId).listen((lista) {
      _chamadas = lista;
      notifyListeners();
    });
  }

  List<Chamada> get listaChamadas => _chamadas;

  ChamadaRepositorio get chamada => _chamadaRepositorio;
}