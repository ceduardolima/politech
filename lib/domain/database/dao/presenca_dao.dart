import 'package:floor/floor.dart';
import 'package:politech/domain/aluno/aluno.dart';
import 'package:politech/domain/presenca/presenca.dart';

@dao
abstract class PresencaDao {
  @Insert(onConflict: OnConflictStrategy.fail)
  Future<void> inserir(Presenca presenca);

  @Insert(onConflict: OnConflictStrategy.fail)
  Future<void> inserirLista(List<Presenca> presenca);

  @Query("SELECT * FROM presencas WHERE chamada_id = :chamadaId")
  Stream<List<Presenca>> assistirListaDePresencaDaTurma(String chamadaId);

  @Query("SELECT alunos.* FROM alunos LEFT JOIN presencas ON alunos.id = presencas.aluno_id WHERE presente = 1")
  Future<List<Aluno>> listarAlunosPresentes();

  @Query("SELECT alunos.* FROM alunos LEFT JOIN presencas ON alunos.id = presencas.aluno_id WHERE presente = 0")
  Future<List<Aluno>> listarAlunosFaltates();
  
  @Query("SELECT * FROM presencas "
      "WHERE presente = :presente AND data >= :inicio AND data <= :fim AND aluno_id = :alunoId")
  Future<List<Presenca>> listarPresencasDoAluno(String alunoId, DateTime inicio, DateTime fim, bool presente);

  @Query("SELECT alunos.* FROM alunos "
      "LEFT JOIN presencas ON alunos.id = presencas.aluno_id "
      "WHERE presencas.chamada_id = :chamadaId AND presencas.presente = :presenca")
  Future<List<Aluno>> listarAlunosDaChamada(String chamadaId, bool presenca);

  @Query("DELETE FROM presencas WHERE chamada_id = :chamadaId")
  Future<void> excluirPresencaDaChamada(String chamadaId);

  @Query("DELETE FROM presencas WHERE chamada_id "
      "IN (SELECT id FROM chamadas WHERE chamadas.turma_id = :turmaId)")
  Future<void> excluirPresencaDaTurma(String turmaId);

  @delete
  Future<void> excluir(Presenca presenca);
}