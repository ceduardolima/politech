import 'dart:async';

import 'package:floor/floor.dart';
import 'package:politech/domain/database/dao/usuario_dao.dart';
import 'package:politech/domain/usuario/usuario.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'politech_db.g.dart';

@Database(version: 1, entities: [Usuario])
abstract class PolitechDb extends FloorDatabase {
  UsuarioDao get usuarioDao;
}