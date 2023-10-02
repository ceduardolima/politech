import 'package:flutter_test/flutter_test.dart';
import 'package:politech/domain/aluno/aluno.dart';
import 'package:politech/domain/database/dao/aluno_dao.dart';
import 'package:politech/domain/database/politech_db.dart';

void main() {
  group("Test da Dao Aluno do banco de dados Politech", () {
    late PolitechDb banco;
    late AlunoDao alunoDao;

    setUp(() async {
      banco = await $FloorPolitechDb
          .inMemoryDatabaseBuilder()
          .build();
      alunoDao = banco.alunoDao;
    });

    tearDown(() async {
      banco.close();
    });

    test("Inserindo aluno do banco de dados", () async {
      Aluno aluno = Aluno.genId("12345", "Eduardo", "12345678901");
      alunoDao.inserir(aluno);
      final alunoInserido = await alunoDao.procurarPorId(aluno.id);
      expect(alunoInserido!.id, equals(aluno.id));
    });

    test("Procurando aluno pelo nome", () async {
      Aluno aluno = Aluno.genId("12345", "Eduardo", "12345678901");
      alunoDao.inserir(aluno);
      final alunoInserido = await alunoDao.procurarPorNome(aluno.nome);
      expect(alunoInserido, isNotEmpty);
      expect(alunoInserido[0].id, equals(aluno.id));
    });

    test("Procurando aluno pelo número de inscrição", () async {
      Aluno aluno = Aluno.genId("12345", "Eduardo", "12345678901");
      alunoDao.inserir(aluno);
      final alunoInserido = await alunoDao.procurarPorInscricao(aluno.numInscricao);
      expect(alunoInserido!.numInscricao, equals(aluno.numInscricao));
    });

    test("Listar todos os alunos", () async* {
      Aluno aluno_1 = Aluno.genId("12345", "Eduardo", "12345678901");
      Aluno aluno_2 = Aluno.genId("12346", "Eduardo", "12345678902");
      Aluno aluno_3 = Aluno.genId("12347", "Eduardo", "12345678903");
      alunoDao.inserir(aluno_1);
      alunoDao.inserir(aluno_2);
      alunoDao.inserir(aluno_3);
      final alunoStream = alunoDao.listar();
      final tamanho = await alunoStream.length;
      expect(tamanho, equals(3));
    });

    test("Listar todos os alunos com limite", () async* {
      Aluno aluno_1 = Aluno.genId("12345", "Eduardo", "12345678901");
      Aluno aluno_2 = Aluno.genId("12346", "Eduardo", "12345678902");
      Aluno aluno_3 = Aluno.genId("12347", "Eduardo", "12345678903");
      alunoDao.inserir(aluno_1);
      alunoDao.inserir(aluno_2);
      alunoDao.inserir(aluno_3);
      final alunosStream = alunoDao.listarComLimite(2);
      final tamanho = await alunosStream.length;
      expect(tamanho, equals(2));
    });

    test("Atualizar um aluno", () async {
      Aluno aluno = Aluno.genId("12345", "Eduardo", "12345678901");
      alunoDao.inserir(aluno);
      aluno.nome = "Matheus";
      alunoDao.atualizar(aluno);
      final alunoAtualizado = await alunoDao.procurarPorId(aluno.id);
      expect(alunoAtualizado!.nome, equals(aluno.nome));
    });

    test("Inserindo número de inscrição duplicado", () async* {
      Aluno aluno_1 = Aluno.genId("12345", "Eduardo", "12345678901");
      Aluno aluno_2 = Aluno.genId("12345", "Eduardo", "12345678902");
      alunoDao.inserir(aluno_1);
      alunoDao.inserir(aluno_2);
      final alunoStream = alunoDao.listar();
      final tamanho = await alunoStream.length;
      expect(tamanho, equals(1));
    });

    test("Inserindo cpf duplicado", () async* {
      Aluno aluno_1 = Aluno.genId("12345", "Eduardo", "12345678901");
      Aluno aluno_2 = Aluno.genId("12344", "Eduardo", "12345678901");
      alunoDao.inserir(aluno_1);
      alunoDao.inserir(aluno_2);
      final alunoStream = alunoDao.listar();
      final tamanho = await alunoStream.length;
      expect(tamanho, equals(1));
    });
  });
}