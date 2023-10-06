import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:politech/domain/repositorio/usuario_repositorio.dart';
import 'package:politech/firebase_options.dart';

import '../domain/database/dao/aluno_dao.dart';
import '../domain/database/dao/presenca_dao.dart';
import '../domain/database/dao/turma_dao.dart';
import '../domain/database/dao/usuario_dao.dart';
import '../domain/database/politech_db.dart';

Future<void> initConfig() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  GetIt getIt = GetIt.instance;
  getIt.registerSingletonAsync<PolitechDb>(
          () async => $FloorPolitechDb.databaseBuilder('politech_db.db').build());
  getIt.registerSingletonWithDependencies<UsuarioDao>(
          () => GetIt.instance.get<PolitechDb>().usuarioDao,
      dependsOn: [PolitechDb]);
  getIt.registerSingletonWithDependencies<AlunoDao>(
          () => GetIt.instance.get<PolitechDb>().alunoDao,
      dependsOn: [PolitechDb]);
  getIt.registerSingletonWithDependencies<TurmaDao>(
          () => GetIt.instance.get<PolitechDb>().turmaDao,
      dependsOn: [PolitechDb]);
  getIt.registerSingletonWithDependencies<PresencaDao>(
          () => GetIt.instance.get<PolitechDb>().presencaDao,
      dependsOn: [PolitechDb]);
  getIt.registerSingletonWithDependencies<UsuarioRepositorio>(
          () => UsuarioRepositorio(),
      dependsOn: [PolitechDb, UsuarioDao]);
}

