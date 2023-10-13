import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:politech/paginas/login_pagina.dart';
import 'package:politech/servicos/servico_autenticacao.dart';
import 'package:politech/theme/colors_theme.dart';
import 'package:politech/viewModels/aluno_view_model.dart';
import 'package:politech/viewModels/chamada_view_model.dart';
import 'package:politech/viewModels/presenca_view_model.dart';
import 'package:politech/viewModels/turma_view_model.dart';
import 'package:politech/viewModels/usuario_view_model.dart';
import 'package:politech/widgets/autenticacao/auto_autenticacao.dart';
import 'package:provider/provider.dart';
import 'config/init_config.dart';


void main() async {
  await initConfig();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ServicoAutenticacao()),
        ChangeNotifierProvider(create: (_) => ChamadaViewModel()),
        ChangeNotifierProvider(create: (_) => TurmaViewModel()),
        ChangeNotifierProvider(create: (_) => AlunoViewModel()),
        ChangeNotifierProvider(create: (_) => PresencaViewModel()),
        ChangeNotifierProvider(create: (_) => UsuarioViewModel())
      ],
      child: MaterialApp(
        theme: ThemeData(colorScheme: ColorsTheme().lightColorsScheme()),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: const [Locale('pt', 'BR')],
        locale: const Locale('pt', 'BR'),
        home: FutureBuilder(
          future: GetIt.instance.allReady(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return const AutoAutenticacao();
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
