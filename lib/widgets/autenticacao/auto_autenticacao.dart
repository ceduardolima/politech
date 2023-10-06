import 'package:flutter/material.dart';
import 'package:politech/paginas/login_pagina.dart';
import 'package:politech/servicos/servico_autenticacao.dart';
import 'package:provider/provider.dart';

class AutoAutenticacao extends StatefulWidget {
  const AutoAutenticacao({super.key});

  @override
  State<AutoAutenticacao> createState() => _AutoAutenticacaoState();
}

class _AutoAutenticacaoState extends State<AutoAutenticacao> {
  @override
  Widget build(BuildContext context) {
    ServicoAutenticacao autenticacao = context.watch<ServicoAutenticacao>();
    if (autenticacao.carregando) {
      return carregando();
    } else if (autenticacao.usuario == null) {
      return TelaLogin();
    } else {
      return TelaLogin();
    }
  }

  Widget carregando() {
    return const Scaffold(
        body: Center(
      child: CircularProgressIndicator(),
    ));
  }
}
