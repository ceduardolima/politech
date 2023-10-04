import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:politech/domain/database/dao/aluno_dao.dart';
import 'package:politech/domain/database/dao/chamada_dao.dart';
import 'package:politech/domain/database/dao/presenca_dao.dart';
import 'package:politech/domain/database/dao/turma_dao.dart';
import 'package:politech/domain/database/dao/usuario_dao.dart';
import 'package:politech/domain/database/politech_db.dart';
import 'package:politech/paginas/login_pagina.dart';
import 'package:politech/theme/colors_theme.dart';
import 'package:politech/viewModels/usuario_view_model.dart';
import 'package:politech/domain/repositorio/aluno_repositorio.dart';
import 'package:politech/domain/repositorio/chamada_repositorio.dart';
import 'package:politech/domain/repositorio/presenca_repositorio.dart';
import 'package:politech/domain/repositorio/turma_repositorio.dart';
import 'package:politech/domain/repositorio/usuario_repositorio.dart';
import 'package:politech/paginas/chamada_pagina.dart';
import 'package:politech/viewModels/aluno_view_model.dart';
import 'package:politech/viewModels/chamada_view_model.dart';
import 'package:politech/viewModels/presenca_view_model.dart';
import 'package:politech/viewModels/turma_view_model.dart';
import 'package:provider/provider.dart';

import 'domain/turma/turma.dart';

void main() {
  criarSingletons();
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ChamadaViewModel()),
          ChangeNotifierProvider(create: (_) => TurmaViewModel()),
          ChangeNotifierProvider(create: (_) => AlunoViewModel()),
          ChangeNotifierProvider(create: (_) => PresencaViewModel()),
          ChangeNotifierProvider(create: (_) => UsuarioViewModel())
        ],
    child: MaterialApp(
      theme: ThemeData(
        colorScheme: ColorsTheme().lightColorsScheme()
      ),
      initialRoute: 'lib/paginas/', // Rota inicial como '/login'
      routes: {
        'lib/paginas/': (context) => TelaLogin(),
      },
        home: FutureBuilder(
          future: GetIt.instance.allReady(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return const TelaLogin();
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    ),
  );
}

void criarSingletons() {
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
  getIt.registerSingletonWithDependencies<ChamadaDao>(
      () => GetIt.instance.get<PolitechDb>().chamadaDao,
      dependsOn: [PolitechDb]);
  getIt.registerSingletonWithDependencies<UsuarioRepositorio>(
      () => UsuarioRepositorio(),
      dependsOn: [PolitechDb, UsuarioDao]);
  getIt.registerSingletonWithDependencies<AlunoRepositorio>(
      () => AlunoRepositorio(),
      dependsOn: [PolitechDb, AlunoDao]);
  getIt.registerSingletonWithDependencies<TurmaRepositorio>(
      () => TurmaRepositorio(),
      dependsOn: [PolitechDb, TurmaDao]);
  getIt.registerSingletonWithDependencies<PresencaRepositorio>(
      () => PresencaRepositorio(),
      dependsOn: [PolitechDb, PresencaDao]);
  getIt.registerSingletonWithDependencies<ChamadaRepositorio>(
      () => ChamadaRepositorio(),
      dependsOn: [PolitechDb, ChamadaDao]);
}
