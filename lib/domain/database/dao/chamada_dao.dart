import 'package:floor/floor.dart';
import 'package:politech/domain/chamada/chamada.dart';

@dao
abstract class ChamadaDao {
  @Insert(onConflict: OnConflictStrategy.fail)
  Future<void> inserir(Chamada chamada);

  @Insert(onConflict: OnConflictStrategy.fail)
  Future<void> inserirLista(List<Chamada> chamada);

  @Query("SELECT * FROM chamadas WHERE turma_id = :turmaId ORDER BY data DESC")
  Stream<List<Chamada>> assistirChamadasDaTurma(String turmaId);

  @Query("SELECT * FROM chamadas WHERE turma_id = :turmaId ORDER BY data DESC")
  Future<List<Chamada>> listarChamadasDaTurma(String turmaId);

  @update
  Future<void> atualizar(Chamada chamada);

  @delete
  Future<void> excluir(Chamada chamada);
}