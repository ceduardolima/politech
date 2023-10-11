import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:politech/domain/chamada/chamada.dart';
import 'package:politech/domain/turma/turma.dart';
import 'package:politech/theme/colors_theme.dart';
import 'package:politech/viewModels/aluno_view_model.dart';
import 'package:politech/viewModels/chamada_view_model.dart';
import 'package:politech/viewModels/presenca_view_model.dart';
import 'package:politech/viewModels/turma_view_model.dart';
import 'package:politech/widgets/botoes/criar_floating_action_button.dart';
import 'package:politech/widgets/dialogs/dialog_botao_unico.dart';
import 'package:politech/widgets/dialogs/dialog_mostrar_presenca.dart';
import 'package:politech/widgets/itens_lista/chamada_item_lista.dart';
import 'package:provider/provider.dart';

import '../domain/aluno/aluno.dart';

class ChamadaPagina extends StatelessWidget {
  ChamadaPagina({super.key, required this.turma}) {
    title = "Chamada de ${turma.nome}";
  }

  final Turma turma;
  final _chaveChamada = GlobalKey<FormBuilderState>();
  late PresencaViewModel presencaViewModel;
  late ChamadaViewModel chamadaViewModel;
  late TurmaViewModel turmaViewModel;
  late final String title;

  /// Faz a chamada dos alunos presentes
  Future<void> criarChamada(List<String> chamadaJson) async {
    final hoje = DateTime.now();
    final chamada = Chamada.genId(hoje, turma.id);
    await chamadaViewModel.inserir(chamada);
    await presencaViewModel.inserirAlunosPresentes(
        chamada.id, hoje, chamadaJson);
  }

  String _limitandoTexto(String texto) =>
    texto.length > 20 ? "${texto.substring(0, 25)}..." : texto;

  /// Transforma a lista de alunos em uma FormBuilderFieldOption Para ser usada
  /// no FormBuilderFieldOption
  List<FormBuilderFieldOption<String>> listaAlunoParaListaOption(
          List<Aluno> alunos) =>
      alunos
          .map((aluno) => FormBuilderFieldOption(
                value: aluno.id,
                child: Row(
                  children: [
                    const Spacer(),
                    Text(
                      _limitandoTexto(aluno.nome),
                      style: const TextStyle(fontSize: 16, ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ))
          .toList(growable: false);

  /// Cria a diallog onde será feita a chamada
  void criarDialogChamada(BuildContext context, List<Aluno> alunos) {
    final hoje = DateTime.now();
    showDialog(
      context: context,
      builder: (context) => DialogBotaoUnico(
        titulo: "${hoje.day}/${hoje.month}/${hoje.year}",
        confirmar: () async {
          final currentState = _chaveChamada.currentState;
          if (currentState != null) {
            _chaveChamada.currentState!.save();
            final chamadaJson = currentState.value["chamada"];
            await criarChamada(chamadaJson);
            if (context.mounted) {
              Navigator.pop(context);
            }
          }
        },
        fecharDialog: () => Navigator.pop(context),
        filho: FormBuilder(
          key: _chaveChamada,
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Presença", style: TextStyle(fontSize: 18)),
                  Text("Aluno", style: TextStyle(fontSize: 18)),
                ],
              ),
              const Divider(color: Colors.grey, thickness: 1.2),
              FormBuilderCheckboxGroup(
                name: "chamada",
                orientation: OptionsOrientation.vertical,
                wrapSpacing: 100,
                options: listaAlunoParaListaOption(alunos),
              ),
              Container(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  /// Cria as viewModels que dao acesso ao banco de dados
  void criarViewModels(BuildContext context) {
    chamadaViewModel = context.watch<ChamadaViewModel>();
    turmaViewModel = context.watch<TurmaViewModel>();
    presencaViewModel = context.watch<PresencaViewModel>();
    turmaViewModel.listarAlunos(turma.id);
    chamadaViewModel.assistirChamada(turma.id);
  }

  @override
  Widget build(BuildContext context) {
    criarViewModels(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        primary: true,
        title: Text(
          title,
          style: const TextStyle(fontSize: 24.0),
        ),
      ),
      floatingActionButton: CriarFloatActionButton(
          label: "Chamada",
          onPressed: () => criarDialogChamada(context, turmaViewModel.alunos)),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListView.builder(
              itemCount: chamadaViewModel.listaChamadas.length,
              itemBuilder: (context, index) {
                Chamada chamada = chamadaViewModel.listaChamadas[index];
                return ChamadaItemLista(
                  chamada: chamada,
                  onPressed: () async {
                    final chamadaData = chamada.data;
                    final alunos = await presencaViewModel
                        .listarAlunosDaChamada(chamada.id, true);
                    if (context.mounted) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return DialogMostrarPresenca(
                            alunos: alunos,
                            data:
                                "${chamadaData.day}/${chamadaData.month}/${chamadaData.year}",
                          );
                        },
                      );
                    }
                  },
                  onDelete: () async {
                    await presencaViewModel.excluirPresencaDaChamada(chamada.id);
                    await chamadaViewModel.excluir(chamada);
                  },
                );
              }),
        ),
      ),
    );
  }
}
