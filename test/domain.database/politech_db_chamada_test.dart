import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:politech/domain/chamada/chamada.dart';
import 'package:politech/domain/database/dao/chamada_dao.dart';
import 'package:politech/domain/database/dao/turma_dao.dart';
import 'package:politech/domain/database/politech_db.dart';
import 'package:politech/domain/turma/turma.dart';

void main() {
  group("Test da Dao Chamada do banco de dados Politech", () {
    late PolitechDb banco;
    late TurmaDao turmaDao;
    late ChamadaDao chamadaDao;
    late Turma turma;

    setUp(() async {
      banco = await $FloorPolitechDb
          .inMemoryDatabaseBuilder()
          .build();
      turmaDao = banco.turmaDao;
      chamadaDao = banco.chamadaDao;
      turma = Turma.genId("Turma 01");
      await turmaDao.inserir(turma);
    });

    tearDown(() async {
      banco.close();
    });

    test("Listar chamadas da turma", () async {
      final now = DateTime.now();
      final chamada_1 = Chamada.genId(now, turma.id);
      final chamada_2 = Chamada.genId(now, turma.id);
      await chamadaDao.inserirLista([chamada_1, chamada_2]);
      final chamadas = await chamadaDao.listarChamadasDaTurma(turma.id);
      expect(chamadas.length, equals(2));
    });
  });
}