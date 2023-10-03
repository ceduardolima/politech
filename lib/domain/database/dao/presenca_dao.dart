import 'package:floor/floor.dart';
import 'package:politech/domain/aluno/aluno.dart';
import 'package:politech/domain/presenca/presenca.dart';

@dao
abstract class PresencaDao {
  @Insert(onConflict: OnConflictStrategy.fail)
  Future<void> inserir(Presenca presenca);

  @Query("SELECT alunos.* FROM alunos LEFT JOIN presencas ON alunos.id = presencas.aluno_id WHERE presente = 1")
  Future<List<Aluno>> listarAlunosPresentes();

  @Query("SELECT alunos.* FROM alunos LEFT JOIN presencas ON alunos.id = presencas.aluno_id WHERE presente = 0")
  Future<List<Aluno>> listarAlunosFaltates();
  
  @Query("SELECT * FROM presencas "
      "WHERE presente = :presente AND data >= :inicio AND data <= :fim AND aluno_id = :alunoId")
  Future<List<Presenca>> listarPresencasDoAluno(String alunoId, int inicio, int fim, bool presente);
}