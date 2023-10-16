import 'package:floor/floor.dart';
import 'package:get_it/get_it.dart';
import 'package:politech/domain/database/dao/aluno_dao.dart';

import '../aluno/aluno.dart';

class AlunoRepositorio {
  late AlunoDao _alunoDao;

  AlunoRepositorio() {
    _alunoDao =GetIt.instance.get<AlunoDao>();
  }

  @transaction
  Future<void> inserir(Aluno aluno) async {
    await _alunoDao.inserir(aluno);
  }

  @transaction
  Future<void> inserirLista(List<Aluno> alunos) async {
    await _alunoDao.inserirLista(alunos);
  }

  @transaction
  Future<List<Aluno>> listar() async {
    return await _alunoDao.listar();
  }

  @transaction
  Stream<List<Aluno>> assistirListaDeAlunos() async* {
    yield* _alunoDao.assistirListaAluno();
  }

  @transaction
  Future<List<Aluno>> listarComLimite(int limite) async {
    return await _alunoDao.listarComLimite(limite);
  }

  @transaction
  Future<void> atualizar(Aluno aluno) async {
    await _alunoDao.atualizar(aluno);
  }

  @transaction
  Future<Aluno?> procurarPorId(String id) async {
    return await _alunoDao.procurarPorId(id);
  }

  @transaction
  Future<List<Aluno>> procurarPorNome(String nome) async {
    return await _alunoDao.procurarPorNome(nome);
  }

  @transaction
  Future<bool> excluirAlunosDaTurma(String turmaId) async {
    int? value = await _alunoDao.excluirAlunosDaTurma(turmaId);
    return value != null ? (value == 1) : false;
  }

  @transaction
  Future<void> excluir(Aluno aluno) async {
    await _alunoDao.excluir(aluno);
  }
}