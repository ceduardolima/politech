import 'dart:async';

import 'package:floor/floor.dart';
import 'package:politech/domain/aluno/aluno.dart';
import 'package:politech/domain/database/dao/aluno_dao.dart';
import 'package:politech/domain/database/dao/presenca_dao.dart';
import 'package:politech/domain/database/dao/turma_dao.dart';
import 'package:politech/domain/database/dao/usuario_dao.dart';
import 'package:politech/domain/presenca/presenca.dart';
import 'package:politech/domain/turma/turma.dart';
import 'package:politech/domain/usuario/usuario.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'politech_db.g.dart';

@Database(version: 2, entities: [Usuario, Aluno, Presenca, Turma])
abstract class PolitechDb extends FloorDatabase {
  UsuarioDao get usuarioDao;
  AlunoDao get alunoDao;
  PresencaDao get presencaDao;
  TurmaDao get turmaDao;
}