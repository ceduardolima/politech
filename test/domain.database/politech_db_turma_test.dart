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
  group("Teste da entidade Turma", () {
    late PolitechDb banco;
    late TurmaDao turmaDao;
    late AlunoDao alunoDao;
    late ChamadaDao chamadaDao;
    late PresencaDao presencaDao;

    setUp(() async {
      banco = await $FloorPolitechDb
          .inMemoryDatabaseBuilder()
          .build();
      alunoDao = banco.alunoDao;
      turmaDao = banco.turmaDao;
      chamadaDao = banco.chamadaDao;
      presencaDao = banco.presencaDao;
    });

    tearDown(() async {
      banco.close();
    });

    test("Inserindo turmas", () async {
      final turma = Turma.genId("Turma 01", "MF");
      final aluno = Aluno.genId("123", "Eduardo", "1234567890", turma.id);
      turmaDao.inserir(turma);
      alunoDao.inserir(aluno);
      final alunosDaTurma = await turmaDao.listarAlunos(turma.id);
      expect(alunosDaTurma, const TypeMatcher<List<Aluno>>());
      expect(alunosDaTurma, isNotEmpty);
    });

    test("Excluir turma", () async* {
      final turma = Turma.genId("Turma 01", "MF");
      turmaDao.inserir(turma);
      turmaDao.excluir(turma);
      final stream = turmaDao.assistirListaDeTurmas();
      final alunosDaTurma = await stream.first;
      expect(alunosDaTurma, const TypeMatcher<List<Turma>>());
      expect(alunosDaTurma, isEmpty);
    });
  });

  group("Teste de serialização", () {
    test("Aluno para json", () {
      final turma = Turma.genId("123", "MF");
      final turmaJson = turma.toJson();
      expect(turmaJson, TypeMatcher<Map>());
      expect(turmaJson["id"], equals(turma.id));
    });

    test("Json to entity", () {
      final turmaJson = {"id":"12345", "nome":"Turma 01"};
      final presenca = Turma.fromJson(turmaJson);
      expect(presenca, TypeMatcher<Turma>());
      expect(presenca.id, equals(turmaJson["id"]));
    });
  });
}