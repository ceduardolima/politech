import 'package:floor/floor.dart';
import 'package:politech/domain/aluno/aluno.dart';
import 'package:politech/domain/presenca/presenca.dart';

@dao
abstract class PresencaDao {
  @Insert(onConflict: OnConflictStrategy.fail)
  Future<void> inserir(Presenca presenca);

  @Insert(onConflict: OnConflictStrategy.fail)
  Future<void> inserirLista(List<Presenca> presenca);

  @Query("SELECT presencas.* FROM turmas LEFT JOIN presencas ON turmas.id= presencas.turma_id WHERE presencas.turma_id = :turmaId")
  Stream<List<Presenca>> assistirListaDePresencaDaTurma(String turmaId);

  @Query("SELECT alunos.* FROM alunos LEFT JOIN presencas ON alunos.id = presencas.aluno_id WHERE presente = 1")
  Future<List<Aluno>> listarAlunosPresentes();

  @Query("SELECT alunos.* FROM alunos LEFT JOIN presencas ON alunos.id = presencas.aluno_id WHERE presente = 0")
  Future<List<Aluno>> listarAlunosFaltates();
  
  @Query("SELECT * FROM presencas "
      "WHERE presente = :presente AND data >= :inicio AND data <= :fim AND aluno_id = :alunoId")
  Future<List<Presenca>> listarPresencasDoAluno(String alunoId, DateTime inicio, DateTime fim, bool presente);

  @delete
  Future<void> excluir(Presenca presenca);
}