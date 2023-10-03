import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:politech/domain/aluno/aluno.dart';
import 'package:politech/domain/database/dao/aluno_dao.dart';
import 'package:politech/domain/database/dao/turma_dao.dart';
import 'package:politech/domain/database/politech_db.dart';
import 'package:politech/domain/turma/turma.dart';

void main() {
  group("Teste da entidade Turma", () {
    late PolitechDb banco;
    late TurmaDao turmaDao;
    late AlunoDao alunoDao;

    setUp(() async {
      banco = await $FloorPolitechDb
          .inMemoryDatabaseBuilder()
          .build();
      alunoDao = banco.alunoDao;
      turmaDao = banco.turmaDao;
    });

    tearDown(() async {
      banco.close();
    });

    test("Inserindo turmas", () async {
      final aluno = Aluno.genId("123", "Eduardo", "1234567890");
      alunoDao.inserir(aluno);
      turmaDao.inserir(Turma.genId(aluno.id, "Turma 01"));
      final alunosDaTurma = await turmaDao.listarAlunos("Turma 01");
      expect(alunosDaTurma, const TypeMatcher<List<Aluno>>());
      expect(alunosDaTurma, isNotEmpty);
    });

    test("Apagando turma", () async {
      final aluno = Aluno.genId("123", "Eduardo", "1234567890");
      final turma = Turma.genId(aluno.id, "Turma 01");
      alunoDao.inserir(aluno);
      turmaDao.inserir(turma);
      turmaDao.excluir(turma);
      final alunos = await turmaDao.listarAlunos("Turma 01");
      expect(alunos, const TypeMatcher<List<Aluno>>());
      expect(alunos, isEmpty);
    });
  });
}