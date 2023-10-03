import 'package:floor/floor.dart';
import 'package:politech/domain/aluno/aluno.dart';
import 'package:politech/domain/turma/turma.dart';

@dao
abstract class TurmaDao {
  @Insert(onConflict: OnConflictStrategy.fail)
  Future<void> inserir(Turma turma);

  @Insert(onConflict: OnConflictStrategy.fail)
  Future<void> inserirLista(List<Turma> turma);
  @Query("SELECT * FROM turmas")
  Stream<List<Turma>> assistirListaDeTurmas();

  @Query("SELECT alunos.* FROM turmas LEFT JOIN alunos ON alunos.turma_id = turmas.id WHERE turmas.id = :turmaId")
  Future<List<Aluno>> listarAlunos(String turmaId);

  @delete
  Future<void> excluir(Turma turma);
}