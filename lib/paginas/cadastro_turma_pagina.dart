import 'package:politech/paginas/turma_menu_pagina.dart';
import 'package:politech/servicos/servico_realtime_database.dart';
import 'package:politech/theme/colors_theme.dart';
import 'package:flutter/material.dart';
import 'package:politech/viewModels/aluno_view_model.dart';
import 'package:politech/viewModels/chamada_view_model.dart';
import 'package:politech/viewModels/db_view_model.dart';
import 'package:politech/viewModels/horario_view_model.dart';
import 'package:politech/viewModels/turma_view_model.dart';
import 'package:politech/widgets/botoes/criar_floating_action_button.dart';
import 'package:politech/widgets/dialogs/dialog_adicionar_turma.dart';
import 'package:politech/widgets/dialogs/dialog_cuidado.dart';
import 'package:politech/widgets/itens_lista/turma_item_lista.dart';
import 'package:provider/provider.dart';

import '../domain/turma/turma.dart';
import '../viewModels/presenca_view_model.dart';

class TelaCadastroTurma extends StatelessWidget {
  TelaCadastroTurma({Key? key}) : super(key: key);
  late DbViewModel dbViewModel;

  late ServicoRealTimeDatabase db;

  _sincronizar(BuildContext context) async {
    Map? turmasMap = await db.pesquisarTurmas("adm@gmail.com");
    if (turmasMap != null) {
      final turmasForamCadastradas =
          await dbViewModel.cadastrarTurmasUsandoMap(turmasMap);
      String mensagem = turmasForamCadastradas
          ? "As turma foram baixadas com sucesso!"
          : "Não há mais turmas para baixar";
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(mensagem),
          ),
        );
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Nenhuma turma foi encontrada"),
          ),
        );
      }
    }
  }

  _excluirTurma(Turma turma) {
    dbViewModel.excluirTurma(turma);
  }

  @override
  Widget build(BuildContext context) {
    dbViewModel = context.watch<DbViewModel>();
    db = context.watch<ServicoRealTimeDatabase>();
    dbViewModel.turmaViewModel.assistirListaDeTurmas();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Turma'),
        backgroundColor: ColorsTheme().lightColorsScheme().primary,
        actions: [
          IconButton(
              onPressed: () => _sincronizar(context),
              icon: const Icon(Icons.sync_rounded))
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: dbViewModel.turmaViewModel.listaDeTurmas.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10.0),
          itemBuilder: (context, index) {
            final turma = dbViewModel.turmaViewModel.listaDeTurmas[index];
            return TurmaItemLista(
              turma: turma,
              excluirTurma: () {
                showDialog(
                  context: context,
                  builder: (context) => DialogCuidado(
                      texto:
                          "Excluindo uma turma, você também excluirá todas as"
                          " chamadas feitas até o momento.\n\n"
                          "Tem certeza que deseja excluir a turma?",
                      textoBotao: "Excluir",
                      onClick: () => _excluirTurma(turma)),
                );
              },
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TurmaMenuPagina(
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
