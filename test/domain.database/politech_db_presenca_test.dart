import 'package:flutter_test/flutter_test.dart';
import 'package:politech/domain/aluno/aluno.dart';
import 'package:politech/domain/chamada/chamada.dart';
import 'package:politech/domain/database/dao/aluno_dao.dart';
import 'package:politech/domain/database/dao/chamada_dao.dart';
import 'package:politech/domain/database/dao/presenca_dao.dart';
import 'package:politech/domain/database/dao/turma_dao.dart';
import 'package:politech/domain/database/politech_db.dart';
import 'package:politech/domain/presenca/presenca.dart';
import 'package:politech/domain/turma/turma.dart';

void main() {
  group("Teste da entidade Presenca", () {
    late PolitechDb banco;
    late PresencaDao presencaDao;
    late AlunoDao alunoDao;
    late TurmaDao turmaDao;
    late ChamadaDao chamadaDao;
    Turma turma = Turma.genId("Turma 01", "MF");
    Chamada chamada = Chamada.genId(DateTime.now(), turma.id);

    setUp(() async {
      banco = await $FloorPolitechDb.inMemoryDatabaseBuilder().build();
      alunoDao = banco.alunoDao;
      presencaDao = banco.presencaDao;
      turmaDao = banco.turmaDao;
      chamadaDao = banco.chamadaDao;
      await turmaDao.inserir(turma);
      await chamadaDao.inserir(chamada);
    });

    tearDown(() async {
      banco.close();
    });

    test("Listando alunos Presentes", () async {
      final now = DateTime.now();
      final aluno_1 = Aluno.genId("12345", "Eduardo", "123", turma.id);
      final aluno_2 = Aluno.genId("123456", "Eduardo", "1234", turma.id);
      alunoDao.inserirLista([aluno_1, aluno_2]);
      presencaDao.inserirLista([
        Presenca.genId(aluno_1.id, true, now, chamada.id),
        Presenca.genId(aluno_2.id, true, now, chamada.id)
      ]);
      final lista = await presencaDao.listarAlunosPresentes();
      expect(lista, const TypeMatcher<List<Aluno>>());
      expect(lista.length, equals(2));
    });

    test("Listando presenca de um aluno em um determinado período de tempo",
        () async {
      final now = DateTime.now();
      final day_1 = DateTime(2023, 9, 29);
      final day_2 = DateTime(2023, 9, 30);
      final aluno_1 = Aluno.genId("12345", "Eduardo", "123", turma.id);
      alunoDao.inserir(aluno_1);
      presencaDao.inserirLista([
        Presenca.genId(aluno_1.id, true, now, chamada.id),
        Presenca.genId(aluno_1.id, true, day_1, chamada.id),
        Presenca.genId(aluno_1.id, true, day_2, chamada.id)
      ]);
      final lista = await presencaDao.listarPresencasDoAluno(
          aluno_1.id, day_2, now, true);
      expect(lista, const TypeMatcher<List<Presenca>>());
      expect(lista.length, equals(2));
    });

    test("Exlcuindo presenca", () async {
      final now = DateTime.now();
      final day_1 = DateTime(2023, 9, 29);
      final day_2 = DateTime(2023, 9, 30);
      final aluno_1 = Aluno.genId("12345", "Eduardo", "123", turma.id);
      final presenca = Presenca.genId(aluno_1.id, true, now, chamada.id);
      alunoDao.inserir(aluno_1);
      presencaDao.inserirLista([
        presenca,
        Presenca.genId(aluno_1.id, true, day_1, chamada.id),
        Presenca.genId(aluno_1.id, true, day_2, chamada.id)
      ]);
      presencaDao.excluir(presenca);
      final listaPresenca = await presencaDao.listarPresencasDoAluno(
          aluno_1.id, day_1, now, true);
      expect(listaPresenca, const TypeMatcher<List<Presenca>>());
      expect(listaPresenca.length, equals(2));
    });
  });

  group("Teste de serialização", () {
    test("Aluno para json", () {
      final presenca = Presenca.genId("123", true, DateTime.now(), "1");
      final presencaJson = presenca.toJson();
      expect(presencaJson, TypeMatcher<Map>());
      expect(presencaJson["id"], equals(presenca.id));
    });

    test("Json to entity", () {
      final presencaJson = {
        "id": "12345",
        "alunoId": "1234",
        "chamadaId": "1234",
        "presente": true,
        "data": DateTime.now().toString()
      };
      final presenca = Presenca.fromJson(presencaJson);
      expect(presenca, TypeMatcher<Presenca>());
      expect(presenca.id, equals(presencaJson["id"]));
    });
  });
}
