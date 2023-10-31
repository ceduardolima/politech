import 'package:floor/floor.dart';
import 'package:politech/domain/database/dao/dao_padrao.dart';
import 'package:politech/domain/horario/horario.dart';

@dao
abstract class HorarioDao implements DaoPadrao<Horario> {
  @Query("SELECT * FROM horarios WHERE turma_id=:turmaId")
  Future<List<Horario>> listarPorTurma(String turmaId);
  
  @Query("DELETE FROM horarios WHERE turma_id=:turmaId")
  Future<void> excluirPorTurmaId(String turmaId);
}