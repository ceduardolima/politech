import 'package:flutter_test/flutter_test.dart';
import 'package:politech/domain/aluno/aluno.dart';
import 'package:politech/domain/database/dao/aluno_dao.dart';
import 'package:politech/domain/database/dao/presenca_dao.dart';
import 'package:politech/domain/database/dao/turma_dao.dart';
import 'package:politech/domain/database/politech_db.dart';
import 'package:politech/domain/presenca/presenca.dart';
import 'package:politech/domain/turma/turma.dart';

void main()  {
  group("Teste da entidade Presenca", () {
    late PolitechDb banco;
    late PresencaDao presencaDao;
    late AlunoDao alunoDao;
    late TurmaDao turmaDao;

    setUp(() async {
      banco = await $FloorPolitechDb
          .inMemoryDatabaseBuilder()
          .build();
      alunoDao = banco.alunoDao;
      presencaDao = banco.presencaDao;
      turmaDao = banco.turmaDao;
    });

    tearDown(() async {
      banco.close();
    });

    test("Listando alunos Presentes", () async {
      final now = DateTime.now();
      final turma_1 = Turma.genId("Turma 01");
      final aluno_1 = Aluno.genId("12345", "Eduardo", "123", turma_1.id);
      final aluno_2 = Aluno.genId("123456", "Eduardo", "1234", turma_1.id);
      turmaDao.inserir(turma_1);
      alunoDao.inserir(aluno_1);
      alunoDao.inserir(aluno_2);
      presencaDao.inserir(Presenca.genId(aluno_1.id, true, now, turma_1.id));
      presencaDao.inserir(Presenca.genId(aluno_2.id, true, now, turma_1.id));
      final lista = await presencaDao.listarAlunosPresentes();
      expect(lista, const TypeMatcher<List<Aluno>>());
      expect(lista.length, equals(2));
    });

    test("Listando presenca de um aluno em um determinado período de tempo", () async {
      final now = DateTime.now();
      final day_1 = DateTime(2023, 9, 29);
      final day_2 = DateTime(2023, 9, 30);
      final turma_1 = Turma.genId("Turma 01");
      final aluno_1 = Aluno.genId("12345", "Eduardo", "123", turma_1.id);
      turmaDao.inserir(turma_1);
      alunoDao.inserir(aluno_1);
      presencaDao.inserir(Presenca.genId(aluno_1.id, true, now, turma_1.id));
      presencaDao.inserir(Presenca.genId(aluno_1.id, true, day_1, turma_1.id));
      presencaDao.inserir(Presenca.genId(aluno_1.id, true, day_2, turma_1.id));
      final lista = await presencaDao.listarPresencasDoAluno(aluno_1.id, day_2, now, true);
      expect(lista, const TypeMatcher<List<Presenca>>());
      expect(lista.length, equals(2));
    });
  });
}