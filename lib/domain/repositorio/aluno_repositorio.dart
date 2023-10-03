import 'package:get_it/get_it.dart';
import 'package:politech/domain/database/dao/aluno_dao.dart';

import '../aluno/aluno.dart';

class AlunoRepositorio {
  late AlunoDao _alunoDao;

  AlunoRepositorio() {
    _alunoDao =GetIt.instance.get<AlunoDao>();
  }

  Future<void> inserir(Aluno aluno) async {
    await _alunoDao.inserir(aluno);
  }

  Future<void> inserirLista(List<Aluno> alunos) async {
    await _alunoDao.inserirLista(alunos);
  }
  
  Future<List<Aluno>> listar() async {
    return await _alunoDao.listar();
  }

  Stream<List<Aluno>> assistirListaDeAlunos() async* {
    yield* _alunoDao.assistirListaAluno();
  }

  Future<List<Aluno>> listarComLimite(int limite) async {
    return await _alunoDao.listarComLimite(limite);
  }

  Future<void> atualizar(Aluno aluno) async {
    await _alunoDao.atualizar(aluno);
  }

  Future<Aluno?> procurarPorId(String id) async {
    return await _alunoDao.procurarPorId(id);
  }

  Future<List<Aluno>> procurarPorNome(String nome) async {
    return await _alunoDao.procurarPorNome(nome);
  }

  Future<Aluno?> procurarPorInscricao(String inscricao) async {
    return await _alunoDao.procurarPorInscricao(inscricao);
  }

  Future<void> excluir(Aluno aluno) async {
    await _alunoDao.excluir(aluno);
  }
}