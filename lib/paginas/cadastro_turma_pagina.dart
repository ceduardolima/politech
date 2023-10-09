import 'package:politech/paginas/chamada_pagina.dart';
import 'package:politech/paginas/login_pagina.dart';
import 'package:politech/theme/colors_theme.dart';
import 'package:flutter/material.dart';
import 'package:politech/viewModels/chamada_view_model.dart';
import 'package:politech/viewModels/turma_view_model.dart';
import 'package:politech/widgets/botoes/criar_floating_action_button.dart';
import 'package:politech/widgets/dialogs/dialog_adicionar_turma.dart';
import 'package:politech/widgets/dialogs/dialog_cuidado_excluir.dart';
import 'package:politech/widgets/itens_lista/turma_item_lista.dart';
import 'package:provider/provider.dart';

import '../domain/turma/turma.dart';

class TelaCadastroTurma extends StatefulWidget {
  TelaCadastroTurma({Key? key}) : super(key: key);

  @override
  _TelaCadastroTurmaState createState() => _TelaCadastroTurmaState();
}

class _TelaCadastroTurmaState extends State<TelaCadastroTurma> {
  late TurmaViewModel turmaViewModel;
  late ChamadaViewModel chamadaViewModel;

  void excluirTurma(Turma turma) {
    turmaViewModel.excluir(turma);
  }

  void inserirTurma(Turma turma) {
    turmaViewModel.inserir(turma);
  }

  void _mostrarDialogAdicionarTurma(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogAdicionarTurma(adicionar: (turma) => inserirTurma(turma));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    turmaViewModel = context.watch<TurmaViewModel>();
    chamadaViewModel = context.watch<ChamadaViewModel>();
    turmaViewModel.assistirListaDeTurmas();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Turma'),
        backgroundColor: ColorsTheme().lightColorsScheme().primary,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: CriarFloatActionButton(
        onPressed: () => _mostrarDialogAdicionarTurma(context),
        label: 'Turma',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: turmaViewModel.listaDeTurmas.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10.0),
          itemBuilder: (context, index) {
            final turma = turmaViewModel.listaDeTurmas[index];
            return TurmaItemLista(
              turma: turma,
              excluirTurma: () {
                showDialog(
                  context: context,
                  builder: (context) => DialogCuidadoExcluir(
                    excluir: () {
                      chamadaViewModel.excluirChamadaDaTurma(turma.id);
                      turmaViewModel.excluir(turma);
                    },
                  ),
                );
              },
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChamadaPagina(
                      turma: turma,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
