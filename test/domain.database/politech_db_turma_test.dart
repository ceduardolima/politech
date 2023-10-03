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
      final turma = Turma.genId("Turma 01");
      final aluno = Aluno.genId("123", "Eduardo", "1234567890", turma.id);
      turmaDao.inserir(turma);
      alunoDao.inserir(aluno);
      final alunosDaTurma = await turmaDao.listarAlunos(turma.id);
      expect(alunosDaTurma, const TypeMatcher<List<Aluno>>());
      expect(alunosDaTurma, isNotEmpty);
    });
  });
}