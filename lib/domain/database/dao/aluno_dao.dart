import 'package:floor/floor.dart';
import 'package:politech/domain/aluno/aluno.dart';

@dao
abstract class AlunoDao {
  @Insert(onConflict: OnConflictStrategy.abort)
  Future<void> inserir(Aluno aluno);

  @Insert(onConflict: OnConflictStrategy.abort)
  Future<void> inserirLista(List<Aluno> aluno);

  @Query("SELECT * From alunos LIMIT 20")
  Future<List<Aluno>> listar();

  @Query("SELECT * From alunos")
  Stream<List<Aluno>> assistirListaAluno();

  @Query("SELECT * From alunos LIMIT :limite")
  Future<List<Aluno>> listarComLimite(int limite);

  @update
  Future<void> atualizar(Aluno aluno);

  @Query("SELECT * From alunos WHERE id=:id")
  Future<Aluno?> procurarPorId(String id);

  @Query("SELECT * FROM alunos WHERE nome LIKE :nome LIMIT 20")
  Future<List<Aluno>> procurarPorNome(String nome);

  @Query("DELETE FROM alunos WHERE turma_id = :turmaId")
  Future<int?> excluirAlunosDaTurma(String turmaId);

  @delete
  Future<void> excluir(Aluno aluno);

}