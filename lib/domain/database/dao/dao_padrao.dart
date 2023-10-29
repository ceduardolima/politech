import 'package:floor/floor.dart';

@dao
abstract class DaoPadrao<T> {
  @Insert(onConflict: OnConflictStrategy.abort)
  Future<void> inserir(T t);

  @Insert(onConflict: OnConflictStrategy.abort)
  Future<void> inserirLista(List<T> T);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> atuaizar(T t);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> atuaizarLista(List<T> t);

  @delete
  Future<void> excluir(T t);

  @delete
  Future<void> excluirLista(List<T> t);
}