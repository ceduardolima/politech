import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:politech/domain/aluno/aluno.dart';
import 'package:politech/domain/database/dao/aluno_dao.dart';
import 'package:politech/domain/database/dao/turma_dao.dart';
import 'package:politech/domain/database/politech_db.dart';
import 'package:politech/domain/turma/turma.dart';

void main() {
  group("Test da Dao Aluno do banco de dados Politech", () {
    late PolitechDb banco;
    late AlunoDao alunoDao;
    late TurmaDao turmaDao;
    late Turma turma;

    setUp(() async {
      banco = await $FloorPolitechDb
          .inMemoryDatabaseBuilder()
          .build();
      alunoDao = banco.alunoDao;
      turmaDao = banco.turmaDao;
      turma = Turma.genId("Turma 01");
      turmaDao.inserir(turma);
    });

    tearDown(() async {
      banco.close();
    });

    test("Inserindo aluno do banco de dados", () async {
      Aluno aluno = Aluno.genId("12345", "Eduardo", "12345678901", turma.id);
      alunoDao.inserir(aluno);
      final alunoInserido = await alunoDao.procurarPorId(aluno.id);
      expect(alunoInserido!.id, equals(aluno.id));
    });

    test("Procurando aluno pelo nome", () async {
      Aluno aluno = Aluno.genId("12345", "Eduardo", "12345678901", turma.id);
      alunoDao.inserir(aluno);
      final alunoInserido = await alunoDao.procurarPorNome(aluno.nome);
      expect(alunoInserido, isNotEmpty);
      expect(alunoInserido[0].id, equals(aluno.id));
    });

    test("Procurando aluno pelo número de inscrição", () async {
      Aluno aluno = Aluno.genId("12345", "Eduardo", "12345678901", turma.id);
      alunoDao.inserir(aluno);
      final alunoInserido = await alunoDao.procurarPorInscricao(aluno.numInscricao);
      expect(alunoInserido!.numInscricao, equals(aluno.numInscricao));
    });

    test("Listar todos os alunos", () async {
      Aluno aluno_1 = Aluno.genId("12345", "Eduardo", "12345678901", turma.id);
      Aluno aluno_2 = Aluno.genId("12346", "Eduardo", "12345678902", turma.id);
      Aluno aluno_3 = Aluno.genId("12347", "Eduardo", "12345678903", turma.id);
      alunoDao.inserirLista([aluno_1, aluno_2, aluno_3]);
      final alunos = await alunoDao.listar();
      expect(alunos.length, equals(3));
    });

    test("Listar todos os alunos com limite", () async {
      Aluno aluno_1 = Aluno.genId("12345", "Eduardo", "12345678901", turma.id);
      Aluno aluno_2 = Aluno.genId("12346", "Eduardo", "12345678902", turma.id);
      Aluno aluno_3 = Aluno.genId("12347", "Eduardo", "12345678903", turma.id);
      alunoDao.inserirLista([aluno_1, aluno_2, aluno_3]);
      final alunos = await alunoDao.listarComLimite(2);
      expect(alunos.length, equals(2));
    });

    test("Atualizar um aluno", () async {
      Aluno aluno = Aluno.genId("12345", "Eduardo", "12345678901", turma.id);
      alunoDao.inserir(aluno);
      aluno.nome = "Matheus";
      alunoDao.atualizar(aluno);
      final alunoAtualizado = await alunoDao.procurarPorId(aluno.id);
      expect(alunoAtualizado!.nome, equals(aluno.nome));
    });


    test("Inserindo número de inscrição duplicado", () async {
      Aluno aluno_1 = Aluno.genId("12345", "Eduardo", "12345678901", turma.id);
      Aluno aluno_2 = Aluno.genId("12345", "Eduardo", "12345678902", turma.id);
      alunoDao.inserir(aluno_1);
      expect(alunoDao.inserir(aluno_2), throwsA(isA<Exception>()));
    });

    test("Inserindo cpf duplicado", () async {
      Aluno aluno_1 = Aluno.genId("12345", "Eduardo", "12345678901", turma.id);
      Aluno aluno_2 = Aluno.genId("12344", "Eduardo", "12345678901", turma.id);
      alunoDao.inserir(aluno_1);
      expect(alunoDao.inserir(aluno_2), throwsA(isA<Exception>()));
    });

    test("Exluir aluno", () async {
      Aluno aluno_1 = Aluno.genId("12345", "Eduardo", "12345678901", turma.id);
      alunoDao.inserir(aluno_1);
      alunoDao.excluir(aluno_1);
      final alunos = await alunoDao.listar();
      expect(alunos, isEmpty);

    });
  });
}