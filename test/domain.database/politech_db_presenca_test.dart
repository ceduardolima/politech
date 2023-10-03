import 'package:flutter_test/flutter_test.dart';
import 'package:politech/domain/aluno/aluno.dart';
import 'package:politech/domain/database/dao/aluno_dao.dart';
import 'package:politech/domain/database/dao/presenca_dao.dart';
import 'package:politech/domain/database/politech_db.dart';
import 'package:politech/domain/presenca/presenca.dart';

void main()  {
  group("Teste da entidade Presenca", () {
    late PolitechDb banco;
    late PresencaDao presencaDao;
    late AlunoDao alunoDao;

    setUp(() async {
      banco = await $FloorPolitechDb
          .inMemoryDatabaseBuilder()
          .build();
      alunoDao = banco.alunoDao;
      presencaDao = banco.presencaDao;
    });

    tearDown(() async {
      banco.close();
    });

    test("Listando alunos Presentes", () async {
      int now = DateTime.now().millisecondsSinceEpoch;
      final aluno_1 = Aluno.genId("12345", "Eduardo", "123");
      final aluno_2 = Aluno.genId("123456", "Eduardo", "1234");
      alunoDao.inserir(aluno_1);
      alunoDao.inserir(aluno_2);
      presencaDao.inserir(Presenca.genId(aluno_1.id, true, now));
      presencaDao.inserir(Presenca.genId(aluno_2.id, true, now));
      final lista = await presencaDao.listarAlunosPresentes();
      expect(lista, const TypeMatcher<List<Aluno>>());
      expect(lista.length, equals(2));
    });

    test("Listando presenca de um aluno em um determinado período de tempo", () async {
      int now = DateTime.now().millisecondsSinceEpoch;
      int day_1 = DateTime(2023, 9, 29).millisecondsSinceEpoch;
      int day_2 = DateTime(2023, 9, 30).millisecondsSinceEpoch;
      final aluno_1 = Aluno.genId("12345", "Eduardo", "123");
      alunoDao.inserir(aluno_1);
      presencaDao.inserir(Presenca.genId(aluno_1.id, true, now));
      presencaDao.inserir(Presenca.genId(aluno_1.id, true, day_1));
      presencaDao.inserir(Presenca.genId(aluno_1.id, true, day_2));
      final lista = await presencaDao.listarPresencasDoAluno(aluno_1.id, day_2, now, true);
      expect(lista, const TypeMatcher<List<Presenca>>());
      expect(lista.length, equals(2));
    });
  });
}