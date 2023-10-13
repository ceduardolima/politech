import 'package:flutter/material.dart';
import 'package:politech/paginas/cadastro_turma_pagina.dart';
import 'package:politech/servicos/servico_autenticacao.dart';
import 'package:politech/theme/colors_theme.dart';
import 'package:politech/widgets/dialogs/dialog_cuidado.dart';
import 'package:provider/provider.dart';

import '../widgets/botoes/menu_principal_botoes.dart';

class MenuPrincipalPagina extends StatefulWidget {
  const MenuPrincipalPagina({super.key});

  @override
  State<MenuPrincipalPagina> createState() => _EstadoMenuPrincipal();
}

class _EstadoMenuPrincipal extends State<MenuPrincipalPagina> {
  _EstadoMenuPrincipal();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Nome do Usuario",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        primary: true,
        leading: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Icon(
            Icons.account_circle_sharp,
            size: 40,
          ),
        ),
        toolbarHeight: 80,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(80),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () => showDialog(
                    context: context,
                    builder: (context) => DialogCuidado(
                      onClick: () {
                        context.watch<ServicoAutenticacao>().logout();
                      },
                      texto: "Tem certeza que deseja sair?",
                      textoBotao: "Sair",
                    ),
                  ),
              icon: const Icon(
                Icons.logout,
                size: 30,
                color: Colors.white,
              ))
        ],
        elevation: 0.0,
      ),
      body: _ContainerCurvo(
        child: Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 40,
            mainAxisSpacing: 30,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              MeuPrincipalBotao(
                onClick: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TelaCadastroTurma(),
                    ),
                  ),
                titulo: "Turmas",
                icone: Icons.school,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ContainerCurvo extends StatelessWidget {
  const _ContainerCurvo({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: ColorsTheme().lightColorsScheme().primary,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.0),
            ),
          ),
          child: child,
        )
      ],
    );
  }
}
