import 'package:flutter/material.dart';
import 'package:politech/domain/chamada/chamada.dart';
import 'package:politech/domain/turma/turma.dart';
import 'package:politech/viewModels/chamada_view_model.dart';
import 'package:politech/widgets/botoes/criar_floating_action_button.dart';
import 'package:politech/widgets/itens_lista/chamada_item_lista.dart';
import 'package:provider/provider.dart';

class ChamadaPagina extends StatelessWidget {
  ChamadaPagina({super.key, required this.turma}) {
    title = "Chamada de ${turma.nome}";
  }

  final Turma turma;
  late ChamadaViewModel chamadaViewModel;
  late final String title;

  @override
  Widget build(BuildContext context) {
    chamadaViewModel = context.watch<ChamadaViewModel>();
    chamadaViewModel.assistirChamada(turma.id);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        primary: true,
        title: Text(
          title,
          style: const TextStyle(fontSize: 24.0),
        ),
        toolbarHeight: 80.0,
      ),
      floatingActionButton: CriarFloatActionButton(
        label: "Chamada",
        onPressed: () async {
          await chamadaViewModel.inserir(Chamada.genId(DateTime.now(), turma.id));
        },
      ),
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
                  onPressed: () {},
                  onDelete: () {},
                );
              }),
        ),
      ),
    );
  }
}
