import 'package:flutter/material.dart';
import 'package:politech/domain/turma/turma.dart';
import 'package:politech/paginas/chamada_pagina.dart';
import 'package:politech/widgets/botoes/menu_botao.dart';

class TurmaMenuPagina extends StatelessWidget {
  const TurmaMenuPagina({super.key, required this.turma});

  final Turma turma;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        primary: true,
        title: Text("${turma.codigo} - ${turma.nome}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 20,
          children: [
            MeuPrincipalBotao(
              onClick: () =>
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChamadaPagina(turma: turma),
                  ),
                ),
              titulo: "Chamada",
              imagem: const AssetImage("assets/icones/chamada.png"),
            ),
            MeuPrincipalBotao(
              onClick: () {},
              titulo: "Presenças",
              icone: Icons.check_circle_outline,
            ),
          ],
        ),
      ),
    );
  }
}
