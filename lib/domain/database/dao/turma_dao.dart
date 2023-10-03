import 'package:floor/floor.dart';
import 'package:politech/domain/aluno/aluno.dart';
import 'package:politech/domain/turma/turma.dart';

@dao
abstract class TurmaDao {
  @Insert(onConflict: OnConflictStrategy.fail)
  Future<void> inserir(Turma turma);

  @Query("SELECT alunos.* FROM turmas LEFT JOIN alunos ON alunos.id = turmas.aluno_id WHERE turmas.nome = :nomeDaTurma")
  Future<List<Aluno>> listarAlunos(String nomeDaTurma);

  @delete
  Future<void> excluir(Turma turma);
}