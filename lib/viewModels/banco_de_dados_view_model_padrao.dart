import 'package:flutter/cupertino.dart';
import 'package:politech/domain/repositorio/banco_de_dados_repositorio_padrao.dart';

abstract class BancoDeDadosViewModelPadrao<T> extends ChangeNotifier {
  late BandoDeDadosRepositorioPadrao<T> repositrio;

  Future<void> inserir(T t) async {
    await repositrio.inserir(t);
    notifyListeners();
  }

  Future<void> inserirLista(List<T> t) async {
    await repositrio.inserirLista(t);
    notifyListeners();
  }

  Future<void> atuaizar(T t) async {
    await repositrio.atuaizar(t);
    notifyListeners();
  }

  Future<void> atuaizarLista(List<T> t) async {
    await repositrio.atuaizarLista(t);
    notifyListeners();
  }

  Future<void> excluir(T t) async {
    await repositrio.excluir(t);
    notifyListeners();
  }

    Future<void> excluirLista(List<T> t) async {
      await repositrio.excluirLista(t);
      notifyListeners();
    }
}
