import 'package:floor/floor.dart';
import 'package:politech/domain/database/dao/dao_padrao.dart';

abstract class BandoDeDadosRepositorioPadrao<T> {
  late DaoPadrao<T> daoPadrao;

  @transaction
  Future<void> inserir(T t) async => await daoPadrao.inserir(t);

  @transaction
  Future<void> inserirLista(List<T> t) async => await daoPadrao.inserirLista(t);

  @transaction
  Future<void> atuaizar(T t) async => await daoPadrao.atuaizar(t);

  @transaction
  Future<void> atuaizarLista(List<T> t) async => await daoPadrao.atuaizarLista(t);

  @transaction
  Future<void> excluir(T t) async => await daoPadrao.excluir(t);

  @transaction
  Future<void> excluirLista(List<T> t) async => await daoPadrao.excluirLista(t);
}